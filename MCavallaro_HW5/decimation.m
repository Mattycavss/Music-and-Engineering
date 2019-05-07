% Decimaton of tonal and non-tonal masking components
% Annex D step 5

function [flag_new, tonal_new, nontonal_new, bark] = ...
    decimation(fca_table, cbb, cbb_bark, flag, tonal, nontonal)
    
    % preprocessing - need to create an abs thresh vector that maps to the
    % 256 upper sideband indices..
    at = fca_table(:,3);
    f_ind = fca_table(:,4);
    at(isnan(at)) = [];
    f_ind(isnan(f_ind)) = [];
    abs_thresh = [];
    for ia = 1:length(at)
        if ia == length(at)
            val = ones(1+length(flag)-f_ind(ia),1)*at(ia);
        else
            val = ones(f_ind(ia+1)-f_ind(ia),1)*at(ia);
        end
        abs_thresh = [abs_thresh; val];                                     % created abs thresh vector from table to compare tonal and nontonal to
    end
    
    % preprocessing - need to create a bark frequency vector that maps to 
    % the 256 upper sideband indices..
    f_ind = fca_table(:,4);
    cbb_bark(isnan(cbb_bark)) = [];
    f_ind(isnan(f_ind)) = [];
	bark = [];
    for ia = 1:length(cbb_bark)
        if ia == length(cbb_bark)
            val = ones(1+length(flag)-f_ind(cbb(ia)),1)*cbb_bark(ia);
        else
            val = ones(f_ind(cbb(ia+1))-f_ind(cbb(ia)),1)*cbb_bark(ia);
        end
        bark = [bark; val];                                                 % created bark vector for comparison in step 3 of decimation
    end
    
    % decimation step 1: tonal decimation
    flag_new = flag;
    tonal_new = [];
    nontonal_new = [];
    
    if not((isempty(tonal)))
        for ia = 1:size(tonal,1)
            k = tonal(ia,2);                                                % setting index
            if tonal(ia,1) < abs_thresh(k)                                  % decimation of tonal components below abs threshold
                flag_new(k) = 0;                                            % 0 means ignore
            else
                tonal_new = [tonal_new; tonal(ia,:)];
            end
        end
    end
    
    % decimation step 2: nontonal decimation
    if not((isempty(nontonal)))
        for ia = 1:size(nontonal,1)
            k = nontonal(ia,2);                                             % setting index
            if nontonal(ia,1) < abs_thresh(k)                               % decimation of nontonal components below abs threshold
                flag_new(k) = 0;                                            % 0 means ignore
            else
                nontonal_new = [nontonal_new; nontonal(ia,:)];
            end
        end
    end

    % decimation step 3: decimation of tones within hald a bark
    if not(isempty(tonal_new))
       while ia < size(tonal_new,1)-1
           k = tonal_new(ia,2);
           k2 = tonal_new(ia+1,2);
           if bark(k2) - bark(k) < 0.5                                      % decimation of 2 tonal components within 0.5 bark
               if tonal_new(ia,1) < tonal_new(ia+1, 1)
                   tonal_new(ia,:) = [];                                    % remove the ia'th element
                   flag_new(k) = 0;
               else
                   tonal_new(ia+1,:) = [];                                  % remove the ia+1'th element
                   flag_new(k2) = 0;
               end
           end 
       end
    end
end