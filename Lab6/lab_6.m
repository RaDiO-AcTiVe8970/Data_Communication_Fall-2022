clc
close all
clear all
f=1;
f2=10;
x=[0 0 1 1 0 1 0 1 0 0 1 1 0 1 0 1 0 0 1 1 0 1 1 0] % input signal ;
nx=length(x);
p=0;
fs=5000;
fc=2;
for i=1:3:nx
 t=p*1:1/fs:(p+1)*1;
 if x(i)==0 && x(i+1)==0 && x(i+2)==0
 ask=0;
 fsk=sin(2*pi*fc*t);
 psk=sin(2*pi*f*t);
 elseif x(i)==0 && x(i+1)==0 && x(i+2)==1
 ask=1*sin(2*pi*fc*t);
 fsk=sin(2*pi*2*fc*t);
 psk=sin(2*pi*f*t+pi/4);
 elseif x(i)==0 && x(i+1)==1 && x(i+2)==0
 ask=2*sin(2*pi*fc*t);
 fsk=sin(2*pi*3*fc*t);
 psk=sin(2*pi*f*t+3*pi/4);
 elseif x(i)==0 && x(i+1)==1 && x(i+2)==1
 ask=3*sin(2*pi*fc*t);
 fsk=sin(2*pi*4*fc*t);
 psk=sin(2*pi*f*t+pi/2);
 elseif x(i)==1 && x(i+1)==0 && x(i+2)==0
 ask=4*sin(2*pi*fc*t);
 fsk=sin(2*pi*5*fc*t);
 psk=sin(2*pi*f*t-pi/4);
 elseif x(i)==1 && x(i+1)==0 && x(i+2)==1
 ask=5*sin(2*pi*fc*t);
 fsk=sin(2*pi*6*fc*t);
 psk=sin(2*pi*f*t-pi/2);
 elseif x(i)==1 && x(i+1)==1 && x(i+2)==0
 ask=6*sin(2*pi*fc*t);
 fsk=sin(2*pi*7*fc*t);
 psk=sin(2*pi*f*t+pi);
 else
 ask=7*sin(2*pi*fc*t);
 fsk=sin(2*pi*8*fc*t);
 psk=sin(2*pi*f*t-3*pi/4);
 end
subplot(3,1,1);
plot(t,ask);
hold on;
grid on;
title('Amplitude Shift Key')
subplot(3,1,2);
plot(t,fsk);
hold on;
grid on;
title('Frequency Shift Key')
subplot(3,1,3);
plot(t,psk);
hold on;
grid on;
title('Phase Shift Key')
p=p+1;
end
hold off;