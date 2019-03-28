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
        bell
        clarinet
        noteDuration
        breathDuration
        f
        a                           = 0;
        decay
        decay2
        ia
    end

    % Pre-computed constants
    properties(Access = private)
        % Private members
        currentTime;
        EnvGen                = objEnv;
    end
    
    methods
        function obj = objOsc(varargin)
            %Constructor
            if nargin > 0
                setProperties(obj,nargin,varargin{:},'note','oscConfig','constants','noteDuration', 'breathDuration');
                
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
            % Perform one-time calculations, such as computing constants
            
            % Reset the time function
            obj.currentTime=0;
        end

        function audio = stepImpl(obj)
%             obj.EnvGen.StartPoint=obj.note.startTime;   % set the end point again in case it has changed
%             obj.EnvGen.ReleasePoint=obj.note.endTime;   % set the end point again in case it has changed
            
            timeVec=(obj.currentTime+(0:(1/obj.constants.SamplingRate):((obj.constants.BufferSize-1)/obj.constants.SamplingRate))).';
            noteTime=timeVec-obj.note.startTime;
            
            %mask = obj.EnvGen.advance;
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
                                end 
                               obj.oscConfig.bufferIndex = 1;
                            end
                            dur = durNote(obj.ia)
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
                                for ib = 1:fs*dur
                                    if wave(ic,ib)<=200
                                        waveShape(ic,ib) = wave(ic,ib)*gainA + -1; % mult by slope and add y intercept
                                    elseif wave(ic,ib)>200 && wave(ic,ib)<=312
                                        waveShape(ic,ib) = wave(ic,ib)*gainB + (-0.5-gainB*200);
                                    elseif wave(ic,ib)>312 && wave(ic,ib)<=511
                                        waveShape(ic,ib) = wave(ic,ib)*gainC + (0.5-gainC*312);
                                    end
                                end
                            end
                            audio = waveShape(obj.oscConfig.bufferIndex+1:obj.oscConfig.bufferIndex+obj.constants.BufferSize)'.*mask(:);
                            obj.oscConfig.bufferIndex = obj.oscConfig.bufferIndex + obj.constants.BufferSize;
                            
                        case "bell"                            
                            durNote = (obj.noteDuration+obj.breathDuration);
                            constants.t = timeVec; %#ok<PROP>
                            damp = 7;
                            fratio = 100; 
                            d = 0.001;
                            constants.phase = 0;
                            if (obj.currentTime >= sum(durNote(1:obj.ia)))
                               obj.ia = 0;
                                while obj.currentTime >= sum(durNote(1:obj.ia))
                                    obj.ia = obj.ia + 1;
                                end 
                               obj.oscConfig.bufferIndex = 1;
                               t = 0:1/obj.constants.fs:durNote(obj.ia);
                               obj.decay = 1./exp(damp*(t));
%                                figure
%                                plot(obj.decay)
                            end
                            t = 0:1/obj.constants.fs:durNote(obj.ia);
                            obj.decay = 1./exp(damp*(t)); 
                            obj.decay2 = 5*sin(t);
                            obj.decay = obj.decay';
                            obj.decay2 = obj.decay2'
                            obj.a = 0;
                            fm = obj.note.frequency/fratio; 
                            F1 = oscillator(2, 1, constants).*obj.decay(obj.oscConfig.bufferIndex+1:obj.oscConfig.bufferIndex+obj.constants.BufferSize).*obj.decay2(obj.oscConfig.bufferIndex+1:obj.oscConfig.bufferIndex+obj.constants.BufferSize);
                            F2 = oscillator(5, d, constants).*obj.decay(obj.oscConfig.bufferIndex+1:obj.oscConfig.bufferIndex+obj.constants.BufferSize).*obj.decay2(obj.oscConfig.bufferIndex+1:obj.oscConfig.bufferIndex+obj.constants.BufferSize);
                            Fm = oscillator(fm, F2, constants);
                            audio = oscillatorFM(Fm'+obj.note.frequency, F1', constants)'.*mask(:);
                            obj.oscConfig.bufferIndex = obj.oscConfig.bufferIndex + obj.constants.BufferSize;
                        otherwise 
                            error('Improper oscType')
                    end
                end
            end
            obj.currentTime=obj.currentTime+(obj.constants.BufferSize/obj.constants.SamplingRate);      % Advance the internal time

        end

        function resetImpl(obj)
            % Initialize / reset discrete-state properties
            % Reset the time function
            obj.currentTime=0;
        end
    end
end
