% Loads the critial band boundaries data. Switch case handles 
% different sampling rates
% Reference: ANNEX_D.docx

function [cbb, cbb_bark] = crit_band_boundaries_lookup(fs)
    cbbIn = table2array(readtable('crit_band_boundaries.xlsx'));
    switch fs
        case 32000
            cbb = cbbIn(:,1);
            cbb_bark = cbbIn(:,3);
        case 44100
            cbb = cbbIn(:,4);
            cbb_bark = cbbIn(:,6);
        case 48000
            cbb = cbbIn(:,7);
            cbb_bark = cbbIn(:,9);
        otherwise
            error('error in crit_band_boundaries_lookup: invalid sampling rate')
    end
end
