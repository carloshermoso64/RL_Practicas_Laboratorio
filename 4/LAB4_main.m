%%  
clc
clear all
close all

%% 4.2

% Data
SNR=30; % dB
tau=1e-6; % s
nsamples=20; % samples/chip

% Barker code K=5
Vampl_5=ones(1,5);
Vphases_5=[0 0 0 180 0];
[signal_5,noise_5,signal_real_5,Ts_5] = LAB4_function1_basebandsignal(tau,nsamples,Vphases_5,Vampl_5,SNR);
timev_5=Ts_5:Ts_5:tau;

% Barker code K=7
Vampl_7=ones(1,7);
Vphases_7=[0 0 0 180 180 0 180];
[signal_7,noise_7,signal_real_7,Ts_7] = LAB4_function1_basebandsignal(tau,nsamples,Vphases_7,Vampl_7,SNR);
timev_7=Ts_7:Ts_7:tau;

% Barker code K=11
Vampl_11=ones(1,11);
Vphases_11=[0 0 0 180 180 180 0 180 180 0 180];
[signal_11,noise_11,signal_real_11,Ts_11] = LAB4_function1_basebandsignal(tau,nsamples,Vphases_11,Vampl_11,SNR);
timev_11=Ts_11:Ts_11:tau;

% Barker code K=13
Vampl_13=ones(1,13);
Vphases_13=[0 0 0 0 0 180 180 0 0 180 0 180 0];
[signal_13,noise_13,signal_real_13,Ts_13] = LAB4_function1_basebandsignal(tau,nsamples,Vphases_13,Vampl_13,SNR);
timev_13=Ts_13:Ts_13:tau;

% Plot
figure('Name','Exercise 4.2')
subplot(2,2,1)
plot(timev_5*1e6,real(signal_real_5))
xlabel('Time (us)')
ylabel('Amplitude (V)')
title('Barker code K=5')
subplot(2,2,2)
plot(timev_7*1e6,real(signal_real_7))
xlabel('Time (us)')
ylabel('Amplitude (V)')
title('Barker code K=7')
subplot(2,2,3)
plot(timev_11*1e6,real(signal_real_11))
xlabel('Time (us)')
ylabel('Amplitude (V)')
title('Barker code K=11')
subplot(2,2,4)
plot(timev_13*1e6,real(signal_real_13))
xlabel('Time (us)')
ylabel('Amplitude (V)')
title('Barker code K=13')

%% 4.3

% Barker code K=5
voutsignal_5=conv(signal_real_5,conj(fliplr(signal_5)));
voutsignal_5_norm=voutsignal_5/nsamples;
voutsignal_5_dB=20*log10(voutsignal_5_norm);
vtime_5=(0:length(voutsignal_5)-1)*Ts_5;

% Barker code K=7
voutsignal_7=conv(signal_real_7,conj(fliplr(signal_7)));
voutsignal_7_norm=voutsignal_7/nsamples;
voutsignal_7_dB=20*log10(voutsignal_7_norm);
vtime_7=(0:length(voutsignal_7)-1)*Ts_7;

% Barker code K=11
voutsignal_11=conv(signal_real_11,conj(fliplr(signal_11)));
voutsignal_11_norm=voutsignal_11/nsamples;
voutsignal_11_dB=20*log10(voutsignal_11_norm);
vtime_11=(0:length(voutsignal_11)-1)*Ts_11;

% Barker code K=13
voutsignal_13=conv(signal_real_13,conj(fliplr(signal_13)));
voutsignal_13_norm=voutsignal_13/nsamples;
voutsignal_13_dB=20*log10(voutsignal_13_norm);
vtime_13=(0:length(voutsignal_13)-1)*Ts_13;

% Plot
figure('Name','Exercise 4.3 - linear plot')
subplot(2,2,1)
plot(vtime_5*1e6,real(voutsignal_5_norm))
xlabel('Time (us)')
ylabel('Amplitude (V)')
title('Barker code K=5')
subplot(2,2,2)
plot(vtime_7*1e6,real(voutsignal_7_norm))
xlabel('Time (us)')
ylabel('Amplitude (V)')
title('Barker code K=7')
subplot(2,2,3)
plot(vtime_11*1e6,real(voutsignal_11_norm))
xlabel('Time (us)')
ylabel('Amplitude (V)')
title('Barker code K=11')
subplot(2,2,4)
plot(vtime_13*1e6,real(voutsignal_13_norm))
xlabel('Time (us)')
ylabel('Amplitude (V)')
title('Barker code K=13')
figure('Name','Exercise 4.3 - dB plot')
subplot(2,2,1)
plot(vtime_5*1e6,real(voutsignal_5_dB))
xlabel('Time (us)')
ylabel('Amplitude (V)')
title('Barker code K=5')
subplot(2,2,2)
plot(vtime_7*1e6,real(voutsignal_7_dB))
xlabel('Time (us)')
ylabel('Amplitude (V)')
title('Barker code K=7')
subplot(2,2,3)
plot(vtime_11*1e6,real(voutsignal_11_dB))
xlabel('Time (us)')
ylabel('Amplitude (V)')
title('Barker code K=11')
subplot(2,2,4)
plot(vtime_13*1e6,real(voutsignal_13_dB))
xlabel('Time (us)')
ylabel('Amplitude (V)')
title('Barker code K=13')

%% 4.4

