%% Computes the signal-to-noise ratio

% INPUTS:
    % Vector of detection probabilities (Pd) 
    % Vector of false alarm probabilities (Pfa) 
% OUTPUTS:
    % Vector of signal-to-noise ratio (SNR) [dB]

function SNR = LAB3_function2_SNR(Pd,Pfa)
    
    % Albersheim equation
    c=1;
    while(c<=length(Pfa))
        f=1;
        while(f<=length(Pd))
            A=log(0.62/Pfa(c));
            B=log(Pd(f)/(1-Pd(f)));
            SNR(f,c)=A+(0.12*A*B)+(1.7*B);
            f=f+1;
        end
        c=c+1;
    end
    
end