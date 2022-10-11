clc
clear all
close all
A=2;
B=0;
C=4;
D=2;
E=5;
F=4;
G=6;
H=1;
A1 = A+B+H ;
A2 = B+C+H ;
s= (C+D+H)/30;
fs = 12000 ;
t = 0:1/fs:5;
x1= A1*sin(2*pi*((C+D+H)*100)*t)+ A2*cos(2*pi*((D+E+H)*100)*t);
f1=((C+D+H)*100);
f2=((D+E+H)*100);

noise= s*randn(size(t));
signal = x1 + noise;
figure;
plot(t,signal);
xlabel('Time(S)');
ylabel('Amplitude');
title('Time-Domain Graph');

PS=((A1^2)/2)+((A2^2)/2);
PN=s^2;
SNR_theo=PS/PN
SNR_theo_DB=10*log10(SNR_theo)
SNR_mat_DB=snr(x1,noise)
SNR_mat=10^(SNR_mat_DB/10)

bw=abs(f1-f2)
bandwidth=obw(signal,fs)
max_cap=bandwidth*log2(1+SNR_theo)
Levels = floor(2^(1/2*log2( 1 + SNR_mat)))


