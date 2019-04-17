% The envelope filter, used frequently by the Red Hot Chili Peppers, is an
% amplitude controlled filter. Plucking the string harder sweeps the filter
% to allow higher frequencies to pass, giving a sharp pluck/attack sound. 
function [soundOut] = envelope_filter(input, gain, threshold, numSamp)
    soundIn = input./max(abs(input))*gain;                                       % normalize
    soundOut = zeros(size(soundIn));    
    fcut_low = 3000/20000;                                                  % normalize to the max audible frequency
    fcut_high = 1500/20000;
    [b1,a1] = cheby1(4,1,fcut_low, 'low');
    [b2,a2] = cheby1(4,1,fcut_high,'high');
    for ib = 1:size(soundIn,2)
        for ia = 1:length(soundIn)
            if (ia < numSamp)
                power = rms(soundIn(1:ia,ib));
            else
                power = rms(soundIn(ia-numSamp+1:ia,ib));
            end
            if power > threshold
                filtToggle = 1-(power-threshold)/threshold;
            else
                filtToggle = 1;
            end
            soundOut(ia,ib)=filter(b1,a1,soundIn(ia,ib))*(1-filtToggle)+ ...                       % interpolate between highpass and lowpass with the filt setting
                filter(b2,a2,soundIn(ia,ib))*filtToggle;
        end
    end
end
