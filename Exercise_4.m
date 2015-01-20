%% Part 4.1 
% Frequency response plots 
Nfreq = 6; 
A1=[1.6,2.6,0.65,1.6,2.6,4.0,6.5,8.0,7.0,5.0];
A2=[2.6,8.0,10.5,10.5,8.0,4.0,0.65,0.65,1.3,3.2];

rN1=0.71;
rN2=1.0;

[r1,D1,G1]=atov(A1,rN1);
[h1,w1]=freqz(G1,D1,Nfreq);
figure,plot(w1/pi,20*log10(abs(h1)));
hold on;

[r2,D2,G2]=atov(A1,rN2);
[h2,w2]=freqz(G2,D2,Nfreq);
plot(w2/pi,20*log10(abs(h2)),'g');


[r3,D3,G3]=atov(A2,rN1);
[h3,w3]=freqz(G3,D3,Nfreq);
plot(w3/pi,20*log10(abs(h3)),'r');

[r4,D4,G4]=atov(A2,rN2);
[h4,w4]=freqz(G4,D4,Nfreq);
plot(w4/pi,20*log10(abs(h4)),'m');

legend('"AA": A1,rN1','"AA":A1,rN1','"IY":A2,rN1','"IY":A2,rN2');
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Magnitude (dB)');
title('Frequency Response for AA and IY using different reflection coefficients');
%% Part 4.1b
% Pole plot
figure;
roo1 = roots(D1);
subplot(2,2,1), zpl([],roo1), title('AA,rN:0.71');

roo2 = roots(D2);
subplot(2,2,2), zpl([],roo2), title('AA,rN:1.0');


roo3 = roots(D3);
subplot(2,2,3), zpl([],roo3), title('IY,rN:0.71');

roo4 = roots(D4);
subplot(2,2,4), zpl([],roo4), title('IY,rN:1.0');

% FORMAT Frequencies 
%Given T=1/1000;
Ts=1/1000;
ang1 = angle(roo1);
ang2 = angle(roo2);
ang3 = angle(roo3);
ang4 = angle(roo4);

fre1 = ang1/(2*pi*Ts);
fre2 = ang2/(2*pi*Ts);
fre3 = ang3/(2*pi*Ts);
fre4 = ang4/(2*pi*Ts);
