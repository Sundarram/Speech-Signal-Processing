%% FINAL PROJECT - ECES 631
%% DISCRETE TIME MODELS FOR THE SPEECH SIGNAL
%  AUTHOR: SUNDAR RAM 
%  

%% Part 3.3 a 
% Exponential model
a=0.91;
Npts=51;
Nfreq=6;
[gE,GE,w_E] = glottalE(a,Npts,Nfreq);
% figure,plot(gE), title('Exponential Model');

% Rosenberg Model 
N1=40;
N2=10;
[gR,GR,w_R] = glottalR(N1,N2,Nfreq);
%% Part 3.3 b
% FLIPPED ROSENBERG
gRflip = fliplr(gR);
GR_flip=zeros(1,length(w_R));

for p=1:length(w_R)
    win=w_R(p);
    for l=1:N1+N2
        cmn=0;
%         cmn=gRflip(l)*exp((1i)*p*2*pi/Nfreq)*l;
        cmn=gR(l)*exp(-(1i)*win*l);
        GR_flip(p)=GR_flip(p) + cmn;
    end
end

%% Part 3.3c
gE=gE/max(gE);
figure, plot(gE,'r');
hold on, plot(gR,'b');
hold on, plot(gRflip,'g');
title('Plot of 51 point vectors')
legend('Exponential','Rosenberg','Flipped Rosenberg');
xlabel('Time'), ylabel('Amplitude');
%Frequency plots 
figure,plot(20*log10(abs(GR_flip)),'g','linewidth',6);
hold on, plot(20*log10(abs(GR)),'k.'), title('Comparison of Frequency Responses'); 
plot(20*log10(abs(GE)),'r');   
legend('Flipped Rosenberg','Rosenberg','Exponential');
xlabel('Nfreq'), ylabel('Magnitude (in dB)');


%%Part 3.3d

% For the rosenberg model, since there is a zero at z = 0, when we flip it,
% then the zero goes to infinity. So skipping the first zero and plotting
% the rest of the zeros for the flipped rosenberg model 
roo1=roots(gR);
figure,zpl(roo1,[]),title('Maximum Phase system - Zeros of Rosenberg model');


roo2=roots(gRflip);
figure,zpl(roo2(2:end),[]),title('Minimum Phase system - Zeros of flipped Rosenberg model');







