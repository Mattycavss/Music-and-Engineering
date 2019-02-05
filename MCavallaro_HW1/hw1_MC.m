%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SCRIPT
%    hw1
% 
% This script runs questions 2 through 4 of the HW1 from ECE313:Music and
% Engineering.
%
% This script was adapted from hw1 recevied in 2012
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Setup
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clear functions
clear variables
dbstop if error


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Constants
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
constants.fs=44100;                 % Sampling rate in samples per second
constants.durationScale=0.5;        % Duration of notes in a scale
constants.durationChord=3;          % Duration of chords



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Question 2 - scales
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fund = 'G';
[soundMajorScaleJust]=create_scale('Major','Just',fund,constants);
[soundMajorScaleEqual]=create_scale('Major','Equal',fund,constants);
[soundMinorScaleJust]=create_scale('Minor','Just',fund,constants);
[soundMinorScaleEqual]=create_scale('Minor','Equal',fund,constants);

disp('Playing the Just Tempered Major Scale');
soundsc(soundMajorScaleJust,constants.fs);
disp('Playing the Equal Tempered Major Scale');
soundsc(soundMajorScaleEqual,constants.fs);
disp('Playing the Just Tempered Minor Scale');
soundsc(soundMinorScaleJust,constants.fs);
disp('Playing the Equal Tempered Minor Scale');
soundsc(soundMinorScaleEqual,constants.fs);
fprintf('\n');

% EXTRA CREDIT - Melodic and Harmonic scales
[soundHarmScaleJust]=create_scale('Harmonic','Just','A',constants);
[soundHarmScaleEqual]=create_scale('Harmonic','Equal','A',constants);
[soundMelScaleJust]=create_scale('Melodic','Just','A',constants);
[soundMelScaleEqual]=create_scale('Melodic','Equal','A',constants);

disp('Playing the Just Tempered Harmonic Scale');
soundsc(soundHarmScaleJust,constants.fs);
disp('Playing the Equal Tempered Harmonic Scale');
soundsc(soundHarmScaleEqual,constants.fs);
disp('Playing the Just Tempered Melodic Scale');
soundsc(soundMelScaleJust,constants.fs);
disp('Playing the Equal Tempered Melodic Scale');
soundsc(soundMelScaleEqual,constants.fs);
fprintf('\n');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Question 3 - chords
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fund = 'A'; % need this to determine wavelength for plots

% major and minor chords
[soundMajorChordJust]=create_chord('Major','Just',fund,constants);
[soundMajorChordEqual]=create_chord('Major','Equal',fund,constants);
[soundMinorChordJust]=create_chord('Minor','Just',fund,constants);
[soundMinorChordEqual]=create_chord('Minor','Equal',fund,constants);

disp('Playing the Just Tempered Major Chord');
soundsc(soundMajorChordJust,constants.fs);
disp('Playing the Equal Tempered Major Chord');
soundsc(soundMajorChordEqual,constants.fs);
disp('Playing the Just Tempered Minor Chord');
soundsc(soundMinorChordJust,constants.fs);
disp('Playing the Equal Tempered Minor Chord');
soundsc(soundMinorChordEqual,constants.fs);
fprintf('\n');

% assorted other chords
[soundPowerChordJust]=create_chord('Power','Just',fund,constants);
[soundPowerChordEqual]=create_chord('Power','Equal',fund,constants);
[soundSus2ChordJust]=create_chord('Sus2','Just',fund,constants);
[soundSus2ChordEqual]=create_chord('Sus2','Equal',fund,constants);
[soundSus4ChordJust]=create_chord('Sus4','Just',fund,constants);
[soundSus4ChordEqual]=create_chord('Sus4','Equal',fund,constants);
[soundDom7ChordJust]=create_chord('Dom7','Just',fund,constants);
[soundDom7ChordEqual]=create_chord('Dom7','Equal',fund,constants);
[soundMin7ChordJust]=create_chord('Min7','Just',fund,constants);
[soundMin7ChordEqual]=create_chord('Min7','Equal',fund,constants);


