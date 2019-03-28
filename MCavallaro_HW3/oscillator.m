function [out] = oscillator(f,amp,constants)
    w = 2*pi*f;
    t = constants.t;
    
    out = zeros(size(f,1),length(t))';
    for ia = 1:size(f,2)
        out(:,ia) = amp.*sin(w(ia)*t ); % phase shifting to lead to immediate attack for the drum.
    end
end