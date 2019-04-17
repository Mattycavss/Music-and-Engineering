%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% HW4
% Matthew Cavallaro
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Setup
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clear sound
% clear functions
clear variables
dbstop if error
filename = 'monkeyman.wav';                                                 % use monkeyman if you want to have fun
filename = 'spongebob.wav';                                                 % this one is interesting with distortion and ringmod
% filename = 'clean.wav';                                                     % Name of input .wav file
% filename = 'licks.wav';                                                   % Licks.wav only has one channel, doesn't work for stereo tremolo                                                
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Samples
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
effectTypes={'original', 'compressor','ringmod','stereotrem',...
    'distortion', 'singletapdelay','flanger','chorus',...
    'envelopefilter'};
% effectTypes={'distortion', 'ringmod'};
% effectTypes={'chorus'};

[y,fs] = audioread(filename);                                           % Reading audio file
constants.fs=fs;                                                        % Sampling rate in samples per second
constants.duration=length(y)/constants.fs;                              % Duration of sample
constants.t = 0:1/constants.fs:constants.duration;                      % Time vector
constants.t(end) = [];                                                  % Remove last element
constants.amp = 1;                                                      % Set amplitude
STDOUT=1;                                                               % Define the standard output stream
STDERR=2;                                                               % Define the standard error stream
for cntEff=1:length(effectTypes)                                        % Looping through effects
    effect=effectTypes{cntEff};         
    create_effect(effect, y, constants);                                % The function create_effect outputs an affected version of the input vector based on effect type
end
