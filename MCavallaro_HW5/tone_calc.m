% Tone calculation: must derive the tonal and non-tonal components from the
% fft spectrum in order to calculate the global masking threshold!
% Reference: ANNEX_D.docx 3-D.1. Psychoacoustic Model I

function [fca_table, flag, tonal, nontonal] = tone_calc(fs, fca_table,...
    cbb, Xk)
    
    % step1: labelling of local max
    localMax = [];
    for k = 3:250
        if Xk(k)>Xk(k-1) && Xk(k)>=Xk(k+1)
            localMax = [localMax; k];                                       % building up indices of local maxes
        end
    end
    
    % step2: list of tonal components and calculate sound pressure level
    tonal_spl = [];
    tonal_ind = [];
    k1 = 3:62;                                                              % numbers are directly from annex D
    k2 = 63:126;
    k3 = 127:250;
    j1 = [-2 2];
    j2 = [-3 -2 2 3];
    j3 = [-6 -5 -4 -3 -2 2 3 4 5 6];
    flag = zeros(length(Xk),1);
    for k = localMax'
        if ismember(k,k1)
            j = j1;
        elseif ismember(k,k2)
            j = j2;
        elseif ismember(k,k3)
            j = j3;
        else
            error('Error in tone_calc')
        end
        count = 0;
        for ia = j
            if (Xk(k)-Xk(k+ia)>=7)
                count = count+1;
            end
        end
        if count == length(j)                                               % if all conditions hold, add up the power as tonal calc
            Xtmk = 10*log10((10^(Xk(k-1)/10)) + (10^(Xk(k)/10)) +...
                (10^(Xk(k+1)/10)));
            tonal_spl = [tonal_spl; Xtmk];                                  % append to tonal array
            tonal_ind = [tonal_ind; k];
            flag(k) = 100;                                                  % arbitrary flagging numbers
            flag(k + [1 -1]) = 50;                                          % this glag helps to locate points that have been used for tonal power that 
                                                                                % are not the tonal index itself, but the durrounding indices
        end
    end
    if not(isempty(tonal_spl))
        tonal(:,1) = 10*log10(tonal_spl);
        tonal(:,2) = tonal_ind;
    else
        tonal = [];
    end
    % step3: listing of nontonal components and calc of power
    freq_ind = round(fca_table(:,1)*length(Xk)/fs*2);                       % need to round frequency to fft index. Mult by length/frequency/2 (single side band)
    freq_ind(freq_ind==0)=1;                                                % 0 index should not exist --> ceil to 1
    freq_ind(isnan(freq_ind)) = [];                                         % removing nan elements
    % main step
    nontonal_spl = [];
    nontonal_ind = [];
    cbb(isnan(cbb)) = [];                                                   % removing nan elements
    for ia = 1:length(cbb)
        Xnmk = 0;                                                           % setting the default power to 0
        if ia == length(cbb)
            for k = freq_ind(cbb(ia)):length(Xk)                            % looping through indices (spectral lines) in this critical band
                if flag(k)==0                                               % if not a tonal spectral line
                    Xnmk = Xnmk + 10^(Xk(k)/10);                            % add up the power over indices that apply to nontonal in this crit band
                    flag(k) = 2;                                            % set flags to noise (2)
                end
            end
            f = freq_ind(cbb(ia)):length(Xk);                               % f is a vector of the indices (frequencies) in this band. 
        else
            for k = freq_ind(cbb(ia)):freq_ind(cbb(ia+1))                   % looping through indices (spectral lines) in this critical band
                if flag(k)==0                                               % if not a tonal spectral line
                    Xnmk = Xnmk + 10^(Xk(k)/10);                            % add up the power over indices that apply to nontonal in this crit band
                    flag(k) = 2;                                            % set flags to noise (2)
                end
            end
            f = freq_ind(cbb(ia)):freq_ind(cbb(ia+1));                      % f is a vector of the indices (frequencies) in this band. 
        end
        ind = round(nthroot(prod(f),length(f)));                            % geometric mean term for the critical bounds
        nontonal_ind =  [nontonal_ind; ind];
        nontonal_spl = [nontonal_spl; Xnmk];
    end
    if not(isempty(nontonal_spl))
        nontonal(:,1) = 10*log10(nontonal_spl);
        nontonal(:,2) = nontonal_ind;
    else
        nontonal = [];
    end
    fca_table(:,4) = [freq_ind; nan*zeros(length(fca_table)-...             % appending to the fca_table for later functions.
        length(freq_ind),1)];                                                   % it now contains the frequency indices mapping
end