disp('Playing the Just Tempered Power Chord');
soundsc(soundPowerChordJust,constants.fs);
disp('Playing the Equal Tempered Power Chord');
soundsc(soundPowerChordEqual,constants.fs);
disp('Playing the Just Tempered Sus2 Chord');
soundsc(soundSus2ChordJust,constants.fs);
disp('Playing the Equal Tempered Sus2 Chord');
soundsc(soundSus2ChordEqual,constants.fs);
disp('Playing the Just Tempered Sus4 Chord');
soundsc(soundSus4ChordJust,constants.fs);
disp('Playing the Equal Tempered Sus4 Chord');
soundsc(soundSus4ChordEqual,constants.fs);
disp('Playing the Just Tempered Dom7 Chord');
soundsc(soundDom7ChordJust,constants.fs);
disp('Playing the Equal Tempered Dom7 Chord');
soundsc(soundDom7ChordEqual,constants.fs);
disp('Playing the Just Tempered Min7 Chord');
soundsc(soundMin7ChordJust,constants.fs);
disp('Playing the Equal Tempered Min7 Chord');
soundsc(soundMin7ChordEqual,constants.fs);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Question 4 - plots
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% major and minor chords
[MajorChordJust,froot]=create_chord('Major','Just',fund,constants); % Having create_chord also return froot
[MajorChordEqual]=create_chord('Major','Equal',fund,constants);
[MinorChordJust]=create_chord('Minor','Just',fund,constants);
[MinorChordEqual]=create_chord('Minor','Equal',fund,constants);

% determine fundamental frequency
T = 1/froot; % single wavelength of fundamental
t = 0:1/constants.fs:constants.durationChord;

% Major chords
%   Single Wavelength
%     just tempered
figure
plot(t, MajorChordJust)
xlabel('Time (s)')
ylabel('Amplitude')
xlim([0,T])
title('Figure 1: Just Tempered Major Chord, Single Fundamental Wavelength')
%     equal tempered
figure
plot(t, MajorChordEqual)
xlabel('Time (s)')
ylabel('Amplitude')
xlim([0,T])
title('Figure 2: Equal Tempered Major Chord, Single Fundamental Wavelength')
%   Tens of Wavelengths
%     just tempered
figure;
plot(t, MajorChordJust)
xlabel('Time (s)')
ylabel('Amplitude')
xlim([0,30*T])
title('Figure 3: Just Tempered Major Chord, Thirty Wavelengths of Fundamental')
%     equal tempered
figure;
plot(t, MajorChordEqual)
xlabel('Time (s)')
ylabel('Amplitude')
xlim([0,30*T])
title('Figure 4: Equal Tempered Major Chord, Thirty Wavelengths of Fundamental')

% Minor chords
%   Single Wavelength
%     just tempered
figure
plot(t, MinorChordJust)
xlabel('Time (s)')
ylabel('Amplitude')
xlim([0,T])
title('Figure 5: Just Tempered Minor Chord, Single Fundamental Wavelength')
%     equal tempered
figure
plot(t, MinorChordEqual)
xlabel('Time (s)')
ylabel('Amplitude')
xlim([0,T])
title('Figure 6: Equal Tempered Minor Chord, Single Fundamental Wavelength')
%   Tens of Wavelengths
%     just tempered
figure;
plot(t, MinorChordJust)
xlabel('Time (s)')
ylabel('Amplitude')
xlim([0,30*T])
title('Figure 7: Just Tempered Minor Chord, Thirty Wavelengths of Fundamental')
%     equal tempered
figure;
plot(t, MinorChordEqual)
xlabel('Time (s)')
ylabel('Amplitude')
xlim([0,30*T])
title('Figure 8: Equal Tempered Minor Chord, Thirty Wavelengths of Fundamental')

% You can see the difference between just and equal tempered over tens of
% wavelengths of the fundamental, but not over a single wavelength. 

disp('You can see the difference between just and equal tempered over tens of wavelengths of the fundamental, but not over a single wavelength.')


