function [gR,GR,w_R] = glottalR(N1,N2,Nfreq)
% gR is the Rosenberg Glottal waveform vector of length N1+N2+1
% GR is the frequency response at Nfreq frequencies w_R between 0 and pi
% radians

gR=[];
%Generation of glottal waveform
for n=1:N1+N2+1
    if(n<=N1)
    gR(n)=0.5*(1-cos(pi*(n)/N1));
    elseif(n<=N1+N2)
    gR(n)=cos(pi*(n-N1)/(2*N2));
    else
    gR(n) = 0;
    end
end
%Frequency response of the glottal waveform using Fourier transform formula
w_R = 0:pi/Nfreq:pi;
GR=zeros(1,length(w_R));

for p=1:length(w_R)
    win=w_R(p);
    for l=1:N1+N2
        cmn=0;
%         cmn=gR(l)*exp(-(1i)*p*2*pi/Nfreq)*l;
         cmn=gR(l)*exp(-(1i)*win*l);
        GR(p)=GR(p) + cmn;
    end
end

end
