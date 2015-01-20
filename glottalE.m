function [gE,GE,w_E] = glottalE(a,Npts,Nfreq)
% gE is the exponential glottal waveform vector of length Npts 
% GE is the frequency response at Nfreq frequencies between 0  and pi
% radians
gE=[];
GE=[];

x=1:Npts;
gE=[gE x.*a.^x];

% G(z) = az^-1 /(1-2az^-1+a^2z^-2) => b=a, a=[1 -2a a^2]

b = [0 a];
a0 = [1 -2*a a^2];
[GE,w_E]=freqz(b,a0,Nfreq);
end