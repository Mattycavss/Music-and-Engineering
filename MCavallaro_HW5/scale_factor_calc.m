% Scale Factor calculation
% Reference: ANNEX_C.docx, 3-C.1.5.1 Layer I Encoding, 4

function [scale_fact, scale_fact_ind] = scale_factor_calc(filterIn,...
    scale_data)
    scale_fact = zeros(32,1);                                               % preallocate size
    scale_fact_ind = zeros(32,1);
    for ia = 1:32                                                           % loop through subbands
        val = max(abs((filterIn(ia,:))));                                   % finding max of absolute value
        if val > max(abs(scale_data))
            scale_fact(ia) = max(abs(scale_data));                          % if val is greater than the max value in scale data, use the max value in scale data
            scale_fact_ind(ia) = find(max(abs(scale_data)));
        else
            scale_fact_ind(ia) = find(scale_data>val, 1, 'last');           % otherwise use the last value greater than val in the table
            scale_fact(ia) = scale_data(scale_fact_ind(ia));
        end
    end
end