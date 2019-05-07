% Bit allocation
% Reference: Annex C and Pan paper

function [bpsb, adb, index, bps, bpsf] = ...
        bit_allocation(smrMat, snr_table, ic, bpsb)
    constants()
    bps = 0; bpsf = 0;                                                      % bits per sample, bits per scale factor
    smr = smrMat(:,ic);
    index = 1;
    while adb > 0                                                           % break the loop if there are no more available databits
        if(bpsb(index) == (15-1))                                           % break this loop if we are using all 15 bits to represent
            break;
        end
        if(snr_table(bpsb(index) + 1, 2) - smr(index) < mnr_min)            % if we don't meet the minimum mask noise ratio, adjust
            bpsb(index) = bpsb(index) + 1;
            if (bpsb(index) == 1)                                           % if we have a bit allocation
                bpsb(index) = bpsb(index) + 1;                              % add one bit to the bits per subband
                bpsf = bpsf + 6;                                            % increment bits per scale fact by 6
                bps = bps + 12;                                             % increment bits per sample by 12
            end
            bps = bps + 12;                                                 % add 12 to bits per sample regardless in index
        end
        index = rem(index+1,33);                                            % remainder for indexing
        index(index==0) = 1;                                                % this ensured we don't get an invalid matlab index
        if(sum(snr_table(bpsb+1, 2) > smr) == 32)                           % break if all 32 sidebands satisfy the condition snr > smr
            break;
        end
        adb = cb-bbal-bpsf-bps-bheader;                                     % update the available data bits
    end  
end