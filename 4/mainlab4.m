clc
clear all

N=20;
SNR=1.5;% ruido de la práctica anterior 
pulseduration=1e-6;

%barker4
amplis4=[1 1 1 1];
phases4=[0 0 pi 0];

%barker 7
amplis7=[1 1 1 1 1 1 1];
phases7=[0 0 0 pi pi 0 pi];

%barker 11
amplis11=[1 1 1 1 1 1 1 1 1 1 1];
phases11=[0 0 0 pi pi pi 0 pi pi 0 pi];

%barker 13
amplis13=[1 1 1 1 1 1 1 1 1 1 1 1 1];
phases13=[0 0 0 0 0 pi pi 0 0 pi 0 pi 0];



[vsignalsin4,vsignalcon4,vnoise4,ts4]=baseband_signal(pulseduration,N,phases4,amplis4,SNR);
[vsignalsin7,vsignalcon7,vnoise7,ts7]=baseband_signal(pulseduration,N,phases7,amplis7,SNR);
[vsignalsin11,vsignalcon11,vnoise11,ts11]=baseband_signal(pulseduration,N,phases11,amplis11,SNR);
[vsignalsin13,vsignalcon13,vnoise13,ts13]=baseband_signal(pulseduration,N,phases13,amplis13,SNR);

tsvector4=(0:length(vsignalsin4)-1)*ts4; %eje de las x
tsvector7=(0:length(vsignalsin7)-1)*ts7;
tsvector11=(0:length(vsignalsin11)-1)*ts11;
tsvector13=(0:length(vsignalsin13)-1)*ts13;
vpos4=(1:N:length(vsignalsin4));
vpos7=(1:N:length(vsignalsin7));
vpos11=(1:N:length(vsignalsin11));
vpos13=(1:N:length(vsignalsin13));

figure(1)
plot(tsvector4,(vsignalsin4),'-b'); hold on;
plot(tsvector4,(vsignalsin4),'b.'); hold on;
plot(tsvector4,(vsignalcon4),'r-'); hold on;
plot(tsvector4,(vsignalcon4),'r.'); hold on;
plot(tsvector4(vpos4),(vsignalcon4(vpos4)),'ko');
xlabel('Time(s)');
ylabel('Voltage (V)');
title('Barker 4');


figure(2)
plot(tsvector7,(vsignalsin7),'-b'); hold on;
plot(tsvector7,(vsignalsin7),'b.'); hold on;
plot(tsvector7,(vsignalcon7),'r-'); hold on;
plot(tsvector7,(vsignalcon7),'r.'); hold on;
plot(tsvector7(vpos7),(vsignalcon7(vpos7)),'ko');
xlabel('Time(s)');
ylabel('Voltage (V)');
title('Barker 7');

figure(3)
plot(tsvector11,(vsignalsin11),'-b'); hold on;
plot(tsvector11,(vsignalsin11),'b.'); hold on;
plot(tsvector11,(vsignalcon11),'r-'); hold on;
plot(tsvector11,(vsignalcon11),'r.'); hold on;
plot(tsvector11(vpos11),(vsignalcon11(vpos11)),'ko');
xlabel('Time(s)');
ylabel('Voltage (V)');
title('Barker 11');

figure(4)
plot(tsvector13,(vsignalsin13),'-b'); hold on;
plot(tsvector13,(vsignalsin13),'b.'); hold on;
plot(tsvector13,(vsignalcon13),'r-'); hold on;
plot(tsvector13,(vsignalcon13),'r.'); hold on;
plot(tsvector13(vpos13),(vsignalcon13(vpos13)),'ko');
xlabel('Time(s)');
ylabel('Voltage (V)');
title('Barker 13');

%% 4.3
vout_signalcon4=conv(vsignalcon4,conj(fliplr(vsignalsin4))); %señal a la salida del filtro
vout_signalcon7=conv(vsignalcon7,conj(fliplr(vsignalsin7)));
vout_signalcon11=conv(vsignalcon11,conj(fliplr(vsignalsin11)));
vout_signalcon13=conv(vsignalcon13,conj(fliplr(vsignalsin13)));

time4conruido=(0:length(vout_signalcon4)-1)*ts4;
time7conruido=(0:length(vout_signalcon7)-1)*ts7;
time11conruido=(0:length(vout_signalcon11)-1)*ts11;
time13conruido=(0:length(vout_signalcon13)-1)*ts13;

