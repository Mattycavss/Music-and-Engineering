function [soundOut] = ring_modulator(input, freq, depth, constants)
    osc1 = oscillator(freq, depth*constants.amp, constants);
    soundOut = input.*osc1;
    % may need to break the left and right channel up
end
