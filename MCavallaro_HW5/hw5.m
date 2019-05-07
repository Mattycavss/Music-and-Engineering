%%% Matthew Cavallaro %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Music and Engineering %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Homework 5: MPEG-1 Audio Layer 1 Encoder %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% User Inputs %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% pick an audio signal to test output
[audioIn, fs] = audioread('5000hz.wav');                                    % test signals
[audioIn, fs] = audioread('15000hz.wav');
[audioIn, fs] = audioread('20000hz.wav');
[audioIn, fs] = audioread('licks.wav');                                     % read in audio signal
% pick whether or not you want compression
compress = "false";
compress = "true";
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Initialization: loading audio file & relevant tables, setting constants
close all; clc
constants();                                                                % load in some constants
disp('Starting Initialization')
audio = audioIn(:,1);                                                       % just dealing with 1 channel
audio = [audio; zeros(frameSize - mod(size(audio,1),frameSize),1)];         % padding zeros to end of audio so that it divides evenly by frameSize
createCandD();                                                              % provided C and D lookup for poly-phase filter bank and inverse
[M, N] = MN_calc();                                                         % calculate M and N matrix for poly-phase filter bank and inverse                                                            
scaleFactors = table2array(readtable('layer1_scalefactors.xlsx'));          % loading in the scaling factors 
[fca_table] = freq_cbr_at_lookup(fs);                                       % loading frequency, critical band rates, absolute thresholds
[cbb, cbb_bark]= crit_band_boundaries_lookup(fs);                           % loading critical band boundaries
[snr_table] = table2array(readtable('snr.xlsx'));                           % loading snr for bit allocation portion of encoder
[quant_coeff_table] = table2array(readtable('quant_coeffs.xlsx'));          % loading quantization coefficients for quant/encoding of subband samples
disp('Finished Initialization')

%% Encoder
disp('Starting Polyphase Filter Bank')
disp('Starting Scale Factor Calculation')
disp('Starting Psychoacoustic Model/SMR Calculation')
disp('Looping frame by frame')
X = zeros(512,1);                                                           % preallocate sizes
filterOutMat = zeros(32, 12, size(audio,1)/frameSize);
scale_fact_Mat = zeros(32, size(audio,1)/frameSize);
scale_fact_ind_Mat = zeros(32, length(audio)/frameSize);
smrMat = zeros(32, length(audio)/frameSize);
ia = 1;
for ib = 1:frameSize:length(audio)                                          % looping through the audio, frame by frame. Vectorizing may be better for version 2.0
    [filter_out] = polyphase_filter_bank(audio, ib, M, C);                  % poly-phase filter bank step
    filterOutMat(:,:, ia) = filter_out;                                     % saving the filter output on each iteration in 3D array
    
    [scale_fact, scale_fact_ind] = scale_factor_calc(filter_out,...         % calculating the scale factors based on filter output
        scaleFactors);
    scale_fact_Mat(:,ia) = scale_fact;                                      % storing scale factors in a matrix                                      
    scale_fact_ind_Mat(:,ia) = scale_fact_ind;                              % storing scale factor indices in a matrix
    
    [signal_mask_ratio] = psycho_acoustic_model(audio, fs, ib,...           % psychoacoustic model 1
        fca_table, cbb, cbb_bark, scale_fact);
    smrMat(:,ia) = signal_mask_ratio;                                       % storing signal to mask ratios
    ia = ia+1;
end
disp('Finished Polyphase Filter Bank')
disp('Finished Scale Factor Calculation')
disp('Finished Psychoacoustic Model/SMR Calculation')

disp('Starting Bit Allocation')
disp('Starting Quantization of Signal')
encoded = cell(ia-1,1);
bpsb = zeros(32,1);                                                         % bits per subband
for ic = 1:(ia-1)
    bps = 32*12*15; bpsf = 6*32;                                            % bits per sample, bits per scale factor. This is the uncompressed default
    index = 15-1;
    if compress == "true"
        [bpsb, adb, id, bps, bpsf] = ...
            bit_allocation(smrMat, snr_table, ic, bpsb);                    % bit allocation. This step can be skipped if you want the full 15 bits representing your signal
         index = bpsb;
    end
    [quantOut] = quantization(bpsb, quant_coeff_table,...                   % quantization of the audio signal (ie compression)
        filterOutMat, scale_fact_Mat, ic, compress);
    encoded{ic} = quantOut;
end
disp('Encoding Complete')                                                   % NOTE: I did not complete all the bit stream formatting, I would need to build my own decoder to handle format
disp('Sample Encoded Frame:')
Sample = encoded{7}
