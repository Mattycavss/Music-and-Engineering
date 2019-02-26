function [out] = oscillator(f,amp,constants)
    w = 2*pi*f;
    duration = constants.durationChord;
    fs = constants.fs;
    t = constants.t;
    phase = pi/8;
    out = zeros(size(f,1),fs*duration);
    for ia = 1:size(f,2)
        out(ia,:) = amp.*sin(w(ia)*t + phase); % phase shifting to lead to immediate attack for the drum.
    end
end