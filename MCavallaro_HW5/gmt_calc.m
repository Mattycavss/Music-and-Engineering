% Calculation of global masking threshold
% Anned D step 7... The equation is missing so I found this website:
% http://www.engr.usask.ca/classes/CME/462/notes/mycme462-mp3flterbank.pdf
% Go to slide 62

function [LTg] = gmt_calc(fca_table, LTtm, LTnm)
    for i = 1:length(fca_table)
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        LTg(i) = 10^(fca_table(i,3)/10);                                    % threshold in quiet
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                          % PLUS
       	if ~(isempty(LTtm))                                                 % sum of tonal maskers
            for j = 1:size(LTtm,1)
                LTg(i) = LTg(i) + 10^(LTtm(j,i)/10);
            end
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                          % PLUS
        if ~(isempty(LTnm))                                                 % sum of nontonal maskers
            for j = 1:size(LTnm,1)
                LTg(i) = LTg(i) + 10^(LTnm(j,i)/10);
            end
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                          % EQUALS
        LTg(i) = 10*log10(LTg(i));                                          % global masking threshold LTg
    end
end