function [soundOut, gain] = compressor(input, threshold, slopeIn, numSamp)
    soundIn = input./max(abs(input));                                       % normalize
    soundOut = zeros(size(soundIn));
    gain = zeros(size(soundIn));
    for ib = 1:size(soundIn,2)
        for ia = 1:length(soundIn)
            slope = slopeIn;
            if (ia < numSamp)
                power = rms(soundIn(1:ia,ib));
            else
                power = rms(soundIn(ia-numSamp+1:ia,ib));
            end
            if power > threshold 
                if (power - threshold) < (1-slope)*threshold                    % smoothing the transition between slopes
                    slope = 1-(power-threshold)/threshold;
                end
                soundOut(ia,ib) = slope*soundIn(ia,ib);
            else
                soundOut(ia,ib) = soundIn(ia,ib);
            end
        end
        gain(:,ib) = soundOut(:,ib)./soundIn(:,ib); 
    end
end