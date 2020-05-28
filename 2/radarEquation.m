function SNR=radarEquation(Pt,G,fc,BW,NF,Lextra,sigma,range)  
    SNR=[];
    c = 3e+8;
    k = 1.38e-23;
    To = 290;
    G = 10^(G/10);
    F = 10^(NF/10);
    Lextra = 10^(Lextra/10);
    lambda = c/fc;
    Aef = lambda^2*G/(4*pi);
    
    i = 1;
    while i <= length(range)
        Pr_out = Pt*G*sigma*Aef/((4*pi*range(i)^2)^2);
        Pr = Pr_out/Lextra;
        SNR(i) = Pr/(k*To*BW*F);
        SNR(i)=10*log10(SNR(i));
        i = i+1;
    end
end
