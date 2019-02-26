function [out] = oscillatorFM(f,amp,constants)
    w = 2*pi*f;
    t = constants.t;
    out = zeros(size(f,1),length(t));
    for ia = 1:size(f,1)
        out(ia,:) = amp.*sin(w(ia,:).*t + 0); 
    end
end