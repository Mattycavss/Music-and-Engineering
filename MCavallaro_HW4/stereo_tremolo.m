function [soundOut] = stereo_tremolo(input, lfo_type, lfo_rate, ...
    stereo_lag, depth, constants)
    if size(input,2)~= 2
        error('Must use a track with 2 channels')
    end
    lag = stereo_lag*1e-3; 
    w = 2*pi*lfo_rate;
    t = constants.t;
    input_left = input(:,1);
    input_right = input(:,2);
    switch lfo_type
        case {'sin'}
            lfo_left = depth*constants.amp*sin(w*t);
            phase = lag/(1/lfo_rate)*2*pi;
            lfo_right = depth*constants.amp*sin(w*t + phase);
        case {'triangle'}
            lfo_left = depth*constants.amp*sawtooth(w*t,0.5);
            phase = lag/(1/lfo_rate)*2*pi;
            lfo_right = depth*constants.amp*sawtooth(w*t + phase,0.5);
        case {'square'}
            lfo_left = depth*constants.amp*square(w*t, 50);
            phase = lag/(1/lfo_rate)*2*pi;
            lfo_right = depth*constants.amp*square(w*t + phase, 50);
        otherwise
            error('invalid lfo_type setting')
    end
    soundOut(:,1) = input_left .* (constants.amp + lfo_left');
    soundOut(:,2) = input_right .* (constants.amp + lfo_right');
end
