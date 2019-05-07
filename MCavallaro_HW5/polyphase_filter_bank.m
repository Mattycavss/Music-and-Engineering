% Cookbook formula for polyphase filter bank. 
% Reference: ANNEX_C.docx

function [filterOut] = polyphase_filter_bank(audio, ia, M, C)               % ingredients
    X = zeros(512,1);                                                       % prealloc sizes
    filterOut = zeros(32,12);
%     S = zeros(32,1);
    for ib = 1:12                                                           % looping through 12 samples
        offset = ia+32*(ib-1);                                              % define offset to shift through samples
        for ic = 512:-1:33                                                  % step1: shifting by num frames
            X(ic) = X(ic-32);
        end
        X(32:-1:1) = audio(offset:offset+31);                               % step2: fill in audio segment
        Z = C.*X;                                                           % step3: window by 512 coeff, produce Z vector
        Y = zeros(64,1);
        for id = 1:64                                                       % step4: partial calculation
%             length(Z(ic:64:end)) == 8;                                    % verify the size is 8, as the formula expects                      
            Y(id) = sum(Z(id:64:end));
        end
        S = M*Y;
        filterOut(:,ib) = S;                                                % filterOut is 32 x 12 as desired
    end
end
