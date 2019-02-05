function [soundOut] = create_scale( scaleType,temperament, root, constants )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%    [ soundOut ] = create_scale( scaleType,temperament, root, constants )
% 
% This function creates the sound output given the desired type of scale
%
% OUTPUTS
%   soundOut = The output sound vector
%
% INPUTS
%   scaleType = Must support 'Major' and 'Minor' at a minimum
%   temperament = may be 'just' or 'equal'
%   root = The Base frequeny (expressed as a letter followed by a number
%       where A4 = 440 (the A above middle C)
%       See http://en.wikipedia.org/wiki/Piano_key_frequencies for note
%       numbers and frequencies
%   constants = the constants structure
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Constants
durationScale = constants.durationScale;
fs = constants.fs;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Scale
melodic = 0; % NOT melodic minor scale. Need this to increase the length of time the scale is playing
switch scaleType
    case {'Major','major','M','Maj','maj'}
        keys = cumsum([2,2,1,2,2,2 1]); % add up all the intervals to achieve each frequency
    case {'Minor','minor','m','Min','min'}
        keys = cumsum([2,1,2,2,1,2 2]);
    case {'Harmonic', 'harmonic', 'Harm', 'harm'}
        keys = cumsum([2,1,2,2,1,3 1]);
    case {'Melodic', 'melodic', 'Mel', 'mel'}
        melodic = 1 % Melodic minor scale is true
        keys = cumsum([2,1,2,2,2,2 1, -2, -2, -1, -2, -2, -1, -2]);
    otherwise
        error('Inproper scale specified');
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
numNotes = 8; % depending on type of scale, the audio must play more/less notes
if melodic == 1
    numNotes = 15;
end
freqs = zeros(1,numNotes);
t = 0:1/(fs):durationScale*numNotes; % altering length of the scale

% Fill freqs
freqs(1) = froot;
for i = 1:length(keys)
    freqs(i+1) = freqs(1)*fmult(keys(i)+1); % multiply fundamental by index of fmult, determined by the key number in the scale. 
                                            % (eg: notes in major chord are 0, 4, 7 semitones away from fundamental.)
end
w = 2*pi*freqs; % rads

% Create sound waveform
soundWave = zeros(1,length(t));
for i = 1:numNotes
    ind1 = length(t)/numNotes*(i-1)+1; % Portion of tsamp vector taken up that note 
    ind2 = length(t)/numNotes*i;
    soundWave(ind1:ind2) = sin(w(i)*t(ind1:ind2));
end

soundOut = soundWave;

end
