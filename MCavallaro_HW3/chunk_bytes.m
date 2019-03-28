% The purpose of this function is to take an input and chunk the bytes
% together so that, for example, a 3 byte input is not a 1x3 array of 
% decimal numbers between 0 and 255, but a single value between 0 and 
% 16777215. This function also serves to convert the input to any number
% system of the users choice. No second argument means binary, second
% argument of value 1 is hex, and a second argument of value 0 is decimal.
function [out] = chunk_bytes(input, varargin)
    input_hex = dec2hex(input,2);
    output_hex = ''; 
    for ia = 1:length(input)
        output_hex = strcat(output_hex, input_hex(ia,1:end));
    end
    if length(varargin) >= 1 
        if varargin{1} == 1
            out = output_hex;
        elseif varargin{1} == 0
            out = hex2dec(output_hex);
        else
            error('Invalid number system handle for chunk_bytes function.')
        end
    else
        out = dec2bin(hex2dec(output_hex));
    end
end