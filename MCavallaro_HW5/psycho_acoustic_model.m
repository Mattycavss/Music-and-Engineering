% Psychoacoustic model is from Psychoacoustic Model 1 from Annex D, 3-D.1

function [smr] = psycho_acoustic_model(audio, fs, ia, fca_table, cbb,...
    cbb_bark, scale_fact_max)
    [Xk] = fft_analysis(audio, ia);                                         % step1: fft analysis
    [Lsb] = sound_pressure_calc(scale_fact_max, Xk);                        % step2: determination of sound pressure lvl
                                                                            % step3: consideration of the threshold in quiet: import tables
    [fca_table, flag, tonal, nontonal] = tone_calc(fs, fca_table, cbb, Xk); % step4: finding the tonal and non-tonal components
    [flag, tonal, nontonal, bark] = decimation(fca_table,...                % step5: decimation of tonal and non-tonal masking components
        cbb, cbb_bark, flag, tonal, nontonal);
    [LTtm, LTnm] = imt_calc(fca_table, Xk, tonal, nontonal, bark);          % step6: individual masking threshold calculation
    [LTg] = gmt_calc(fca_table, LTtm, LTnm);                                % step7: global masking threshold calculation
    [LTmin] = mmt_calc(fca_table, LTg, flag);                               % step8: minimum masking threshold calculation
    smr = Lsb - LTmin;                                                      % step9: signal-mask-ratio calc
end