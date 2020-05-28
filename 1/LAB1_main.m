%% Exercici 1-2
pulsewidth = 10^-6; %s
PRI = 5*10^-6; %s
fc = 5*10^6; %Hz
Pt = 10*log10(10^6); %transmitted power dBW
L = 70; %dB
num_pulses = 5;
fs = 100*10^6; %Hz
distance = 0; %m

[R_blind,Rmax_un,PRF,R_resolution,duty_cycle,Pr_mean,E_pulse,V_pulse,t_pulse]=pulsedRadar(pulsewidth,PRI,fc,Pt,L,num_pulses,fs,distance);
V_pulse_total = repmat(V_pulse,1,num_pulses); %senyal banda base
V_pulse_modulated = V_pulse_total.*sin(2*pi*fc*t_pulse);
figure();
plot(t_pulse,V_pulse_modulated);
title('Pulse burst modulated (Range=0)');
xlabel('Time [s]');
ylabel('Voltage [V]');

%% Exercici 4: frequency spectrum of exercice 2

%Unmodulated single pulse:
figure();
t_pulse=0:(1/fs):PRI-(1/fs);
n_single=length(t_pulse);
fshift_single=(-n_single/2:n_single/2-1)*(fs/n_single);
F_Single_pulse=fft(V_pulse);
plot(fshift_single,abs(fftshift(F_Single_pulse)))
title('FFT unmodulated single pulse');

%Unmodulated and modulated burst:
figure();
t_pulse=0:(1/fs):(num_pulses*PRI-(1/fs));
V_burst=V_pulse_total;
n_burst=length(t_pulse);
fshift_burst=(-n_burst/2:n_burst/2-1)*(fs/n_burst);
F_burst=fft(V_burst);  
plot(fshift_burst,abs(fftshift(F_burst)))
title('FFT unmodulated pulse burst');

figure();
F_burst_modulated=fft(V_pulse_modulated);
plot(fshift_burst,abs(fftshift(F_burst_modulated)))
title('FFT modulated pulse burst');


%% Exercici 3
distance = [0 450 1852]; %m
figure();
i = 1;
while i<=3
    [R_blind,Rmax_un,PRF,R_resolution,duty_cycle,Pr_mean,E_pulse,V_pulse,t_pulse]=pulsedRadar(pulsewidth,PRI,fc,Pt,L,num_pulses,fs,distance(i));
    V_pulse_total = repmat(V_pulse,1,num_pulses); %senyal banda base
    V_pulse_modulated = V_pulse_total.*sin(2*pi*fc*t_pulse);
    plot(t_pulse,V_pulse_modulated);
    hold on
    L = L+3;
    i = i+1;
end
title('Signals reflected by 2 targets');
xlabel('Time [s]');
ylabel('Voltage [V]');
legend('Range=0m','Range=450m','Range=1NM');

% No és possible saber el rang dels 2 targets pq se sobreposen els pulsos
% SOLUCIÓ: augmentar PRI (cada quants s s'envia un pols)