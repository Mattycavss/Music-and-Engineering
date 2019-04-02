classdef objOsc < matlab.System
    % untitled2 Add summary here
    %
    % This template includes the minimum set of functions required
    % to define a System object with discrete state.

    % Public, tunable properties
    properties
        % Defaults
        note                        = objNote;
        oscConfig                   = confOsc;
        constants                   = confConstants;
        instrument
        noteDuration
        breathDuration
        attack
        pitchInfo
        ampInfo
        pitchBend
        ampMod
        decay
        ia
        ib
    end

    % Pre-computed constants
    properties(Access = private)
        % Private members
        currentTime;
        EnvGen                = objEnv;
    end
    
    methods
        function obj = objOsc(varargin)
            % This section handles the "per buffer" commands.
            if nargin > 0
                setProperties(obj,nargin,varargin{:},'note','oscConfig','constants','noteDuration', ...
                    'breathDuration', 'instrument', 'attack', 'pitchInfo', 'ampInfo');
                obj.pitchInfo = varargin{7};
                obj.ampInfo = varargin{8};
                tmpEnv=confEnv(obj.note.startTime,obj.note.endTime,...
                    obj.oscConfig.oscAmpEnv.AttackTime,...
                    obj.oscConfig.oscAmpEnv.DecayTime,...
                    obj.oscConfig.oscAmpEnv.SustainLevel,...
                    obj.oscConfig.oscAmpEnv.ReleaseTime);
                obj.EnvGen=objEnv(tmpEnv,obj.constants);
            end
        end
    end

    methods(Access = protected)
        function setupImpl(obj)
            obj.currentTime=0;
        end
        
        function [out] = pitch_bend(obj)
            pitchbends = obj.pitchInfo{1,obj.ib};
            pitchtimes = obj.pitchInfo{2,obj.ib};
            if isempty(pitchbends)
                out = 1;
                return 
            end
            ic = 1;
            if obj.currentTime < pitchtimes(ic)
                out = 1;
                return
            else
                    while obj.currentTime >= pitchtimes(ic)
                        out = pitchbends(ic);
                        ic = ic+1;
                        if ic > length(pitchtimes)
                            break
                        end
                    end
                
            end
        end
        
        function [out] =  amp_mod(obj)
            disp('no')
            fprintf(obj);
            out = 1;
        end
        
        function audio = stepImpl(obj)
%             durNote = (obj.noteDuration+obj.breathDuration);
%             if (obj.currentTime >= sum(durNote(1:obj.ia)))
%                 obj.ib = 0;
%                 while obj.currentTime >= sum(durNote(1:obj.ib))
%                     if obj.currentTime > sum(durNote)
%                         audio = [];
%                         return
%                     end
%                     obj.ib = obj.ib + 1;
%                 end 
%                 switch obj.instrument(obj.ib)
%                     case 1
%                         obj.oscConfig.oscType                      = 'sine';
%                         
%                     case 2
%                         obj.oscConfig.oscType                      = 'square';
%                         
%                     case 3
%                         obj.oscConfig.oscType                      = 'clarinet';
%                         
%                     case 4
%                         obj.oscConfig.oscType                      = 'bell';
%                         
%                     otherwise
%                         error('invalid instrument')
%                 end
%             end
            %%%%%%%%%%%%%%%%%%%%%%%%%%
