% Matthew Cavallaro
% Hw3: Midi Assignment
% 3/26/19
clc; clear sound; clear all                                                % Clear command window and clear sound so stop any tracks running in the background
format compact                                                             % reduce white space
dbstop if error                                                            % add dynamic break point
%% Inputs and constants: Choose the 4 sounds you want.
midi_file = 'mario.mid';  
constants                              = confConstants;
constants.BufferSize                   = 882;                                                    % Samples
constants.SamplingRate                 = 44100;                                                  % Samples per Second
constants.QueueDuration                = 0.1;                                                    % Seconds - Sets the latency in the objects
constants.TimePerBuffer                = constants.BufferSize / constants.SamplingRate;          % Seconds;
oscParams                              = confOsc;
oscParams.oscType                      = 'sine';
oscParams.oscAmpEnv.StartPoint         = 0;
oscParams.oscAmpEnv.ReleasePoint       = Inf;   % Time to release the note
oscParams.oscAmpEnv.AttackTime         = .1;  %Attack time in seconds
oscParams.oscAmpEnv.DecayTime          = .08;  %Decay time in seconds
oscParams.oscAmpEnv.SustainLevel       = 0.7;  % Sustain level
oscParams.oscAmpEnv.ReleaseTime        = .2;  % Time to release from sustain to zero
%% Decode midi file, generate song, and play track
song = decode_midi(midi_file)
soundOut = generate_song(song)
fprintf('Playing from file %s. Enjoy! \n', midi_file)
sound(soundOut, constants.fs)

