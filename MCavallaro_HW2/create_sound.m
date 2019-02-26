function [soundOut] = create_sound(instrument, notes, constants)
    temperament = instrument.temperament;
    root = notes.note(1:end-1);
    octave = str2double(notes.note(end));
    sound = instrument.sound;
    chordType = instrument.mode;
    amp = constants.amplitude;
    dur = constants.durationChord;
    fs = constants.fs;
    t = constants.t;
    
    switch chordType
        case {'Major','major','M','Maj','maj'}
            keys = [4,7]; % which keys are pressed. Numbers indicate number of semitones away from root.
            numNotes = 3; % number of notes in chord
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
        case {'Sample'}
            keys = [];
            numNotes = 1;
        otherwise
            error('Inproper chord specified');
    end

    switch temperament
        case {'just','Just'}
            fmult = sort([(2/3)^5*8,(2/3)^4*8,(2/3)^3*4,(2/3)^2*4,(2/3)*2, 1,...
                1.5, 1.5^2/2, 1.5^3/2, 1.5^4/4, 1.5^5/4, 1.5^6/8, 2]); % Pythagorean tuning (dropping augmented and diminished intervals).
            switch root % relative to 440 Hz
                    case {'C'}
                        froot = 264.2981 *2^(octave-4); % All root frequencies are defined in the 4th octave.
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
                        froot = 495	*2^(octave-4);
                    otherwise
                        error('Invalid Root')
            end
        case {'equal','Equal'}
            fmult = sort([(2^(0/12)),(2^(1/12)),(2^(2/12)),(2^(3/12)),...
                (2^(4/12)),(2^(5/12)),(2^(6/12)),(2^(7/12)),(2^(8/12)),(2^(9/12)),...
                (2^(10/12)),(2^(11/12)),(2^(12/12))]); % Equal tempered tuning based on twelvth root of 2
            switch root % from wikipedia link
                case {'C'}
                    froot = 261.6256*2^(octave-4); % All root frequencies are defined in the 4th octave.
                case {'C#', 'Db'}
                    froot = 277.1826*2^(octave-4);
                case {'D'}
                    froot = 293.6648*2^(octave-4);
                case {'D#','Eb'}
                    froot = 311.1270*2^(octave-4);
                case {'E'}
                    froot = 329.6276*2^(octave-4);
                case {'F'}
                    froot = 349.2282*2^(octave-4);
                case {'F#','Gb'}
                    froot = 369.9944*2^(octave-4);
                case {'G'}
                    froot = 391.9954*2^(octave-4);
                case {'G#','Ab'}
                    froot = 415.3047*2^(octave-4);
                case {'A'}
                    froot = 440.0000*2^(octave-4);
                case {'A#','Bb'}
                    froot = 466.1638*2^(octave-4);
                case {'B'} 
                    froot = 493.8833*2^(octave-4);
                otherwise
                    error('Invalid Root')
            end
        otherwise
            error('Improper temperament specified')
    end
    
    freqs = zeros(1,numNotes);
    % Fill freqs
    freqs(1) = froot;
    for ib = 1:length(keys)
        freqs(ib+1) = freqs(1)*fmult(keys(ib)+1); % determines notes of the chord
    end
    
    switch sound
        case {'Additive'} % Implementing a drum with additive synthesis
            % Create oscillator and random noise blocks to copy figure 4.27
            % in Dodge,Jerse computer music texbook.
            F2decay = 1./exp(15*t); % decay envelope of oscillator type F2
            F2a = oscillator(1/dur, amp/2, constants).*F2decay;% (frequency, amplitude, constants)
            F2b = oscillator(1/dur, amp/6, constants).*F2decay;
            F1decay = 1./exp(7*t); % steeper falloff for F2 oscillators than F1 oscillators
            F1 = oscillator(1/dur, amp/2.5, constants).*F1decay;
            
            randi = noiseGen(400,F2a,constants); % noise gen function emulates RANDI block 
            F3 = oscillator(freqs/10, F2b, constants);
            noise = oscillator(500,randi, constants);
            noise = repmat(noise, length(freqs),1); % repeating noise vector for chords
            
            fund = oscillator(freqs, F1, constants);
            drum = noise + F3 + fund; % sum together three signal types according to signal flow chart
            soundOut = repmat(sum(drum(:,1:length(drum)/4),1),1,4); % summing all 3 notes of the chord together
            disp('Bongo Drum / High Tom')

        case {'Subtractive'} % Implementing a squarewave with closing filter (subtractive synthesis)
            w = 2*pi*freqs;
            x = zeros(1,fs*dur);
            for ia = 1:length(freqs)
                x(ia,:) = amp*square(w(ia)*t,50); % creating square wave with 50 percent duty
            end
            x = sum(x,1); % sum notes of chord together to save computation time of the filter. 
            freqs = fliplr(logspace(1,4,40)); % using logspace for cutoff frequencies instead of linspace to make the filter close faster.
            y = zeros(1,fs*dur);
            for ia = 1:length(freqs)
                ind = (ia-1)*length(x)/length(freqs)+1: ia*length(x)/length(freqs); % proper indexing of the output vector
                y(ind) = lowpass(x(ind),freqs(ia),fs); % filling up the output with waves filtered with a different cutoff
            end
            soundOut = y;
            % NOTE: because the cutoff frequency shifts not at an even
            % period count, there are discontinuities which lead to a low
            % frequency popping. I spent some time trying to remedy this
            % but it was more complicated than I though.
            disp('Closing low pass filter on square wave')
            
        case {'FM'} % Implementing a bell with frequency modulation synthesis
            % Initialize tuning params
            amp = constants.amplitude;
            damp = 3; % damping envelope
            fratio = 100; % speed of modulation
            d = 3;  % aka depth 
            
            fm = freqs/fratio; % carrier envelope, aka speed
            decay = 1./exp(damp*t); % decay envelopes for a bell according to Figure 5.9 from Dodge and Jerse computer music
            F1 = oscillator(1/dur, amp, constants).*decay;% (frequency, amplitude, constants)
            F2 = oscillator(1/dur, d, constants).*decay;
            Fm = oscillator(fm, F2, constants); % message signal
            Fout = oscillatorFM(Fm+freqs', F1, constants); % output oscillator
            soundOut = sum(Fout(:,length(Fout)/12:end),1); % summing all 3 notes of the chord together
            disp('Bell sound')
        case {'Waveshaper'} % Implementing a clarinet with waveshaping synthesis
            % First must create ADSR envelope
            ADSR = zeros(0,dur);
            R = 0.085; A = 255; D = 0.64;
            slopeRise = A/(R*dur*fs);
            slopeDecay = -A/(D*dur*fs);
            lenRise = 1:floor(R*dur*fs);
            lenSus = floor(R*dur*fs)+1:floor((1-D)*dur*fs);
            lenDecay = floor((1-D)*dur*fs)+1:dur*fs;
            ADSR(lenRise) = cumsum(slopeRise*ones(1,floor(R*dur*fs)));
            ADSR(lenSus) = ones(1,floor((1-D)*dur*fs)-floor(R*dur*fs))*A;
            ADSR(lenDecay) = cumsum(slopeDecay*ones(1,floor(dur*fs)-floor((1-D)*dur*fs)))+A;
            
            w = 2*pi*freqs;
            wave= repmat(ADSR,size(freqs,1),1).*sin(w'*t);
            wave = wave+256;
            waveShape = zeros(length(freqs),fs*dur);
            for ia = 1:length(freqs)
                gainA = (-0.5+1)/(200);
                gainB = (0.5+0.5)/(312-200);
                gainC = (1-0.5)/(511-312);
                for ib = 1:fs*dur
                    if wave(ia,ib)<=200
                        waveShape(ia,ib) = wave(ia,ib)*gainA + -1; % mult by slope and add y intercept
                    elseif wave(ia,ib)>200 && wave(ia,ib)<=312
                        waveShape(ia,ib) = wave(ia,ib)*gainB + (-0.5-gainB*200);
                    elseif wave(ia,ib)>312 && wave(ia,ib)<=511
                        waveShape(ia,ib) = wave(ia,ib)*gainC + (0.5-gainC*312);
                    end
                end
            end
            disp('Clarinet sound')
            waveShape = waveShape*amp; % multiply by amp for last step. 
            soundOut = sum(waveShape,1);
            
        otherwise
            error('Invalid synth type')
    end

end
