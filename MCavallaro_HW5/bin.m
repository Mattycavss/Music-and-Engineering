function [bin] = bin(dec,bit_allocation)
    if bit_allocation == 0
        bin = '';
        return
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    if dec < 0
        bin = '1';
        dec = 1 + dec;
    else
        bin = '0';
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    for ia = 1:bit_allocation-1
        if (dec - 2^(-ia))>0
            dec = dec - 2^(-ia);
            bin = [bin '1'];
        else
            bin = [bin '0'];
        end
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%
end
    