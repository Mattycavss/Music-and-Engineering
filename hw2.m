%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SCRIPT
% HW2
% Matthew Cavallaro

% NOTE: Subtractive synthesis takes some time. I may consider changing the
% filter function I use if we need this later on.

% NOTE2: just hit run and it works in real time. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Setup
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clear functions
clear variables
dbstop if error

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Constants
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
constants.fs=44100;                     % Sampling rate in samples per second
constants.durationScale=.5;             % Duration of notes in a scale
constants.durationChord=4;              % Duration of chords
constants.t = 0:1/constants.fs:constants.durationChord;
constants.t(end) = [];
constants.amplitude = 1;
STDOUT=1;                               % Define the standard output stream
STDERR=2;                               % Define the standard error stream
notes{1}.note='C4';
notes{1}.start=0;
notes{1}.duration=constants.durationChord*constants.fs;
notes{1}.velocity=1;
synthTypes={'Additive','Subtractive','FM','Waveshaper'};
%% Questions 1-4
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Questions 1--4 - samples
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fs = constants.fs;
instrument.temperament='Equal';
instrument.mode = 'Sample';
for cntSynth=1:length(synthTypes)
    instrument.sound=synthTypes{cntSynth};
    fprintf(STDOUT,'For the %s synthesis type...\n',synthTypes{cntSynth})
    fprintf(STDOUT,'Playing the Sample Note \n');
    [soundSample]=create_sound(instrument,notes{1}, constants);
    soundsc(soundSample,fs);
    if synthTypes(cntSynth) == "Additive"
        continue % this is to give the subtractive synthesis time to load while sample 1 is playing.
    end
    pause(1.2*constants.durationChord)
    fprintf('\n');
end

%% Question 5
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Question 5  - chords
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% For major
fs = constants.fs;
instrument.mode = 'Major';
for cntSynth=1:length(synthTypes)
    instrument.sound=synthTypes{cntSynth};
    instrument.temperament='Equal';
    [soundSampleEqual]=create_sound(instrument,notes{1}, constants);
    instrument.temperament='Just';
    [soundSampleJust]=create_sound(instrument,notes{1}, constants);
    
    fprintf(STDOUT,'For the %s synthesis type...\n',synthTypes{cntSynth})
    disp('Playing the Just Tempered Major Chord');
    soundsc(soundSampleJust,fs);
    pause(1.5*constants.durationChord)
    
    disp('Playing the Equal Tempered Major Chord');
    soundsc(soundSampleEqual,fs);
    pause(1.5*constants.durationChord)
    fprintf('\n');
end
% For Minor
fs = constants.fs;
instrument.mode = 'Minor';
for cntSynth=1:length(synthTypes)
    instrument.sound=synthTypes{cntSynth};
    instrument.temperament='Equal';
    [soundSampleEqual]=create_sound(instrument,notes{1}, constants);
    instrument.temperament='Just';
    [soundSampleJust]=create_sound(instrument,notes{1}, constants);
    
    fprintf(STDOUT,'For the %s synthesis type...\n',synthTypes{cntSynth})
    disp('Playing the Just Tempered Minor Chord');
    soundsc(soundSampleJust,fs);
    pause(1.5*constants.durationChord)
    fprintf('\n');
    
    disp('Playing the Equal Tempered Minor Chord');
    soundsc(soundSampleEqual,fs);
    pause(1.5*constants.durationChord)
    fprintf('\n');
end


