clc
clear all
close all
A=2;
B=0;
C=4;
D=2;
E=5;
F=5;
G=6;
H=1;
a1=G+1;
a2=F+2;
a3=E+3;
f1=E+1;
f2=F+2;
f3=G+3;
fre = 5000 ;
ti = 0:1/fre:5;
x1= a1*cos(2*pi*f1*ti);
x2= a2*sin(2*pi*f2*ti);
x3= a3*cos(2*pi*f3*ti); 
signal= x1+x2+x3;
figure;
subplot(2,1,1)
plot(ti,signal);
xlabel('Time(S)');
ylabel('Amplitude');
title('Time-Domain Graph');

nx=length(signal);
fsignal=abs(fftshift(fft(signal))/(nx/2));
f= linspace(-fre/2,fre/2,nx);
subplot(2,1,2)
bar(f,fsignal,'linewidth',1.5);
xlabel('Frequency(Hz)');
ylabel('Amplitude');
title('Frequency-Domain Graph');
xlim([-15 15])

sd=10;
noise=sd*randn(1,nx);
figure;
subplot(2,1,1)
plot(ti,noise);
xlabel('Time(S)');
ylabel('Amplitude');
title('Time-Domain Graph');

fnoise=abs(fftshift(fft(noise))/(nx/2));
subplot(2,1,2)
bar(f,fnoise,'linewidth',1.5);
xlabel('Frequency(Hz)');
ylabel('Amplitude');
title('Frequency-Domain Graph');
xlim([-15 15])


noisy_sig=signal+noise;
figure;
subplot(2,1,1)
plot(ti,noisy_sig);
xlabel('Time(S)');
ylabel('Amplitude');
title('Time-Domain Graph');

fnoisy_sig=abs(fftshift(fft(noisy_sig))/(nx/2));
subplot(2,1,2)
bar(f,fnoisy_sig,'linewidth',1.5);
xlabel('Frequency(Hz)');
ylabel('Amplitude');
title('Frequency-Domain Graph');
xlim([-15 15])


