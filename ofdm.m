%% OFDM
clc
clear all
close all

Fe = 15.36;
mfft = 1024;
deltaF = Fe/mfft;

%% Emmetteur
M = 4;
No = 601;
IMIN = 0;
IMAX = 3;
NBlocs = 40;
for i=1:NBlocs
    bloc(i,:) = qammod(randi([IMIN,IMAX],1,No-1),M);
end

CPlong = 80;
CPcourt = 72;
f = 0:deltaF:(mfft-1)*deltaF;
sousport = zeros(NBlocs,mfft);
sigout=zeros(1,Nblocs*(mfft+CPlong));
indiceDebutTrame=1;

for i=1:NBlocs
    sousport(i,1:300) = bloc(i,1:300);
    sousport(i,mfft-300:mfft-1) = bloc(i,1:300);
    signalfreq(i,:) = sousport(i,:); 
    
    temp=ifft(signalfreq(i,:),mfft)
    if(mod(i-1,7) == 0)
        L = CPlong + mfft;
        signal = [temp(end-(CPlong-1):end) temp];     
    else
        L = CPcourt + mfft;
        signal = [temp(end-(CPcourt-1):end) temp];
    end
    sigout(indiceDebutTrame:indiceDebutTrame+L-1)= signal;
    indiceDebutTrame = indiceDebutTrame + L;
end


slot = zeros(1,7680);
trame = [slot slot];
nCP = 80;
n = 12;
Nbresblock = 50;





%%