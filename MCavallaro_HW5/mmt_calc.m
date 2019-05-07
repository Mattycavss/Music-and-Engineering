% Determination of the minimum masking threshold
% Annex D Step 8
% Psychoacoustic model 1

function [LTmin] = mmt_calc(fca_table, LTg_in, flag)
    % preprocessing: once again, needed to map the the fca_table length of
    % 106 for this sampling frequency to the 256 length of the fft for the
    % global masking threshold variable. I should have probable created a
    % function to do this mapping since I have already copy and pasted this
    % code like four times....
    f_ind = fca_table(:,4);
    LTg_in(isnan(LTg_in)) = [];
    f_ind(isnan(f_ind)) = [];
    LTg = [];
    for ia = 1:length(LTg_in)
        if ia == length(LTg_in)
            val = ones(1+length(flag)-f_ind(ia),1)*LTg_in(ia);
        else
            val = ones(f_ind(ia+1)-f_ind(ia),1)*LTg_in(ia);
        end
        LTg = [LTg; val];                                                   % mapping 106 --> 256
    end
    
    % the minimum masking threshold is just the minimum of a subband of the
    % global masking threshold 
    LTmin = zeros(32,1);
    for ia = 1:32
       LTmin(ia) = min(LTg((ia-1)*8+1:8*ia));                               % 32 equally spaced subbands of 8 indices = 256
    end
end
