function [midiOut] = decode_midi(midi_file)
    fileID = fopen(midi_file);                                              % fopen to retrieve a file id
    midi_data = fread(fileID, Inf, 'uint8');                                % reading the hex file as 8 bit integer (perfect for midi)
    fclose(fileID);                                                         % closing the file after opening it for reading
    midi_data = midi_data';                                                 % column to row
    
    % Header
    header = midi_data(1:14);                                               % header is always first 14 bytes
    midiOut.header.headerChunk = chunk(header(1:4),1);                      % header (MThd) chunk is always first 4 bytes of midi file         
    midiOut.header.headerLength = chunk(header(5:8),0);                     % length of header is after the header chunk
    midiOut.header.fileFormat = chunk(header(9:10),0);                      % file format is bytes 9-10
    midiOut.header.numTracks = chunk(header(11:12),0);                      % number of tracks is bytes 11-12
    midiOut.header.ppqn = chunk(header(13:14),0);                           % pulses per quarternote is bytes 13-14
    
    % Find all tracks (4D 54 72 6B in hex)
    ind = find(midi_data == 77);
    ind = ind(2:end);                                                       % first is header, so drop it
    mtrks = zeros(1,length(midiOut.header.numTracks));
    ib = 0;
    track_id = [84 114 107];
    for ia = 1:length(ind)
        if midi_data(ind(ia)+1:ind(ia)+3) == track_id
            ib = ib + 1;
            mtrks(ib) = ind(ia);                                            % holds the indices for all the tracks
        end
    end
    
    % Initialize arrays that will pass into player function
    midiOut.note = [];
    midiOut.startTime = [];
    midiOut.noteDuration = [];
    midiOut.amplitude = [];
    midiOut.patch = [];
    midiOut.attackTime = [];
    midiOut.releaseTime = [];
    midiOut.tempo = 0;                                                      
    midiOut.key = '';
    midiOut.pitchInfo = {};
    
    % Commands sets for command switch case / if statements
    Seven = 112:1:127;                                                      % 'Seven' commands only follow FF sys commands
    Eight = 128:1:143; Nine = 144:1:159; A = 160:1:175; B = 176:1:191;      % typical command sets
    C = 192:1:207; D = 208:1:223; E = 224:1:239; F = 240:1:255;
    
    % Loop through and parse
    for ia = 1:length(mtrks)                                                % looping through all the tracks in the midi file
        if ia < length(mtrks)                                               % setting the bounds for each track in the midi file
            track = midi_data(mtrks(ia):mtrks(ia+1)-1);
        else
            track = midi_data(mtrks(ia):end);                               % use end so that the iterator doesn't go out of bounds
        end
        
        % Find number of notes in a track
        numNotes = length(find(ismember(track, Nine)));                     % counting number of notes in the track
        
        % Determine running status
        ic = find(ismember(track, Nine));
        if (isempty(ic))
           runningStatus = 0;
        else
            ic = ic(1)
            if ismember(track(ic+3),[0:1:127]) && ismember(track(ic+4),[0:1:127])
                runningStatus = 1;                                              % to keep track of running status file types
            else
                runningStatus = 0;
            end
        end
        running = 1;
        
        % Initialize track properties                                       % these will be passed into midiOut at the end of the for loop iteration
        trackOut.mtrk = chunk(track(1:4),1);                                
        trackOut.length = chunk(track(5:8),0);
        trackOut.name = '';
        trackOut.key = '';
        trackOut.note = zeros(1,numNotes);                                  % array of notes that will pass into the player
        trackOut.startTime = zeros(1,numNotes);                             % start times for each corresponding note (in seconds)
        trackOut.noteDuration = zeros(1,numNotes);                          % note durations (in units of quarter notes)
        trackOut.amplitude = zeros(1,numNotes);                             % volume levels
        trackOut.patch = zeros(1,numNotes);                                 % patch number
        trackOut.attackTime = zeros(1,numNotes);                            % attack time to model velocity
        trackOut.releaseTime = zeros(1,numNotes);                           % release time to model sustain
        trackOut.pitchInfo = cell(2,numNotes);                                            % pitch info to model pitch bending
        
        % Initialize temporary track variables                                                           
        amp = 1;                                                            % default volume level is 1
        patch = 1;                                                          % default patch is 1
        releaseTime = 0.05;                                                 % default release time is 0.05 (min release time)
        endtime = zeros(1,numNotes);                                        % holds endtimes and will be used to calculate trackOut.noteDuration
        notelist = zeros(1,numNotes);                                       % notelist hold all notes that are on so that endtime can be found (indexing notes properly).
        deltas = [];                                                        % deltas is the array of all the delta times. Current time is the sum of deltas
        pitchBend.mult = [];                                                % holds the multiplication factor of the frequency
        pitchBend.time = [];                                                % holds the time that the pitch bend begins
        noteInd = 1;                                                        % holds the index of the current note, increments every note on command
        ib = 9;                                                             % index 9 is the first delta time after the track length
        
        while ib <= length(track)
            deltatime = track(ib);
            if deltatime > 128
                ib = ib +1;
                deltatime = VLV([deltatime track(ib)]);                     % taking care of variable length values
            end
            fprintf('deltatime = %d \n', deltatime);
            deltas = [deltas deltatime];                                    % appends delta times to array to keep track of time              
            if isfield(midiOut, 'den') && isfield(midiOut, 'tempo')
                currentTime = sum(deltas)/midiOut.header.ppqn*...
                    (midiOut.den/4)/(midiOut.tempo/60);                     % deltas are in pulses. Divide by ppqn, mult by beats per qn, div by beats per sec to get in seconds
                fprintf('Current time = %d \n', currentTime)
            end                         
            ib = ib+1;
            nextcmd = track(ib);
            fprintf('nextcmd = %d \n', nextcmd);
            if ismember(nextcmd, Eight)  % NOTE OFF
                ib = ib+1;
                note = track(ib);
                ib = ib+1;
                velocity = track(ib);
                fprintf('note %d off with velocity %d \n', ...
                    note,velocity)
                index = notelist==note;
                endtime(index) = currentTime;
                trackOut.pitchInfo{1,index} = pitchBend.mult;           % assigning pitch bend info to a note once it turns off because we had to wait for the pitch bend commans
                trackOut.pitchInfo{2,index} = pitchBend.time;
                notelist(index) = nan;
                ib = ib+1;
            elseif ismember(nextcmd, Nine)  % NOTE ON
                running = 1;
                while running
                    ib = ib+1;
                    note = track(ib);
                    fprintf('note = %d \n', note)
                    ib = ib+1;
                    velocity = track(ib);
                    fprintf('velocity = %d \n', velocity)
                    if velocity == 0
                        fprintf('note %d off with velocity %d \n',...
                            note,velocity)
                        index = notelist==note;
                        endtime(index) = currentTime;
                        trackOut.pitchInfo{1,index} = pitchBend.mult;
                        trackOut.pitchInfo{2,index} = pitchBend.time;
                        notelist(index) = nan;
                        ib = ib+1;
                    else
                        notelist(noteInd) = note;
                        % adding the note to the list on notes currently on.
                        % Having a notelist helps because nan will indicate that 
                        % the note is off, 0 will indicate that the note has not 
                        % turned on yet, and a note number will indicate that the 
                        % note is currently on. 

                        % when a note turns on, trackOut inherits all the
                        % following properties
                        trackOut.note(noteInd) = note;
                        t = linspace(0.001,0.5,128);
                        trackOut.attackTime(noteInd) = t(velocity);
                        trackOut.startTime(noteInd) = currentTime;
                        trackOut.amplitude(noteInd) = amp;
                        trackOut.patch(noteInd) = patch;
                        trackOut.releaseTime(noteInd) = releaseTime;
                        noteInd = noteInd+1;
                        ib = ib+1;
                    end
                   
                    if runningStatus == 0
                        running = 0;
                    elseif runningStatus == 1 && ismember(track(ib+1),[0:1:127])
                        deltatime = track(ib);
                        if deltatime > 128
                            ib = ib +1;
                            deltatime = VLV([deltatime track(ib)]);                     % taking care of variable length values
                        end
                        fprintf('deltatime = %d \n', deltatime);
                        deltas = [deltas deltatime];                                    % appends delta times to array to keep track of time              
                        if isfield(midiOut, 'den') && isfield(midiOut, 'tempo')
                            currentTime = sum(deltas)/midiOut.header.ppqn*...
                                (midiOut.den/4)/(midiOut.tempo/60);                     % deltas are in pulses. Divide by ppqn, mult by beats per qn, div by beats per sec to get in seconds
                            fprintf('Current time = %d \n', currentTime)
                        end 
                    elseif runningStatus == 1 && not(ismember(track(ib+1),[0:1:127]))
                        running = 0;