%figuras a la salida del filtro en dB
figure(5)
plot(time4conruido,20*log10(abs((vout_signalcon4)/N)),'r-');hold on;
xlabel('Time(s)');
ylabel('Voltage filter output(dB)');
title('Output of MF Barker 4 in dB');

figure(6)
plot(time7conruido,20*log10(abs((vout_signalcon7)/N)),'r-');hold on;
xlabel('Time(s)');
ylabel('Voltage filter output(dB)');
title('Output of MF Barker 7 in dB');

figure(7)
plot(time11conruido,20*log10(abs((vout_signalcon11)/N)),'r-');hold on;

xlabel('Time(s)');
ylabel('Voltage filter output(dB)');
title('Output of MF Barker 11 in dB');

figure(8)
plot(time13conruido,20*log10(abs((vout_signalcon13)/N)),'r-');hold on;
xlabel('Time(s)');
ylabel('Voltage filter output(dB)');
title('Output of MF Barker 13 in dB');

%figura del output del filtro en lineal
figure(9)
plot(time4conruido,((vout_signalcon4)/N),'r-');hold on;
xlabel('Time(s)');
ylabel('Voltage filter output(V)');
title('Output of MF Barker 4 ');

figure(10)
plot(time7conruido,((vout_signalcon7)/N),'r-');hold on;
xlabel('Time(s)');
ylabel('Voltage filter output(V)');
title('Output of MF Barker 7 ');

figure(11)
plot(time11conruido,((vout_signalcon11)/N),'r-');hold on;
xlabel('Time(s)');
ylabel('Voltage filter output(V)');
title('Output of MF Barker 11 ');

figure(12)
plot(time13conruido,((vout_signalcon13)/N),'r-');hold on;
xlabel('Time(s)');
ylabel('Voltage filter output(V)');
title('Output of MF Barker 13 ');
  
%% 4.4 para k=13 laSNR cambia de 30dB a -10dB
SNR_30=30;
SNR_20=20;
SNR_10=0;
SNR_0=0;
SNR_10m=-10;


[vsignalsin13_30,vsignalcon13_30,vnoise13_30,ts13_30]=baseband_signal(pulseduration,N,phases13,amplis13,SNR_30);
[vsignalsin13_20,vsignalcon13_20,vnoise13_20,ts13_20]=baseband_signal(pulseduration,N,phases13,amplis13,SNR_20);
[vsignalsin13_10,vsignalcon13_10,vnoise13_10,ts13_10]=baseband_signal(pulseduration,N,phases13,amplis13,SNR_10);
[vsignalsin13_0,vsignalcon13_0,vnoise13_0,ts13_0]=baseband_signal(pulseduration,N,phases13,amplis13,SNR_0);
[vsignalsin13_10m,vsignalcon13_10m,vnoise13_10m,ts13_10m]=baseband_signal(pulseduration,N,phases13,amplis13,SNR_10m);

%hacemos las figuras sin pasar por el filtro para las dif SNR en B=13
figure(13)
%plot(tsvector13,(vsignalsin13_30));hold on;
plot(tsvector13,(vsignalcon13_30));hold on;
%plot(tsvector13,(vsignalsin13_20));hold on;
plot(tsvector13,(vsignalcon13_20));hold on;
%plot(tsvector13,(vsignalsin13_10));hold on;
plot(tsvector13,(vsignalcon13_10));hold on;
%plot(tsvector13,(vsignalsin13_0));hold on;
plot(tsvector13,(vsignalcon13_0));hold on;
%plot(tsvector13,(vsignalsin13_10m));hold on;
plot(tsvector13,(vsignalcon13_10m));hold on;
xlabel('Time(s)');
ylabel('Voltage(V)');
title('Barker 13 (No MF) with different SNR');
legend("30 dB","20 dB","10 dB","0 dB","-10 dB");

vout_conruido13_30=conv(vsignalcon13_30,conj(fliplr(vsignalsin13_30)));
vout_conruido13_20=conv(vsignalcon13_20,conj(fliplr(vsignalsin13_20)));
vout_conruido13_10=conv(vsignalcon13_10,conj(fliplr(vsignalsin13_10)));
vout_conruido13_0=conv(vsignalcon13_0,conj(fliplr(vsignalsin13_0)));
vout_conruido13_10m=conv(vsignalcon13_10m,conj(fliplr(vsignalsin13_10m)));

