function [soundOut] = single_tap_delay(input, depth, delay, fbgain, constants)
    fs = constants.fs;
    while fs*delay < 441
       fs = fs*10 
    end
    soundOut = input;
    ia = 1;
    while rms(input) > 0.000001
        zeroVec = zeros(delay*fs*ia, 2);
        delayOut =  [zeroVec; input*depth];
        soundOut(end+1:end+delay*fs, :) = 0;                                   % Extending the length of the output vector with each iteration of the loop
        soundOut = soundOut + delayOut;
        input = input * fbgain;                                             % At the end of each loop, the input is affected by the feedback gain
        ia = ia+1;
    end
end