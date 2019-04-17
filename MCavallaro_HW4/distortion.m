% For my distortion, I decided to use soft clipping by using the hpyerbolic
% tangent function. Soft clipping sounds nicer than hard clipping because
% there are no sharp discontinuities. A gradual increase in amplitude
% results in a gradual smooth increase in the total harmonic distortion.
% This is opposed to hard clipping which clips everything beyond a
% threshold abrubtly. This has its uses, but for the sound I was
% attempting, soft clipping was more appropriate. Next, I used a highpass
% and lowpass filter to control the tone. The tone input selects the degree
% to which the output takes from the lowpass filtered soft clipped signal
% and from the highpass filtered soft clipped signal. I set the cutoff
% frequencies a decade apart and overlapping so they function as a
% bandpass filter together, which spans the range 200 - 2000 Hz. This is a
% good range to function over for the given input audio signal. Overall the
% distortion sounds like a calming buzz over the guitar. 
function [soundOut] = distortion(input, gain, tone, constants)
        dur = constants.duration;
        fs = constants.fs;
        input = input * gain;
        softClip = tanh(input);                                             % hyperbolic tangent is a good looking function for soft clipping
%         soundOut = softClip;
        fcut_low = 2000/20000;                                              % normalize to the max audible frequency
        fcut_high = 200/20000;
        [b1,a1] = cheby1(4,1,fcut_low, 'low');
        [b2,a2] = cheby1(4,1,fcut_high,'high');

        soundOut=filter(b1,a1,softClip)*(1-tone)+ ...                       % interpolate between highpass and lowpass with the tone setting
            filter(b2,a2,softClip)*tone;
end