%hacemos las figuras con ruido a la salida del filtro
figure(14)
plot(time13conruido,(((vout_conruido13_30)/N)));hold on;
plot(time13conruido,(((vout_conruido13_20)/N)));hold on;
plot(time13conruido,(((vout_conruido13_10)/N)));hold on;
plot(time13conruido,(((vout_conruido13_0)/N)));hold on;
plot(time13conruido,(((vout_conruido13_10m)/N)));hold on;
xlabel('Time (s)');
ylabel('Voltage filter output (v)');
title('Output MF B=13 SNR=-10');
legend("30 dB","20 dB","10 dB","0 dB","-10 dB");

%% 4.5 con la funcion de la practica 2 q te da la SNR y la NF 
%lo que le da a el
PeakPower = 1.5e6; Ga = 45; fc = 1.1e9; BW = 50e6; NF=1.1089; L = 0; sigma = 1; targets = [30*1000];
SNR_new = getRadarEq(PeakPower,Ga,fc,BW,NF,L,sigma,targets); %dB
SNR_new = 9.5;
Pfa1=1e-3;
Pfa2=1e-5;
Pfa3=1e-7;

[vsignalsin4_new,vsignalcon4_new,vnoise4_new,ts4,Pn4]=baseband_signal_potruido(pulseduration,N,phases4,amplis4,SNR_new);
[vsignalsin7_new,vsignalcon7_new,vnoise7_new,ts7,Pn7]=baseband_signal_potruido(pulseduration,N,phases7,amplis7,SNR_new);
[vsignalsin13_new,vsignalcon13_new,vnoise13_new,ts13,Pn13]=baseband_signal_potruido(pulseduration,N,phases13,amplis13,SNR_new);

% Pn4=sum(0.5*abs(vnoise4_new).^2);
% Pn7=sum(0.5*abs(vnoise7_new).^2);
% Pn13=sum(0.5*abs(vnoise13_new).^2);

%Calculamos cada vthreshiold para cada pfa
vthres4_1=(-2*Pn4*log(Pfa1))^0.5;
vthres7_1=(-2*Pn7*log(Pfa1))^0.5;
vthres13_1=(-2*Pn13*log(Pfa1))^0.5;

vthres4_2=(-2*Pn4*log(Pfa2))^0.5;
vthres7_2=(-2*Pn7*log(Pfa2))^0.5;
vthres13_2=(-2*Pn13*log(Pfa2))^0.5;

vthres4_3=(-2*Pn4*log(Pfa3))^0.5;
vthres7_3=(-2*Pn7*log(Pfa3))^0.5;
vthres13_3=(-2*Pn13*log(Pfa3))^0.5;

vout_signalcon4_new=conv(vsignalcon4_new,conj(fliplr(vsignalsin4_new)));
vout_signalcon7_new=conv(vsignalcon7_new,conj(fliplr(vsignalsin7_new)));
vout_signalcon13_new=conv(vsignalcon13_new,conj(fliplr(vsignalsin13_new)));

figure(23)
plot(time4conruido,20*log10(abs((vout_signalcon4_new)/N))); hold on;
plot(time4conruido,20*log10(abs(vthres4_1))*ones(1,length(time4conruido)));hold on;
plot(time4conruido,20*log10(abs(vthres4_2))*ones(1,length(time4conruido)));hold on;
plot(time4conruido,20*log10(abs(vthres4_3))*ones(1,length(time4conruido)));hold on;
xlabel('Time (s)');
ylabel('Voltage filter output (v)');
title('Output MF K = 4');
legend("Pfa = 1e-3","Pfa2 = 1e-5","Pfa3 = 1e-7");


figure(24)
plot(time7conruido,20*log10(abs((vout_signalcon7_new)/N))); hold on;
plot(time7conruido,20*log10(abs(vthres7_1))*ones(1,length(time7conruido)));hold on;
plot(time7conruido,20*log10(abs(vthres7_2))*ones(1,length(time7conruido)));hold on;
plot(time7conruido,20*log10(abs(vthres7_3))*ones(1,length(time7conruido)));hold on;
xlabel('Time (s)');
ylabel('Voltage filter output (v)');
title('Output MF K = 7');
legend("Pfa = 1e-3","Pfa2 = 1e-5","Pfa3 = 1e-7");

