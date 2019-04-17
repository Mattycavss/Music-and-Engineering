function [soundOut, fs] = flanger(input, depth, minDelay, widthTime, f, constants)
    widthAmp = widthTime/2;
    fs = constants.fs;
    w = 2*pi*f;
    t = 0:1/fs:length(input)/fs;
    t(end) = [];
    delay = widthAmp*sin(w*t) + minDelay + widthAmp;
    delayInds = ceil(delay*fs);
    delayOut = zeros(size(input));
    for ia = max(delayInds):(length(input))
        delayInd = delayInds(ia);
        delayOut(ia,:) = input(ia - delayInd + 1,:);
    end
    soundOut = delayOut*depth + input;
end