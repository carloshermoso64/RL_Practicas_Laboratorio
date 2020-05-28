%% Generates a baseband signal given a barker code

% INPUTS:
    % Pulse duration (tau) [s]
    % Number of samples per chip (nsamples) []
    % Vector of chip phases (Vphases) [º]
    % Vector of chip amplitud (Vampl) [] 
    % Signal-to-noise ratio (SNR) [dB]
% OUTPUTS:
    % Samples of the baseband output signal vector without noise (s_bb) []
    % Samples of the generated noise vector (noise) []
    % Samples of the baseband output signal vector with noise (s_bb_real) []
    % Sampling time (Ts) [s]
    % Noise power (N0) [W]

function [signal,noise,signal_real,Ts,N0] = LAB4_function1_basebandsignal(tau,nsamples,Vphases,Vampl,SNR)

    % Unit changes
    Vphases=Vphases.*(pi/180); 
    
    % Equations
    npulses=length(Vphases);    
    Ts=tau/(npulses*nsamples);
    
    % Pulsed signal
    pulses=Vampl.*exp(1i.*Vphases);
    signal=[];
    for count=1:1:npulses
        for chips=1:1:nsamples
            signal=[signal pulses(count)];
        end
    end
    Esignal=sum(0.5*abs(signal.^2))/nsamples;
    
    % Noise
    N0=2*Esignal/(10^(SNR/10));
    randomnoise=randn(size(signal))+(1j*randn(size(signal)));
    noise=N0*randomnoise/sum(abs(randomnoise.^2));
    
    % Real signal
    signal_real=signal+noise;
    
end