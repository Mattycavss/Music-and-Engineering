function [] = play_notes
close all                                                                               % Close all open windows
% clear classes                                                                         % Clear the objects in memory
format compact                                                                          % reduce white space
dbstop if error                                                                         % add dynamic break point

% PROGRAM CONSTANTS
constants                              = confConstants;
constants.BufferSize                   = 882;                                                    % Samples
constants.SamplingRate                 = 44100;                                                  % Samples per Second
constants.QueueDuration                = 0.1;                                                    % Seconds - Sets the latency in the objects
constants.TimePerBuffer                = constants.BufferSize / constants.SamplingRate;          % Seconds;

oscParams                              =confOsc;
oscParams.oscAmpEnv.StartPoint         = 0;
oscParams.oscAmpEnv.ReleasePoint       = Inf;   % Time to release the note
oscParams.oscAmpEnv.AttackTime         = 0.03;  % Attack time in seconds
oscParams.oscAmpEnv.DecayTime          = .05;  % Decay time in seconds
oscParams.oscAmpEnv.SustainLevel       = 0.7;  % Sustain level
oscParams.oscAmpEnv.ReleaseTime        = 0.03;  % Time to release from sustain to zero

% osc = objOsc;
patch = 4;
switch patch
    case 1
        oscParams.oscType                      = 'sine';
    case 2
        oscParams.oscType                      = 'square';
    case 3
        oscParams.oscType                      = 'clarinet';
    case 4
        oscParams.oscType                      = 'bell';
    otherwise
        error('invalid patch')
end

% test 0
% notes = [60 62 64 67];
% start = [0 2 4 6];
% numQ = [4 4 4 4];
% amps = [1 1 1 1];
tempo = 120;
key = 'C';
notes = [60 62 64 67 69 72 60 62 64 67 69 72 60 62 64 67 69 72 60 62 64 67 69 72]-10;
start = [0 1.5 2 2.5 3 3.5 4 5.5 6 6.5 7 7.5 8 9.5 10 10.5 11 11.5 12 13.5 14 14.5 15 15.5]./2;
numQ = [1.5 0.5 0.5 0.5 0.5 0.5 1.5 0.5 0.5 0.5 0.5 0.5 1.5 0.5 0.5 0.5 0.5 0.5 1.5 0.5 0.5 0.5 0.5 0.5];
amps = [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1];
midiOut = objMidiArray(notes, start, numQ, tempo, amps, key, patch);
playAudio(midiOut, oscParams, constants);
%% test1
% notes = [60 62 64 67 69 72 60 62 64 67 69 72];
% start = [0 1.5 2 2.5 3 3.5 4 5.5 6 6.5 7 7.5]./2;
% numQ = [1.5 0.5 0.5 0.5 0.5 0.5 1.5 0.5 0.5 0.5 0.5 0.5];
% tempo = 120;
% amps = [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1];
% key = 'f';
% midiOut = objMidiArray(notes, start, numQ, tempo, amps, key);
% playAudio(midiOut, oscParams, constants);
% %% test2
% notes = [60 64 67 61 65 68];
% start = [0 0 0 4 4 4]./2;
% numQ = [4 4 4 4 4 4];
% tempo = 120;
% amps = [1 1 1 1 1 1];
% key = 'f';
% midiOut = objMidiArray(notes, start, numQ, tempo, amps, key);
% playAudio(midiOut, oscParams, constants);

end