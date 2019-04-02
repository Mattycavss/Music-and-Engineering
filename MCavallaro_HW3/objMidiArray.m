% First draft a Scale Object

classdef objMidiArray
    properties
        % Must be provided
        noteNums                    = [];
        startTimes                  = [];
        numQuarterNotes             = [];
        tempo                       = 120;
        amplitudes                  = [];
        key                         = 'C';
        fs                          = 44100;
        patch
        attack
        release
        pitchInfo
        ampInfo
        
        % Defaults
        noteDurationFraction        = 0.8;                        
        breathDurationFraction      = 0.2;                       
        temperament                 = 'Equal';
            
        % Calculated
        secondsPerQuarterNote                                    
        noteDuration                                             
        breathDuration                                           
        arrayNotes                  = objNote.empty;             
    end
  
    methods
        function obj = objMidiArray(varargin)
            
            % Map the variable inputs to the class
            if length(varargin) ~= 10
                error('Must have 10 inputs')
            end
            obj.noteNums=varargin{1};
            obj.startTimes=varargin{2};
            obj.numQuarterNotes=varargin{3};
            obj.tempo=varargin{4};
            obj.amplitudes=varargin{5};
            obj.key=varargin{6};
            obj.patch=varargin{7};
            obj.attack=varargin{8};
            obj.release=varargin{9};
            obj.pitchInfo=varargin{10};
%             obj.ampInfo=varargin{11};
            
            % Compute some constants based on inputs
            obj.secondsPerQuarterNote       = 60/obj.tempo;  
            
            % Walk through the offsets and build the scale
            for ia=1:(length(obj.noteNums))              
                obj.noteDuration(ia) = obj.noteDurationFraction...
                    *obj.secondsPerQuarterNote*obj.numQuarterNotes(ia);         
                obj.breathDuration(ia) = obj.breathDurationFraction...
                    *obj.secondsPerQuarterNote*obj.numQuarterNotes(ia);         
                obj.arrayNotes(ia) = objNote(obj.noteNums(ia),  obj.temperament,...
                                     obj.key,  obj.startTimes(ia),   obj.startTimes(ia)+ ...
                                     obj.noteDuration(ia),   obj.amplitudes(ia));                 
            end
        end
    end
end