%             obj.pitchBend = obj.pitch_bend();
%             obj.pitchBend = 1;
%             obj.ampMod = obj.amp_mod();
%             oldfreq = obj.note.frequency;
%             oldamp = obj.note.amplitude
%             obj.note.frequency = obj.note.frequency * obj.pitchBend;
%             obj.note.amplitude = obj.note.amplitude * obj.ampMod;  
            %%%%%%%%%%%%%%%%%%%%%%%%%%
            
            timeVec=(obj.currentTime+(0:(1/obj.constants.SamplingRate):((obj.constants.BufferSize-1)/...
                obj.constants.SamplingRate))).';
            mask = step(obj.EnvGen);
            if isempty(mask)
                audio=[];
            else
                if all (mask == 0)
                    audio = zeros(1,obj.constants.BufferSize).';
                else
                    switch obj.oscConfig.oscType
                        case "sine"
                            audio=obj.note.amplitude.*mask(:).*sin(2*pi*obj.note.frequency*timeVec);
                        case "square"
                            audio=obj.note.amplitude.*mask(:).*square(2*pi*obj.note.frequency*timeVec);
                        case "clarinet"
                            fs = obj.constants.fs;
                            durNote = (obj.noteDuration+obj.breathDuration);
                            if (obj.currentTime >= sum(durNote(1:obj.ia)))
                                obj.ia = 0;
                                while obj.currentTime >= sum(durNote(1:obj.ia))
                                    obj.ia = obj.ia + 1;
                                    if obj.currentTime > sum(durNote)
                                       break 
                                    end
                                end 
                                obj.oscConfig.bufferIndex = 1;
                            end
                            dur = durNote(obj.ia);
                            t = 0:(1/fs):dur;
                            t(end) = [];
                            ADSR = zeros(1,length(t));
                            R = 0.085; A = 255; D = 0.64;
                            slopeRise = A/(R*dur*fs);
                            slopeDecay = -A/(D*dur*fs);
                            lenRise = 1:floor(R*dur*fs);
                            lenSus = floor(R*dur*fs)+1:floor((1-D)*dur*fs);
                            lenDecay = floor((1-D)*dur*fs)+1:dur*fs;
                            ADSR(lenRise) = cumsum(slopeRise*ones(1,floor(R*dur*fs)));
                            ADSR(lenSus) = ones(1,floor((1-D)*dur*fs)-floor(R*dur*fs))*A;
                            ADSR(round(lenDecay)) = cumsum(slopeDecay*ones(1,floor(dur*fs)-floor((1-D)*dur*fs)))+A;
                            w = 2*pi*obj.note.frequency;
                            wave= repmat(ADSR,size(1,1),1).*sin(w'*t);
                            wave = wave+256;
                            waveShape = zeros(1,length(t));
                            for ic = 1:length(obj.note.frequency)
                                gainA = (-0.5+1)/(200);
                                gainB = (0.5+0.5)/(312-200);
                                gainC = (1-0.5)/(511-312);
                                for id = 1:fs*dur
                                    if wave(ic,id)<=200
                                        waveShape(ic,id) = wave(ic,id)*gainA + -1; % mult by slope and add y intercept
                                    elseif wave(ic,id)>200 && wave(ic,id)<=312
                                        waveShape(ic,id) = wave(ic,id)*gainB + (-0.5-gainB*200);
                                    elseif wave(ic,id)>312 && wave(ic,id)<=511
                                        waveShape(ic,id) = wave(ic,id)*gainC + (0.5-gainC*312);
                                    end
                                end
                            end
                            if obj.oscConfig.bufferIndex+obj.constants.BufferSize > length(waveShape)
                                audio = zeros((obj.constants.BufferSize),1);
                                audio(1:length(waveShape)-obj.oscConfig.bufferIndex) = ...
                                    waveShape(obj.oscConfig.bufferIndex+1:end);
                            else
                                audio = waveShape(obj.oscConfig.bufferIndex+1:obj.oscConfig.bufferIndex+...
                                    obj.constants.BufferSize)'.*mask(:);
                                obj.oscConfig.bufferIndex = obj.oscConfig.bufferIndex + obj.constants.BufferSize;
                            end
                        case "bell"                            
                            durNote = (obj.noteDuration+obj.breathDuration);
                            constant.t = timeVec;
                            damp = 4;
                            fratio = 10; 
                            d = 0.001;
                            constant.phase = 0;
                            if (obj.currentTime >= sum(durNote(1:obj.ia)))
                               obj.ia = 0;
                                while obj.currentTime >= sum(durNote(1:obj.ia))
                                    obj.ia = obj.ia + 1;
                                    if obj.currentTime>sum(durNote)
                                        break 
                                    end
                                end 
                               obj.oscConfig.bufferIndex = 1;
                               t = 0:1/obj.constants.fs:durNote(obj.ia);
                               obj.decay = 1./exp(damp*(t));
                            end
                            t = 0:1/obj.constants.fs:durNote(obj.ia);
                            obj.decay = 1./exp(damp*(t)); 
                            obj.decay = obj.decay';
                            fm = obj.note.frequency/fratio; 
                            if obj.oscConfig.bufferIndex+obj.constants.BufferSize > length(obj.decay)
                                F1 = zeros(length(obj.constants.BufferSize),1);
                                index = round(length(obj.decay) - obj.oscConfig.bufferIndex);
                                if index == 0
                                    audio = zeros((obj.constants.BufferSize),1);
                                else
                                    osc1 = oscillator(8, 2, constant);
                                    F1 = osc1(index).*obj.decay(index);
                                    osc2 = oscillator(8, d, constant);
                                    F2 = osc2(index).*obj.decay(index);
                                    Fm = oscillator(fm, F2, constant);
                                    out = oscillatorFM(Fm'+obj.note.frequency, F1', constant)'.*mask(:);
                                    audio = zeros((obj.constants.BufferSize),1);
                                    audio(1:length(out)-obj.oscConfig.bufferIndex) = ...
                                        out(obj.oscConfig.bufferIndex+1:end);
                                end
                            else
                                F1 = oscillator(8, 2, constant).*obj.decay(obj.oscConfig.bufferIndex+1:...
                                    obj.oscConfig.bufferIndex+obj.constants.BufferSize);
                                F2 = oscillator(8, d, constant).*obj.decay(obj.oscConfig.bufferIndex+1:...
                                    obj.oscConfig.bufferIndex+obj.constants.BufferSize);
                                Fm = oscillator(fm, F2, constant);
                                audio = oscillatorFM(Fm'+obj.note.frequency, F1', constant)'.*mask(:);
                                obj.oscConfig.bufferIndex = obj.oscConfig.bufferIndex + obj.constants.BufferSize;
                             end

                        otherwise 
                            error('Improper oscType')
                    end
                end
            end
%             obj.note.amplitude = oldamp;
%             obj.note.frequency = oldfreq;  % This would have been for
%             pitch bending but the script is too slow as is
            obj.currentTime=obj.currentTime+(obj.constants.BufferSize/obj.constants.SamplingRate);

        end

        function resetImpl(obj)
            % Initialize / reset discrete-state properties
            % Reset the time function
            obj.currentTime=0;
        end
    end
end