figure(25)
plot(time13conruido,20*log10(abs((vout_signalcon13_new)/N))); hold on;
plot(time13conruido,20*log10(abs(vthres13_1))*ones(1,length(time13conruido)));hold on;
plot(time13conruido,20*log10(abs(vthres13_2))*ones(1,length(time13conruido)));hold on;
plot(time13conruido,20*log10(abs(vthres13_3))*ones(1,length(time13conruido)));hold on;
xlabel('Time (s)');
ylabel('Voltage filter output (v)');
title('Output MF K = 13');
legend("Pfa = 1e-3","Pfa2 = 1e-5","Pfa3 = 1e-7");

%% 4.7

SNR_new = SNR_new - 3;

[vsignalsin4_new,vsignalcon4_new,vnoise4_new,ts4,Pn4]=baseband_signal_potruido(pulseduration,N,phases4,amplis4,SNR_new);
[vsignalsin7_new,vsignalcon7_new,vnoise7_new,ts7,Pn7]=baseband_signal_potruido(pulseduration,N,phases7,amplis7,SNR_new);
[vsignalsin13_new,vsignalcon13_new,vnoise13_new,ts13,Pn13]=baseband_signal_potruido(pulseduration,N,phases13,amplis13,SNR_new);

vthres4_1=(-2*Pn4*log(Pfa1))^0.5;
vthres7_1=(-2*Pn7*log(Pfa1))^0.5;
vthres13_1=(-2*Pn13*log(Pfa1))^0.5;

vthres4_2=(-2*Pn4*log(Pfa2))^0.5;
vthres7_2=(-2*Pn7*log(Pfa2))^0.5;
vthres13_2=(-2*Pn13*log(Pfa2))^0.5;

vthres4_3=(-2*Pn4*log(Pfa3))^0.5;
vthres7_3=(-2*Pn7*log(Pfa3))^0.5;
vthres13_3=(-2*Pn13*log(Pfa3))^0.5;

vout_signalcon4_new=conv(vsignalcon4_new,conj(fliplr(vsignalsin4_new)));
vout_signalcon7_new=conv(vsignalcon7_new,conj(fliplr(vsignalsin7_new)));
vout_signalcon13_new=conv(vsignalcon13_new,conj(fliplr(vsignalsin13_new)));

figure(26)
plot(time4conruido,20*log10(abs((vout_signalcon4_new)/N))); hold on;
plot(time4conruido,20*log10(abs(vthres4_1))*ones(1,length(time4conruido)));hold on;
plot(time4conruido,20*log10(abs(vthres4_2))*ones(1,length(time4conruido)));hold on;
plot(time4conruido,20*log10(abs(vthres4_3))*ones(1,length(time4conruido)));hold on;
xlabel('Time (s)');
ylabel('Voltage filter output (v)');
title('Output MF K = 4 (SNR - 3)');
legend("Pfa = 1e-3","Pfa2 = 1e-5","Pfa3 = 1e-7");

figure(27)
plot(time7conruido,20*log10(abs((vout_signalcon7_new)/N))); hold on;
plot(time7conruido,20*log10(abs(vthres7_1))*ones(1,length(time7conruido)));hold on;
plot(time7conruido,20*log10(abs(vthres7_2))*ones(1,length(time7conruido)));hold on;
plot(time7conruido,20*log10(abs(vthres7_3))*ones(1,length(time7conruido)));hold on;
xlabel('Time (s)');
ylabel('Voltage filter output (v)');
title('Output MF K = 7 (SNR - 3)');
legend("Pfa = 1e-3","Pfa2 = 1e-5","Pfa3 = 1e-7");

figure(28)
plot(time13conruido,20*log10(abs((vout_signalcon13_new)/N))); hold on;
plot(time13conruido,20*log10(abs(vthres13_1))*ones(1,length(time13conruido)));hold on;
plot(time13conruido,20*log10(abs(vthres13_2))*ones(1,length(time13conruido)));hold on;
plot(time13conruido,20*log10(abs(vthres13_3))*ones(1,length(time13conruido)));hold on;
xlabel('Time (s)');
ylabel('Voltage filter output (v)');
title('Output MF K = 13 (SNR - 3)');
legend("Pfa = 1e-3","Pfa2 = 1e-5","Pfa3 = 1e-7");