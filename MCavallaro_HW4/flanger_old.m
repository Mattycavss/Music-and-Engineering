function [soundOut, fs] = flanger(input, depth, minDelay, widthTime, f, constants)
    widthAmp = widthTime/2;
    fsOld = constants.fs;
    fsNew = fsOld*(1000);
    w = 2*pi*f;
    t = 0:1/fsNew:length(input)/fsOld;
    t(end) = [];
    delay = widthAmp*sin(w*t) + minDelay + widthAmp;
    zeroPad = max(diff(fsOld*delay));
    zeroPad = 3;
    fs = fsOld * (zeroPad+1);
%     fsScale = 1;
%     fs = fsOld;
%     while fs < 1/widthAmp
%        fsScale = fsScale+1;
%        fs = fsOld * fsScale;
%     end
%     zeroPad = fsScale - 1;
    soundIn(:,1) = reshape([input(:,1)'; nan*zeros(zeroPad,...              % if fillmissing doesn't work with zeros, mult the zeros by nan
        length(input(:,1)'))],[],1);
    soundIn(:,2) = reshape([input(:,2)'; nan*zeros(zeroPad,...
        length(input(:,2)'))],[],1);
    soundDelay = zeros(size(soundIn));
    indexOld = 1;
    ia = 1;
    while indexOld < length(soundIn)
        delayInd = (fsOld*delay(ia))
        round(delayInd)
        indexNew = indexOld + round(delayInd);
        soundDelay(indexNew,:) = soundIn(indexOld,:);
        indexOld = indexOld + zeroPad + 1;
        ia = ia+1;
    end
    soundOut = [soundIn] + soundDelay*depth;
    tnew = 0:1/fs:length(soundOut)/fs;
    tnew(end) = [];
    [soundOut] = fillmissing(soundOut,'linear','SamplePoints',tnew);
end