function [soundOut, froot] = create_chord( chordType,temperament, root, constants )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%    [ soundOut ] = create_scale( chordType,temperament, root, constants )
% 
% This function creates the sound output given the desired type of chord
%
% OUTPUTS
%   soundOut = The output sound vector
%
% INPUTS
%   chordType = Must support 'Major' and 'Minor' at a minimum
%   temperament = may be 'just' or 'equal'
%   root = The Base frequeny (expressed as a letter followed by a number
%       where A4 = 440 (the A above middle C)
%       See http://en.wikipedia.org/wiki/Piano_key_frequencies for note
%       numbers and frequencies
%   constants = the constants structure
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Constants
durationChord = constants.durationChord;
fs = constants.fs;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


switch chordType
    case {'Major','major','M','Maj','maj'}
        keys = [4,7]; % which keys are pressed. Numbers indicate number of semitones away from root.
        numNotes = 3; % number of notes in chord
    case {'Minor','minor','m','Min','min'}
        keys = [3,7];
        numNotes = 3;
    case {'Power','power','pow'}
        keys = [7];
        numNotes = 2;
    case {'Sus2','sus2','s2','S2'}
        keys = [2,7];
        numNotes = 3;
    case {'Sus4','sus4','s4','S4'}
        keys = [5,7];
        numNotes = 3;
    case {'Dom7','dom7','Dominant7', '7'}
        keys = [4,7,10];
        numNotes = 4;
    case {'Min7','min7','Minor7', 'm7'}
         keys = [3,7,10];
         numNotes = 4;
    otherwise
        error('Inproper chord specified');
end

% Temperament
switch temperament
    case {'just','Just'}
        fmult = sort([(2/3)^5*8,(2/3)^4*8,(2/3)^3*4,(2/3)^2*4,(2/3)*2, 1,...
            1.5, 1.5^2/2, 1.5^3/2, 1.5^4/4, 1.5^5/4, 1.5^6/8, 2]); % Pythagorean tuning (dropping augmented and diminished intervals).
    case {'equal','Equal'}
        fmult = sort([(2^(0/12)),(2^(1/12)),(2^(2/12)),(2^(3/12)),...
            (2^(4/12)),(2^(5/12)),(2^(6/12)),(2^(7/12)),(2^(8/12)),(2^(9/12)),...
            (2^(10/12)),(2^(11/12)),(2^(12/12))]); % Equal tempered tuning based on twelvth root of 2
    otherwise
        error('Improper temperament specified')
end

switch root
    case {'C'}
        froot = 261.6256 % from wikipedia link
    case {'C#', 'Db'}
        froot = 277.1826
    case {'D'}
        froot = 293.6648
    case {'D#','Eb'}
        froot = 311.1270
    case {'E'}
        froot = 329.6276	
    case {'F'}
        froot = 349.2282
    case {'F#','Gb'}
        froot = 369.9944
    case {'G'}
        froot = 391.9954
    case {'G#','Ab'}
        froot = 415.3047
    case {'A'}
        froot = 440.0000
    case {'A#','Bb'}
        froot = 466.1638
    case {'B'} 
        froot = 493.8833	
    otherwise
        error('Invalid Root')
end

% Initialize
freqs = zeros(1,numNotes);
t = 0:1/(fs):durationChord; 

% Fill freqs
freqs(1) = froot;
for i = 1:length(keys)
    freqs(i+1) = freqs(1)*fmult(keys(i)+1);
end
w = 2*pi*freqs;

% Create sound waveform
soundWave = zeros(1,length(t));
soundWave = sum(sin(w'*t)); % sum the sin waves for simultaneous play
% Complete with chord vectors
soundOut = soundWave;

end
