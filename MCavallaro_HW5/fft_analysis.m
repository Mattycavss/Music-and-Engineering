% Fft analysis function
% Reference: ANNEX_D.docx 3-D.1. Psychoacoustic Model I
% I am pretty sure the formula they gave for psd is wrong...
% I used this matlab page as a reference: 
% https://www.mathworks.com/help/signal/ug/power-spectral-density-estimates-using-fft.html

function [Xk] = fft_analysis(audioIn,ia)    
    N = 512;                                                                % N power of 2 for fft
    ib = 64:N-1+64;                                                         % shifting window forward by 64 samples
    hi = 0.5*(1-cos(2*pi*(ib)/(N-1))); hi = hi';                            % Hann window
    
    % This try catch is for the final frame. The audio probably won't have
    % an even multiple of N samples since the frame size isn't a multiple 
    % of N. Pad the ending with zeros.
    try
        audio = audioIn(ia:ia+512-1);                                       % filling audio signal into buffer of N length
    catch
        audio = [audioIn(ia:end); zeros(N-length(audioIn(ia:end)),1)];      % for the last frame in the loop
    end
    
    % power density spectrum from matlab example. I am pretty sure the
    % equation given in the annex is wrong. 
    xdft = fft(audio.*hi, N);                                               % fft double sideband
    xdft2 = xdft(1:N/2);                                                    % shorten to single sideband
    psdx = (1/(2*pi*N)) * abs(xdft2).^2;                                    % power spectral density equation
    psdx(2:end-1) = 2*psdx(2:end-1);                                        % not sure about this step but the matlab example did this
    pds = 10*log10(psdx);                                                   % power density spectrum from matlab example
    Xk = pds+(96-max(pds));                                                 % normalize to the reference level of 96 dB SPL
end
