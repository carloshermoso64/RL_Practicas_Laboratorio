 
function [R_blind,Rmax_un,PRF,R_resolution,duty_cycle,Pr_mean,Er,V_pulse,t_pulse]=pulsedRadar(pulsewidth,PRI,fc,Pt,L,num_pulses,fs,distance)

    c = 3*10^8; %m/s
    R = 50; %ohms
    PRF = 1/PRI; %Hz
    R_blind = (pulsewidth*c)/2; %m
    R_resolution = R_blind; %m
    Rmax_un = c/(2*PRF); %m
    duty_cycle = pulsewidth*100/PRI; 
    Pr_mean = 10*log10((10^((Pt-L)/10)*(duty_cycle/100))*1000);
    Er = 10^(Pt/10)*10^((-L)/10)*pulsewidth;
    delay = 2*distance/c;

    i=0;

    Ts=1/fs;
    V=sqrt(2*R*10^(Pr_mean/10)/1000);
    V_pulse=[];
    t_pulse = delay:Ts:(num_pulses*PRI-Ts+delay);
    while i <= (PRI-Ts)
        if i <=pulsewidth
            V_pulse(end+1)=V;
        else
            V_pulse(end+1)=0;
        end
        i = i+Ts;
    end
      

end