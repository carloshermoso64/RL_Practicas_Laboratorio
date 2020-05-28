%function that generates a baseband signal corresponding to a given code 
%at a given SNR level. The output of the function should be the vector of 
%the baseband signal samples without the noise and the vector of the baseband signal samples with noise.
function [vsignalsin,vsignalcon,vruido,ts]=baseband_signal(pulseduration,N,v_phases,v_amplitudes,SNR)

K=length(v_phases); 
ts=pulseduration/(length(v_phases)*N);
vphases=ones(N,1)*exp(1j*v_phases);
vamplis=ones(N,1)*v_amplitudes;
vsignalsin=vphases.*vamplis;
vsignalsin=reshape(vsignalsin,1,N*K); %lo que tengo en diferentes filas me lo pone en una sola

signal_E=sum(0.5*abs(vsignalsin).^2)/N;
noise_E=2*signal_E/10.^(SNR/10);
vnoise=randn(size(vsignalsin))+1j*randn(size(vsignalsin));
vruido=vnoise/sum(abs(vnoise).^2)*noise_E;
vsignalcon=vsignalsin+vruido;

end
