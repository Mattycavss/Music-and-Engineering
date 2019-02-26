function [out] = noiseGen(fr,amp,constants)
    duration = constants.durationChord;
    fs = constants.fs;
    t = constants.t;
    % noise generated at rate fr<fs, with linear interpolation to smooth. Further dampens high frequencies.
    for ia = 1:(fr*duration)
        ampInd = (ia-1)*round(fs/fr)+1;
        y = 2*amp(ampInd)*rand(1,1) - amp(ampInd);
        out(ia) = y;
    end
    t1 = linspace(0,length(out),fr*duration);
    t2 = linspace(0,length(out),fs*duration);
    out = interp1(t1,out,t2);
end