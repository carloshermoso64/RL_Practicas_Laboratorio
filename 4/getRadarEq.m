function [SNR] = getRadarEq(PeakPower,Ga,fc,BW,NF,L,sigma,targets)
    c= 30000000; % m/s
    lamda = c/fc;
    Ga = 10^(Ga/10);
    Aeff = ((lamda^2)*Ga)/(4*pi);
    k = 1.38e-23;
    To = 290; %K
    NF = 10^(NF/10);
    Te = To*(NF - 1);
    N = k*Te*BW;
    Rmax4 = targets.^4;
    Pr = (PeakPower*Ga*sigma*Aeff)/((4*pi)^2);
    i = 1;
    Prs = zeros(1,length(Rmax4));
    h = length(Rmax4);
    while i <= h
        Prs(i) = Pr/Rmax4(i);
        i = i + 1;
    end
    SNR = 10*log10(Prs/N) - L;

