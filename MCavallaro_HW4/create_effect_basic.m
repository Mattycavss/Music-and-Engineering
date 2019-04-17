function [soundOut] = create_effect_basic(effect, note, chord, constants)
    % Initialize
    constants.fs=44100;                                                         % Sampling rate in samples per second
    constants.durationChord=4;                                                  % Duration of chords
    constants.t = 0:1/constants.fs:constants.durationChord;                     % Time vector
    constants.t(end) = [];                                                      % Remove last element
    constants.amplitude = 1;                                                    % Set amplitude
    
    root = note(1:end-1);                                                   % The root is a letter OR a letter followed by a sharp/flat.
    octave = str2double(note(end));                                         % The octave is the last char of the input and is used to mult/div the freq by a factor of 2
    amp = constants.amplitude;                                              % Setting default amplitude from constants struct
    dur = constants.durationChord;                                          % Setting up duration of soundOut
    fs = constants.fs;                                                      % Setting up sampling frequency
    t = constants.t;                                                        % Setting up time vector

    % Switch-Case for chord type
    switch chord
        case {'Major','major','M','Maj','maj'}
            keys = [4,7];                                                   % Which keys are pressed. Numbers indicate number of semitones away from root
            numNotes = 3;                                                   % Number of notes in chord
        case {'Minor','minor','m','Min','min'}
            keys = [3,7];
            numNotes = 3;
        case {'Power','power','pow'}
            keys = 7;
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
        case {'SingleNote', 'single'}                                       % Option for just a single note
            keys = [];
            numNotes = 1;
        otherwise
            error('Inproper chord specified');
    end
    
    % Switch-Case root frequency, relative to 440 Hz. Frequencies found for
    % equal temperament from wiki page
    switch root
            case {'C'}
                froot = 264.2981*2^(octave-4);                              % All root frequencies are defined in the 4th octave.
            case {'C#', 'Db'}
                froot = 278.4375*2^(octave-4);
            case {'D'}
                froot = 297.3354*2^(octave-4);
            case {'D#','Eb'}
                froot = 313.2422*2^(octave-4);
            case {'E'}
                froot = 330	*2^(octave-4);
            case {'F'}
                froot = 352.3975*2^(octave-4);
            case {'F#','Gb'}
                froot = 371.25*2^(octave-4);
            case {'G'}
                froot = 396.4471*2^(octave-4);
            case {'G#','Ab'}
                froot = 417.6563*2^(octave-4);
            case {'A'}
                froot = 440.0000*2^(octave-4);
            case {'A#','Bb'}
                froot = 469.8633*2^(octave-4);
            case {'B'} 
                froot = 495*2^(octave-4);
            otherwise
                error('Invalid Root')
    end
    
    % Building frequency array
    fmult = 2.^([0:12]/12);                                                 % Equal temperament frequency ratios
    freqs = zeros(1,numNotes);                                              % Initialize frequency array
    freqs(1) = froot;                                                       % First note in the array is the root frequency
    for ib = 1:length(keys)
        freqs(ib+1) = freqs(1)*fmult(keys(ib)+1);                           % Fills in notes of the chord
    end

    % Switch-Case the effect to fill soundOut
    switch effect
        case {'compresser'}
            soundOut = zeros(dur,1);
            disp('Compressor')
        case {'ringmod'}
            soundOut = zeros(dur,1);
            disp('Ring Modulation')
        case {'stereotrem'}
            soundOut = zeros(dur,1);
            disp('Stereo Tremolo')
        case {'distortion'}
            soundOut = zeros(dur,1);
            disp('Distortion')
        case {'singletapdelay'}
            soundOut = zeros(dur,1);
            disp('Single Tap Delay')
        case {'flanger'}
            soundOut = zeros(dur,1);
            disp('Flanger')
        case {'chorus'}
            soundOut = zeros(dur,1);
            disp('Chorus')
        otherwise
            error('Invalid effect type')
    end

end