%                         ib = ib+1;
                    else
                        error('error in running status')
                    end
                end

            elseif ismember(nextcmd, A)  % POLYPHONIC AFTERTOUCH
                key = track(ib+1);
                pressure = track(ib+2);
                ib = ib+3;
                fprintf(['polyphonic aftertouch for note %d with'...
                'pressure %d \n',key,pressure])                             % Note: for now, not implemented

            elseif ismember(nextcmd, B)  % CONTROLLER COMMAND
                ib = ib+1; 
                if track(ib) == 7  % VOLUME
                    volume = track(ib+1);
                    volume = volume + 1;
                    fprintf('Main volume set to %d \n', track(ib))
                    t = linspace(1,1,128);
                    amp = t(volume);
                    ib = ib+2;
                elseif track(ib) == 64  % SUSTAIN  
                    ib = ib + 1;
                    sustain = track(ib);
                    sustain = sustain + 1;
                    fprintf('Sustain on %d \n', track(ib))
                    t = linspace(0.05,0.5,128);
                    releaseTime = t(sustain);
                    ib = ib+1;
                elseif ismember(track(ib), Seven)
                    trackOut.channelMode = track(ib);
                    ib = ib+1;

                else
                    disp('Unknown controller command')
                    ib = ib+1;
                    while not(ismember(track(ib),[Eight Nine B C F]))
                       ib = ib+1; 
                    end
                    ib = ib-1;
                end

            elseif ismember(nextcmd, C)  % PATCH CHANGE
                patch = track(ib+1);
                fprintf('Patch change to patch number %d \n', patch)
                ib = ib+2;

            elseif ismember(nextcmd, D)  % CHANNEL AFTERTOUCH 
                pressure = track(ib+1);
                fprintf('Channel aftertouch command with pressure %d \n',pressure)  % Note: for now, not implemented
                ib = ib+2;

            elseif ismember(nextcmd, E) % PITCH BEND
                running = 1;
                while running
                    bend = chunk(track(ib+1:ib+2),0);
                    bend = bend+1;
                    fprintf('Pitch bend of value %d \n',bend)
                    t = linspace(0.5,2,16383);
                    pitchBend.mult = [pitchBend.mult t(bend)];
                    pitchBend.time = [pitchBend.time currentTime];
                    ib = ib+3;
                    if runningStatus == 0
                        running = 0;
                    elseif runningStatus == 1 && ismember(track(ib),[0:1:127])
                        deltatime = track(ib);
                        if deltatime > 128
                            ib = ib +1;
                            deltatime = VLV([deltatime track(ib)]);                     % taking care of variable length values
                        end
                        fprintf('deltatime = %d \n', deltatime);
                        deltas = [deltas deltatime];                                    % appends delta times to array to keep track of time              
                        if isfield(midiOut, 'den') && isfield(midiOut, 'tempo')
                            currentTime = sum(deltas)/midiOut.header.ppqn*...
                                (midiOut.den/4)/(midiOut.tempo/60);                     % deltas are in pulses. Divide by ppqn, mult by beats per qn, div by beats per sec to get in seconds
                            fprintf('Current time = %d \n', currentTime)
                        end 
                    elseif runningStatus == 1 && not(ismember(track(ib),[0:1:127]))
                        running = 0;
                    else
                        error('error in running status')
                    end
                end

            elseif ismember(nextcmd, F)  % SYSTEM COMMANDS
                if track(ib) == 240
                    ib = ib+1;
                    while not(ismember(track(ib),[247]))
                       ib = ib+1; 
                    end
                    ib = ib-1;
                elseif track(ib) ~= 255
                    ib = ib+1;
                    while not(ismember(track(ib),[144 B C F]))
                       ib = ib+1; 
                    end
                    ib = ib-1;
                else
                    ib = ib+1;
                    if not(ismember(track(ib), [32 47 81 84 88 89]))
                        eventType = track(ib);
                        while not(ismember(track(ib),[Nine B C F]))
                           ib = ib+1; 
                        end
                        ib = ib-1;                                              % subtract one to go back to the deltatime
                        fprintf('eventType = %s \n', num2str(eventType));
                    else
                        eventType = chunk([track(ib) track(ib+1)], 1);
                        ib = ib+2;
                        fprintf('eventType = %s \n', num2str(eventType));
                        switch eventType
                            case '5902'  % KEY AND SCALE
                                numSharps = track(ib);
                                chordType = track(ib+1);
                                ib = ib+2;
                                if numSharps >= 0
                                    numSharps = strcat(num2str(numSharps), ' sharp(s)');
                                else
                                    numSharps = strcat(num2str(abs(numSharps)), ' flat(s)');
                                end
                                if chordType == 0
                                    chordType = ' Major';
                                elseif chordType == 1
                                    chordType = ' minor';
                                else
                                    error('invalid chord type')
                                end
                                fprintf('%s in key, %s scale \n', numSharps, chordType)
                                midiOut.key = strcat(numSharps, chordType);
                            case '5804'  % TIMING
                                midiOut.num = track(ib);
                                midiOut.den = 2^track(ib+1);
                                midiOut.clicksPerMetBeat = track(ib+2);
                                midiOut.thirtysecondNotesPerQNote = track(ib+3);
                                ib = ib+4;
                                midiOut.timeSignature = strcat(int2str(midiOut.num), '/', int2str(midiOut.den));
                                fprintf('Time Signature = %s \n', midiOut.timeSignature);
                            case '5103'  % TEMPO
                                tt = chunk(track(ib:ib+2),0);
                                midiOut.tempo = 60e6/tt;  % I am assuming all of the tracks are the same tempo
                                ib = ib + 3;
                            case '2F00'  % END OF TRACK
                                fprintf('End of track \n')
                                continue
                            case '2001'  
                                fprintf('ignoring event 2001 \n');
                                ib=ib+1;
                                continue
                            case '2101'  
                                fprintf('ignoring event 2001 \n');
                                ib=ib+1;
                                continue
                            case '5405'  
                                fprintf('ignoring event 5405');
                                ib=ib+5;
                                continue
                            otherwise
                                error('unknown event');
                        end
                    end
                end
            else
                error('unknown command')
            end
        end
        trackOut.noteDuration = endtime-trackOut.startTime;
        midiOut.note = [midiOut.note trackOut.note];
        midiOut.startTime = [midiOut.startTime trackOut.startTime];
        midiOut.noteDuration = [midiOut.noteDuration trackOut.noteDuration];
        midiOut.amplitude = [midiOut.amplitude trackOut.amplitude];
        midiOut.patch = [midiOut.patch trackOut.patch];
        midiOut.attackTime = [midiOut.attackTime trackOut.attackTime];
        midiOut.releaseTime = [midiOut.releaseTime trackOut.releaseTime];
        midiOut.pitchInfo = [midiOut.pitchInfo trackOut.pitchInfo];
    end
end


function [out] = VLV(deltatime)
% The purpose of this function is to address the midi standard for variable
% length values. It takes in one or two decimal bytes and returns a deltatime in decimal.
dt1 = dec2bin(deltatime(1), 8);
dt2 = dec2bin(deltatime(2), 8);
dt = strcat(dt1(2:end), dt2(2:end));
out = bin2dec(dt);
end


function [out] = chunk(input, varargin)
% The purpose of this function is to take an input and chunk the bytes
% together so that, for example, a 3 byte input is not a 1x3 array of 
% decimal numbers between 0 and 255, but a single value between 0 and 
% 16777215. This function also serves to convert the input to any number
% system of the users choice. No second argument means binary, second
% argument of value 1 is hex, and a second argument of value 0 is decimal.
    input_hex = dec2hex(input,2);
    output_hex = ''; 
    for ia = 1:length(input)
        output_hex = strcat(output_hex, input_hex(ia,1:end));
    end
    if length(varargin) >= 1 
        if varargin{1} == 1
            out = output_hex;
        elseif varargin{1} == 0
            out = hex2dec(output_hex);
        else
            error('Invalid number system handle for chunk function.')
        end
    else
        out = dec2bin(hex2dec(output_hex));
    end
end