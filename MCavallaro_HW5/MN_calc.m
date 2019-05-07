% Create M matrix for poly-phase filter bank in the encoder, as well as Mp 
% for the inverse poly-phase in the decoder.
% References: ANNEX_C.docx and MPGAUDIO.docx
function [Mik, Nik] = MN_calc()
    Mik = zeros(32,64);
    for i=0:31
        for k=0:63
            Mik(i+1, k+1) = cos((2*i+1)*(k-16)*pi/64);
        end
    end
    Nik = zeros(32,64);
    for i=0:31
        for k=0:63
            Nik(i+1, k+1) = cos((2*i+1)*(k+16)*pi/64);
        end
    end
end