% Sound pressure calculation
% Reference: ANNEX_D.docx 3-D.1. Psychoacoustic Model I

function [Lsb] = sound_pressure_calc(scale_fact_max, Xk)
    Lsb = zeros(32,1);
%     plot(Xk)                                                              % plot the spectrum for reference. Use only upper sideband
    for k = 1:32                                                            % looping through subbands
        inds = (1+8*(k-1)):(8*k);                                           % indices for the spectral line: 256 for upper sideband. 
                                                                                % 32 equally spaced bands results in 256/32 samples per subband
        Xk_mod = max(Xk(inds));
        Lsb(k) = max(Xk_mod, 20*log10(scale_fact_max(k)*32768)-10);         % take max(fft term and scale fact term)
    end
end