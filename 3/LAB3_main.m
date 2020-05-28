%%  
clc
clear all
close all

%% 3.2
threshold2noise=0:0.1:15;
BW=zeros(10);
for counter=1:1:length(BW)
    BW(counter)=10^(counter-1);
end
Tfa = LAB3_function1_Tfa(threshold2noise,BW);
figure('Name','Exercise 3.2')
semilogy(threshold2noise,Tfa)
xlabel('Threshold to noise ratios');
ylabel('Time between false alarms [s]');
legend('1 Hz','10 Hz','100 Hz','1 kHz','10 kHz','100 kHz','1 MHz','10 MHz','100 MHz','1 GHz')

%% 3.6
Pd=0.3:0.01:0.99;
Pfa=[];
for i=-12:1:-3
    Pfa=[Pfa 10^i];
end
SNR = LAB3_function2_SNR(Pd,Pfa);
figure('Name','Exercise 3.6')
semilogy(SNR,Pd)
xlabel('Signal-to-noise ratio');
ylabel('Detection probabilities');
legend('1e-12','1e-11','1e-10','1e-9','1e-8','1e-7','1e-6','1e-5','1e-4','1e-3');







