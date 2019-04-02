function [] = play_notes(songInfo)
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
oscParams.oscAmpEnv.ReleaseTime        = 0.03;  % Time to release from sustain to

tempo = songInfo.tempo;
key = songInfo.key;
notes = songInfo.note;
start = songInfo.startTime;
numQ = songInfo.noteDuration;
amps = songInfo.amplitude;
attack = songInfo.attackTime;
release = songInfo.releaseTime;
pitchInfo = songInfo.pitchInfo;
patch = songInfo.patch;
set = unique(patch);
for ia = 1:length(set)
    patch(patch == set(ia)) = ia;
end
midiOut = objMidiArray(notes, start, numQ, tempo, amps, key, patch, attack, release, pitchInfo);
playAudio(midiOut, oscParams, constants);
end