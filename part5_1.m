%% System Models 
%Exponential glottal pulse
fs=10000;
b = [0 a];
a0 = [1 -2*a a^2];
sys_G_z = tf(b,a0,1/fs,'variable','z^-1');

% Vocal tract V(z)
sys_V_z1 = tf(G1,D1,1/fs,'variable','z^-1');
sys_V_z2 = tf(G2,D2,1/fs,'variable','z^-1');
sys_V_z3 = tf(G3,D3,1/fs,'variable','z^-1');
sys_V_z4 = tf(G4,D4,1/fs,'variable','z^-1');

%%Raditaion R(z) = (1-z^-1)
a=1;
b=[1 -1];
sys_R_z = tf(b,a,1/fs,'variable','z^-1');

% H(z)= G(z)*V(z)*R(z) for Exponential glottal model 
H_z1 = sys_G_z*sys_V_z1*sys_R_z;
H_z2 = sys_G_z*sys_V_z2*sys_R_z;
H_z3 = sys_G_z*sys_V_z3*sys_R_z;
H_z4 = sys_G_z*sys_V_z4*sys_R_z;

%%Excitation signal e[n] = y1 
f=100;
fs=10000;
y1=zeros(10000,1);
y1(1:fs/f:end)=1;
% stem(y1);

%Inverse Z-transform
imp1 = impz(H_z1.num{1},H_z1.den{1},10);
imp2 = impz(H_z2.num{1},H_z2.den{1},10);
imp3 = impz(H_z3.num{1},H_z3.den{1},10);
imp4 = impz(H_z4.num{1},H_z4.den{1},10);
%Convolution of input excitation signal with H(z)
soun_exp1=conv(y1,imp1);
soun_exp2=conv(y1,imp2);
soun_exp3=conv(y1,imp3);
soun_exp4=conv(y1,imp4);

% figure, subplot(2,2,1), plot(soun_exp1),title('AA,rN:0.71');
%Concatenate sounds into a single pulse. 
song = cat(1,soun_exp1,zeros(1000,1),soun_exp2,zeros(1000,1),soun_exp3,zeros(1000,1),soun_exp4);
%Listen to the sounds
% soundsc(song,fs);

% Rosenberg  Glottal Pulse
%FOR "AA" sound
convolVR=sys_R_z*sys_V_z1;
%Inverse of convolVR_z
himp = impz(convolVR.num{1},convolVR.den{1},10);
ans_w=conv(himp,gR);
sou_n=conv(y1,ans_w);
% soundsc(sou_n,fs);


%FOR 'IY' sound
convolVR3=sys_R_z*sys_V_z3;
%Inverse of convolVR_z
himp3 = impz(convolVR3.num{1},convolVR3.den{1},10);
ans_w3=conv(himp3,gR);
sou_n3=conv(y1,ans_w3);
% soundsc(sou_n3,fs);
r_song = cat(1,sou_n,zeros(1000,1),sou_n3);
% soundsc(r_song);

%% Rosenberg Flipped 
%FOR "AA" sound
ans_w_f=conv(himp,gRflip);
sou_nf=conv(y1,ans_w_f);
% soundsc(sou_nf,fs);


%FOR 'IY' sound
ans_w3f=conv(himp3,gRflip);
sou_n3f=conv(y1,ans_w3f);
% soundsc(sou_n3f,fs);
flr_song = cat(1,sou_n3,zeros(1000,1),sou_n3f);
% soundsc(flr_song);

 
%% Part 5.1
figure, subplot(2,2,1), plot(soun_exp1(1:1000)), title('AA in Exponential');
subplot(2,2,2), plot(soun_exp3(1:1000)), title('IY in Exponential');
subplot(2,2,3), plot(sou_nf(1:1000)), title('AA in Rosenberg flipped');
subplot(2,2,4), plot(sou_n3f(1:1000)), title('IY in Rosenberg flipped');

figure, subplot(2,2,1), plot(sou_n(1:1000)), title('AA in Rosenberg');
subplot(2,2,2), plot(sou_n3(1:1000)), title('IY in Rosenberg');
subplot(2,2,3), plot(sou_nf(1:1000)), title('AA in flipped Rosenberg');
subplot(2,2,4), plot(sou_n3f(1:1000)), title('IY in flipped Rosenberg');

%% Part 5.2 
% TO find H(z) , first convert all the sytems into Z domain. Multiply V(z)
% , R(z) and G(z) to get H(z). After that plt the frequency response of
% H(z)
syms z n
G_z = symsum((0.5*(1-cos((pi*n)/40))*z^(-n)), n, 0, 40) + symsum(cos((pi*(n-40)/(2*10)))*z^(-n), n, 40, 50);
R_z = 1-(1/z);
[r4, D4, G4]=atov(IY,rN2);
V_z = G4/ (D4(1)+D4(2)*(1/z) + D4(3)*(1/z^2)+ D4(4)*(1/z^3)+ D4(5)*(1/z^4)+ D4(6)*(1/z^5)+ D4(7)*(1/z^6)+ D4(8)*(1/z^7)+ D4(9)*(1/z^8)+ D4(10)*(1/z^9)+ D4(11)*(1/z^10));
Hz = G_z*V_z*R_z;
[NUME,DENO] = numden(Hz);
 
num_c = double(coeffs(NUME));
den_c = double(coeffs(DENO));
 
[mag, freq] = freqz(num_c, den_c, 100);
figure,plot(freq/pi,20*log10(abs(mag)))
xlabel('Normalized Frequency (x \pi rad/sample)');
ylabel('Magnitude (dB)');
title('Frequency Response of H(z) using Rosenberg Model');
%% Part 5.3 
% Listening to the output 
soundsc(song,fs);
%Rosenberg model
r_song = cat(1,sou_n,zeros(1000,1),sou_n3,zeros(1000,1));
% soundsc(r_song);
%Flipped rosenberg model
flr_song = cat(1,sou_n3,zeros(1000,1),sou_n3f);
% soundsc(flr_song);
% The sounds can be distinctly differentiated into "AA" and "IY" vowels.
