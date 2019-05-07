% Calculation of individual masking thresholds
% Annex D step 6

function [LTtm, LTnm] = imt_calc(fca_table, Xk, tonal, nontonal, bark)

    LTtm = zeros(size(tonal,1), size(fca_table,1));                         % preallocate sizes
    LTnm = zeros(size(nontonal,1), size(fca_table,1));
    
    % This is all directly from the cookbook. I don't know WTH is going on.
    for ia = 1:size(fca_table,1)
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        zi = fca_table(ia,2);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if ~isempty(tonal)
            for k = 1:size(tonal,1)
                ib = tonal(k,2);
                zj = bark(ib);
                dz = zi - zj;
                if dz < 8 && dz >= -3
                    avtm = -1.525 - 0.275 * zj - 4.5;
                    if (-3 <= dz && dz < -1)
                        vf = 17*(dz+1) - (0.4*Xk(ib)+6);
                    elseif (-1 <= dz && dz < 0)
                        vf = (0.4*Xk(ib) + 6)*dz;
                    elseif (0 <= dz && dz < 1)
                        vf = -17*dz;
                    elseif (1 <= dz && dz < 8)
                        vf = -(dz-1)*(17 - 0.15*Xk(ib)) - 17;
                    end
                    LTtm(k, ia) = tonal(k, 1) + avtm + vf;
                end
            end
        else
            LTtm = [];
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if ~isempty(nontonal)
            for k = 1:size(nontonal,1)
                ib = nontonal(k,2);
                zj = bark(ib);
                dz = zi - zj;
                if dz < 8 && dz >= -3
                    avnm = -1.525 - 0.175 * zj - 0.5;
                    if (-3 <= dz && dz < -1)
                        vf = 17*(dz+1) - (0.4*Xk(ib)+6);
                    elseif (-1 <= dz && dz < 0)
                        vf = (0.4*Xk(ib) + 6)*dz;
                    elseif (0 <= dz && dz < 1)
                        vf = -17*dz;
                    elseif (1 <= dz && dz < 8)
                        vf = -(dz-1)*(17 - 0.15*Xk(ib)) - 17;
                    end
                    LTnm(k, ia) = nontonal(k, 1) + avnm + vf;
                end
            end
        else
            Ltnm = [];
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    end
end
