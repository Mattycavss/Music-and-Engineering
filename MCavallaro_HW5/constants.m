% set all constants

frameSize = 384;                                                            % size of dataframe from Pan paper. 12 samples in each of the 32 subbands    
cb = 128e3;                                                                 % number of bits available per frame. Somewhat arbitrary?
% I think Pan paper says layer 1 suits datarates of > 128kbps. I may be
% misunderstanding this.
mnr_min = 5;                                                                % setting a minimum mask to noise ratio to ensure the quantization cannot be heard
bbal = 128; bheader = 32;                                                   % mpeg1 standards for mono audio signal
adb = cb - bbal - bheader;                                                  % available data bits. Subtract out other fields from frame
