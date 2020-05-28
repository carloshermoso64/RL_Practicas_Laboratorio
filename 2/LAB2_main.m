% Exercicis 1-2

Pt = 1.5e+6; %W
G = 45; %dBi
fc = 5.6e+9; %Hz
BW = 5e+6; %Hz
NF = 3; %dB
Lextra = 0; %dB
sigma = 1; %m^2
range = 20e3:1e3:200e3; %m

SNR2=radarEquation(Pt,G,fc,BW,NF,Lextra,sigma,range);

figure('Name','Ex2: Linear');
plot(range,SNR2);
title ('SNR wrt Target range (linear scale)');
xlabel('Target range [m]');
ylabel('SNR [dB]');

figure('Name','Ex2: Logarithmic scale');
semilogx(range,SNR2)
title ('SNR wrt Target range (logarithmic scale)');
xlabel('Target range [m]');
ylabel('SNR [dB]');
%% 

% Exercici 3
sigmaV = [0 -10 -20]; %dBm^2
i = 1;
figure('Name','Ex3');
while i <=3
    sigma = 10^(sigmaV(i)/10);
    SNR3=radarEquation(Pt,G,fc,BW,NF,Lextra,sigma,range);
    plot(range,SNR3);
    hold on
    i = i+1;
end
legend('0 dBm^2','-10 dBm^2','-20 dBm^2');
title ('SNR wrt Target range (different radar cross sections)');
xlabel('Target range [m]');
ylabel('SNR [dB]');
%% 

% Exercici 4
sigma = 1;
Pt_add = [0 3 6];
i = 1;
figure('Name','Ex4');
while i <=3
    Pt4 = Pt * 10^(Pt_add(i)/10);
    SNR4=radarEquation(Pt4,G,fc,BW,NF,Lextra,sigma,range);
    plot(range,SNR4);
    hold on
    i = i+1;
end
legend('No extra Pt','+3 dB','+6 dB');
title ('SNR wrt Target range (increased peak power)');
xlabel('Target range [m]');
ylabel('SNR [dB]');
%% 

% Exercici 5
sigma = 1;
i = 1;
figure('Name','Ex5');
while i <=2
    SNR5=radarEquation(Pt,G,fc,BW,NF,Lextra,sigma,range);
    plot(range,SNR5);
    hold on
    Lextra = 10; %dB
    Lextra = 10^(Lextra/10); %lineal
    i = i+1;
end
legend('No losses','-10 dB');
title ('SNR wrt Target range (additional losses)');
xlabel('Target range [m]');
ylabel('SNR [dB]');