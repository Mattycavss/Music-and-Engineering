classdef objSynth < matlab.System
    properties
        notes;
        oscConfig                   = confOsc;
        constants                   = confConstants;
    end
    
    % Pre-computed constants
    properties(Access = private)
        currentTime;
        arrayNotes                  = objNote;
        arraySynths                 = {objOsc};
        patch

    end
    
    methods
        function obj = objSynth(varargin)
            % This section handles the "per note" actions. 
            setProperties(obj,nargin,varargin{:},'notes','oscConfig','constants');
            obj.arrayNotes=obj.notes.arrayNotes;
            
%             decay = obj.notes.attack;
            for cntNote=1:length(obj.arrayNotes)
%                 obj.oscConfig.oscAmpEnv.AttackTime         = 0.01;  
%                 obj.oscConfig.oscAmpEnv.ReleaseTime        = .05;
%                 obj.oscConfig.oscAmpEnv.DecayTime          = .05;
                
                switch obj.notes.patch(cntNote)
                    case 1
                        obj.oscConfig.oscType                      = 'sine';
                        
                    case 2
                        obj.oscConfig.oscType                      = 'square';
                        
                    case 3
                        obj.oscConfig.oscType                      = 'clarinet';
                        
                    case 4
                        obj.oscConfig.oscType                      = 'bell';
                        
                    otherwise
                        error('invalid instrument')
                end                

                obj.oscConfig.oscAmpEnv.AttackTime = obj.notes.attack(cntNote)/2;
                obj.oscConfig.oscAmpEnv.DecayTime = obj.notes.attack(cntNote)/2;
                obj.oscConfig.oscAmpEnv.ReleaseTime = obj.notes.release(cntNote);
                obj.arraySynths{cntNote}=objOsc(obj.arrayNotes(cntNote),obj.oscConfig,obj.constants, ...
                    obj.notes.noteDuration, obj.notes.breathDuration, obj.notes.patch, obj.notes.pitchInfo, ...
                    obj.notes.ampInfo);
            end
        end
    end
    
    
    methods(Access = protected)

        function setupImpl(obj)
            obj.currentTime=0;
        end
        
        function audioAccumulator = stepImpl(obj)
            % Implement algorithm.
            audioAccumulator=[];
            for cntNote = 1:length(obj.arrayNotes)
                
                %audio = obj.arraySynths(cntNote).advance;
                audio = step(obj.arraySynths{cntNote});
                
                %audio = step(obj.arraySynths(cntNote));
                if ~isempty(audio)
                    if isempty(audioAccumulator)
                        audioAccumulator=audio;
                    else
                        audioAccumulator=audioAccumulator+audio;
                    end
                end
                
            end

        end
        
        function resetImpl(obj)
            % Reset the time function
            obj.currentTime=0;
        end
    end
end