% SNR = 30 dB
snr_1=30;
[signal_1,noise_1,vinsignal_1,Ts_1] = LAB4_function1_basebandsignal(tau,nsamples,Vphases_13,Vampl_13,snr_1);
voutsignal_1=conv(vinsignal_1,conj(fliplr(signal_1)))/nsamples;

% SNR = 20 dB
snr_2=20;
[signal_2,noise_2,vinsignal_2,Ts_2] = LAB4_function1_basebandsignal(tau,nsamples,Vphases_13,Vampl_13,snr_2);
voutsignal_2=conv(vinsignal_2,conj(fliplr(signal_2)))/nsamples;

% SNR = 10 dB
snr_3=10;
[signal_3,noise_3,vinsignal_3,Ts_3] = LAB4_function1_basebandsignal(tau,nsamples,Vphases_13,Vampl_13,snr_3);
voutsignal_3=conv(vinsignal_3,conj(fliplr(signal_3)))/nsamples;

% SNR = 0 dB
snr_4=0;
[signal_4,noise_4,vinsignal_4,Ts_4] = LAB4_function1_basebandsignal(tau,nsamples,Vphases_13,Vampl_13,snr_4);
voutsignal_4=conv(vinsignal_4,conj(fliplr(signal_4)))/nsamples;

% SNR = -10 dB
snr_5=-10;
[signal_5,noise_5,vinsignal_5,Ts_5] = LAB4_function1_basebandsignal(tau,nsamples,Vphases_13,Vampl_13,snr_5);
voutsignal_5=conv(vinsignal_5,conj(fliplr(signal_5)))/nsamples;

% Plot
figure('Name','Exercise 4.4 - SNR=30dB')
subplot(2,1,1)
plot(timev_13*1e6,real(vinsignal_1))
xlabel('Time (us)')
ylabel('Amplitude (V)')
title('Input signal')
subplot(2,1,2)
plot(vtime_13*1e6,real(voutsignal_1))
xlabel('Time (us)')
ylabel('Amplitude (V)')
title('Output signal')
figure('Name','Exercise 4.4 - SNR=20dB')
subplot(2,1,1)
plot(timev_13*1e6,real(vinsignal_2))
xlabel('Time (us)')
ylabel('Amplitude (V)')
title('Input signal')
subplot(2,1,2)
plot(vtime_13*1e6,real(voutsignal_2))
xlabel('Time (us)')
ylabel('Amplitude (V)')
title('Output signal')
figure('Name','Exercise 4.4 - SNR=10dB')
subplot(2,1,1)
plot(timev_13*1e6,real(vinsignal_3))
xlabel('Time (us)')
ylabel('Amplitude (V)')
title('Input signal')
subplot(2,1,2)
plot(vtime_13*1e6,real(voutsignal_3))
xlabel('Time (us)')
ylabel('Amplitude (V)')
title('Output signal')
figure('Name','Exercise 4.4 - SNR=0dB')
subplot(2,1,1)
plot(timev_13*1e6,real(vinsignal_4))
xlabel('Time (us)')
ylabel('Amplitude (V)')
title('Input signal')
subplot(2,1,2)
plot(vtime_13*1e6,real(voutsignal_4))
xlabel('Time (us)')
ylabel('Amplitude (V)')
title('Output signal')
figure('Name','Exercise 4.4 - SNR=-10dB')
subplot(2,1,1)
plot(timev_13*1e6,real(vinsignal_5))
xlabel('Time (us)')
ylabel('Amplitude (V)')
title('Input signal')
subplot(2,1,2)
plot(vtime_13*1e6,real(voutsignal_5))
xlabel('Time (us)')
ylabel('Amplitude (V)')
title('Output signal')

%% 4.5

% Data
Ppeak=1.5e6; % W
Gantenna=45; % dBi
fc=1.1e9; % Hz
BW=50e6; % Hz
L=0; % dB
RCS=1; % m^2
Rvector=30e3; % m
% RLNA09M01G data
G_LNA=37; % dB
NF_LNA=1.2; % dB
% Coaxial RG-8x data      
f_wire=1.1e9; % Hz
At_wire=0.27; % dB/m
length_wire=10; %m
G_wire=-At_wire*length_wire; % dB
NF_wire=-G_wire; % dB 
% RF BPF data
IL_RFfilter=1; % dB 
G_RFfilter=-IL_RFfilter; % dB 
NF_RFfilter=-G_RFfilter; % dB 
% Mixer & LO data
NF_mixer=5.5; % dB
CL_mixer=6; % dB
G_mixer=-CL_mixer; % dB 
% IF BPF data
IL_IFfilter=1; % dB
G_IFfilter=-IL_IFfilter; % dB 
NF_IFfilter=-G_IFfilter; % dB 
% IF Ampl data
G_IFampl=11; % dB
NF_IFampl=1.1; % dB
% Scenario 1: LNA close to the antenna
Gvector=[G_LNA,G_wire,G_RFfilter,G_mixer,G_IFfilter,G_IFampl];
NFvector=[NF_LNA,NF_wire,NF_RFfilter,NF_mixer,NF_IFfilter,NF_IFampl];

% Functions
[NF,G] = LAB2_function1_NoiseFigure(Gvector,NFvector);
SNRvector = LAB2_function2_SNR(Ppeak,G,fc,BW,NF,L,RCS,Rvector)














