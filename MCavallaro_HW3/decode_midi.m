function [midiOut] = decode_midi(midi_file)
    fileID = fopen(midi_file);                                               % fopen to retrieve a file id
    midi_data = fread(fileID, Inf, 'uint8');                                 % reading the hex file as 8 bit integer (perfect for midi)
    fclose(fileID);                                                          % closing the file after opening it for reading
    midi_data = midi_data';                                                  % column to row
    
    % Header
    header = midi_data(1:14);                                                % header is always first 14 bytes
    midiOut.header.headerChunk = chunk_bytes(header(1:4),1);                   % header (MThd) chunk is always first 4 bytes of midi file         
    midiOut.header.headerLength = chunk_bytes(header(5:8),0);                  % length of header is after the header chunk
    midiOut.header.fileFormat = chunk_bytes(header(9:10),0);                   % file format is bytes 9-10
    midiOut.header.numTracks = chunk_bytes(header(11:12),0);                   % number of tracks is bytes 11-12
    midiOut.header.ppqn = chunk_bytes(header(13:14),0);                        % pulses per quarternote is bytes 13-14
    
    % Track Information
    % Find all tracks (4D 54 72 6B in hex)
    ind = find(midi_data == 77);
    ind = ind(2:end); % first is header, so drop it
    mtrks = zeros(1,length(midiOut.header.numTracks));
    ib = 0;
    track_id = [84 114 107];
    for ia = 1:length(ind)
        if midi_data(ind(ia)+1:ind(ia)+3) == track_id
            ib = ib + 1;
            mtrks(ib) = ind(ia);  % This holds the indices for all the tracks
        end
    end
    
    for ia = 1:length(mtrks)
        if ia < length(mtrks)
            track = midi_data(mtrks(ia):mtrks(ia+1)-1);
        else
            track = midi_data(mtrks(ia):end);
        end
        % track
        eval((strcat('midiOut.track', int2str(ia), '.mtrk = chunk_bytes(track(1:4),1);')));
        eval((strcat('midiOut.track', int2str(ia), '.length = chunk_bytes(track(5:8),0);')));
        
        
    
        
    end
    
    disp('show me ya moves')
    
end
    