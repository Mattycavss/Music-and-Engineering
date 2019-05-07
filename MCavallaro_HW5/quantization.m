% Quantization step ie compression
% Reference: AnnexC

function [quantOut] = ...
    quantization(bpsb, quant_coeff_table, filterOutMat,...
scale_fact_Mat, ic, compress)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if compress == "true"                                                   % if we are compressing
        A = repmat(quant_coeff_table(bpsb+1,2),1,12);                       % use bits per subband as index of A table
        B = repmat(quant_coeff_table(bpsb+1,3),1,12);                       % use bits per subband as index of B table
    else
        A = repmat(quant_coeff_table(14,2),1,12);                           % otherwise use max number of bit representation
        B = repmat(quant_coeff_table(14,3),1,12);                           % 14 is last index in table
    end
    filter_out = filterOutMat(:,:,ic);                                      % pull in data from filter bank
    scale_fact = scale_fact_Mat(:,ic);                                      % pull in data from scale factor calculation
    X = filter_out./scale_fact;
    Xq = A.*X + B;                                                          % directly from the annex
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    quantOut = cell(32,12);
    for ia = 1:32
        for ib = 1:12
            if compress == "true"                                           % index depends on whether or not we are compressing
                index = bpsb(ia);
            else
                index = 14;
            end
            quantOut{ia,ib} = bin(Xq(ia,ib),index);                         % function to map audio signal to binary representation
        end
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
