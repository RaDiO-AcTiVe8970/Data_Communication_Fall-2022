clc
close all
clear all
a=2;
b=0;
c=4;
d=2;
e=5;
f=4;
g=6;
h=1;
k1=a+b;
k2=g+h+2;
j1=d+g+20;
j2=deg2rad(30);
t=0:1/500:0.3;
x1=k1*cos(2*pi*(e+f+5)*t+j1);
x2=k2*cos(2*pi*(c+d+5)*t+j2);
x3=x1+x2;
plot(t,x1)
xlabel('time')
ylabel('amplitude')
title('Simple Signal(x1)')
figure
plot(t,x2)
xlabel('time')
ylabel('amplitude')
title('Simple Signal(x2)')
figure
plot(t,x3)
xlabel('time')
ylabel('amplitude')
title('Composite Signal(x3)')
figure
subplot(3,1,1)
plot(t,x1)
xlabel('time')
ylabel('amplitude')
title('Simple Signal(x1)')
subplot(3,1,2)
plot(t,x2)
xlabel('time')
ylabel('amplitude')
title('Simple Signal(x2)')
subplot(3,1,3)
plot(t,x3)
xlabel('time')
ylabel('amplitude')
title('Composite Signal(x3)')