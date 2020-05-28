%% Computes the time between false alarms

% INPUTS:
    % Vector of threshold-to-noise ratios (threshold2noise) [dB]
    % Vector of bandwidth (BW) [Hz]
% OUTPUTS:
    % Vector of times between false alarms (Tfa) [s]

function Tfa = LAB3_function1_Tfa(threshold2noise,BW)

    % threshold-to-noise ratios --> dB to lineal 
    threshold2noise_lineal=10.^(threshold2noise./10);
    
    % Compute time between false alarms
    Tfa=zeros(length(BW),length(threshold2noise_lineal));
    f=1;
    while(f<=length(BW))
        c=1;
        while(c<=length(threshold2noise_lineal))
            Tfa(f,c)=(1/BW(f))*exp(threshold2noise_lineal(c));
            c=c+1;
        end
        f=f+1;
    end
    
end