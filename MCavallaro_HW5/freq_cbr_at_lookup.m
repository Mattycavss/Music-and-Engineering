% Loads the frequency, critical band rate, and absolute threshold data.
% Switch case handles different sampling rates.
% Reference: ANNEX_D.docx.

function [dataOut] = freq_cbr_at_lookup(fs)
    dataOut = table2array(readtable('freq_cbr_at.xlsx'));
    switch fs
        case 32000
            dataOut = dataOut(:,1:3);
        case 44100
            dataOut = dataOut(:,4:6);
        case 48000
            dataOut = dataOut(:,7:9);
        otherwise
            error('error in freq_cbr_at_lookup: invalid sampling rate')
    end
end
