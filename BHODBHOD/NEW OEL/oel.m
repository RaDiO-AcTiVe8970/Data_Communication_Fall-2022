clc
clear all
close all

f=5;
f2=10;
x=[1 1 1 1] % input signal ;
nx=size(x,2);
i=1;
while i<nx+1
 t = i:0.001:i+1;
 if x(i)==1 
 ask1=sin(2*pi*f*t);
 else
 ask1=0;
 end
 subplot(3,1,1);
 plot(t,ask1);
 hold on;
 grid on;
 axis([1 10 -1 1]);
title('Amplitude Shift Key')
 i=i+1;
end

x=[1 0 0 1] % input signal ;
nx=size(x,2);
i=1;
while i<nx+1
 t = i:0.001:i+1;
 if x(i)==1
 ask2=sin(2*pi*f*t);
 else
 ask2=0;
 end
 subplot(3,1,2);
 plot(t,ask2);
 hold on;
 grid on;
 axis([1 10 -1 1]);
title('Amplitude Shift Key')
 i=i+1;
end

x=[0 1 1 0] % input signal ;
nx=size(x,2);
i=1;
while i<nx+1
 t = i:0.001:i+1;
 if x(i)==1
 ask3=sin(2*pi*f*t);
 else
 ask3=0;
 end
 subplot(3,1,3);
 plot(t,ask3);
 hold on;
 grid on;
 axis([1 10 -1 1]);
title('Amplitude Shift Key')
 i=i+1;
end


fs = 4001; %Sampling Frequency
t = 0:1/fs:1-1/fs; %Generating Time axis
Am1 = 2; %Amplitude of First Message Signal
fm1 = 4; %Frequency of First Message Signal
m1 = Am1*cos(2*pi*fm1*t); % First Message Signal
Am2 = 3; %Amplitude of Second Message Signal
fm2 = 5; %Frequency of Second Message Signal
m2 = Am2*cos(2*pi*fm2*t); % Second Message Signal
Am3 = 5; %Amplitude of Third Message Signal
fm3 = 6; %Frequency of Third Message Signal
m3 = Am3*cos(2*pi*fm3*t); % Third Message Signal
%%
%% Carrier Signal Generation
Cm1 = 1; %Amplitude of First Carrier Signal
fc1 = 100; %Frequency of First Carrier Signal
c1 = Cm1*sin(2*pi*fc1*t); % First Carrier Signal
Cm2 = 1; %Amplitude of Second Carrier Signal
fc2 = 170; %Frequency of Second Carrier Signal
c2 = Cm2*sin(2*pi*fc2*t); % Second Carrier Signal
Cm3 = 1; %Amplitude of Third Carrier Signal
fc3 = 250; %Frequency of Third Carrier Signal
c3 = Cm3*sin(2*pi*fc3*t); % Third Carrier Signal
%%
%% Composite Signal Generation
x = (ask1)+(ask2)+(ask3);
%%%% Plotting the Signals in Time-Domain and Frequency-Domain
figure
subplot(3,1,1)
plot(t,ask1)
xlabel('time')
ylabel('amplitude')
title('Message Signal 1 in Time Domain')
subplot(3,1,2)
plot(t,m2)
xlabel('time')
ylabel('amplitude')
title('Message Signal 2 in Time Domain')
subplot(3,1,3)
plot(t,m3)
xlabel('time')
ylabel('amplitude')
title('Message Signal 3 in Time Domain')
ylim([-Am3 Am3])
M1 = abs(fftshift(fft(m1)))/(fs/2); %Fourier Transformation of m1
M2 = abs(fftshift(fft(m2)))/(fs/2); %Fourier Transformation of m2
M3 = abs(fftshift(fft(m3)))/(fs/2); %Fourier Transformation of m3
X = abs(fftshift(fft(x)))/(fs/2); %Fourier Transformation of x
f = fs/2*linspace(-1,1,fs);
figure
subplot(3,1,1)
stem(f,M1)
xlabel('frequency')
ylabel('amplitude')
title('Message Signal 1 in Frequency Domain')
axis([-10 10 0 2.5])
subplot(3,1,2)
stem(f,M2)
xlabel('frequency')
ylabel('amplitude')
title('Message Signal 2 in Frequency Domain')
axis([-10 10 0 3.5])
subplot(3,1,3)
stem(f,M3)
xlabel('frequency')
ylabel('amplitude')
title('Message Signal 3 in Frequency Domain')
axis([-10 10 0 4.5])
figure
subplot(2,1,1)
plot(t,x)
xlabel('time')
ylabel('amplitude')
title('Composite Signal in Time Domain')
subplot(2,1,2)
stem(f,X)
xlabel('frequency')
ylabel('amplitude')
title('Composite Signal in Frequency Domain')
axis([-270 270 0 2.5])
%%
%% Passing the Composite Signal Through Bandpass Filter
[num1, den1] = butter(5, [(fc1-fm1-6)/(fs/2),(fc1+fm1+6)/(fs/2)]);
%Butterworth Filter Window Determining for Bandpass Filter
bpf1 = filter(num1,den1,x); %Filtering is done here
[num2, den2] = butter(5, [(fc2-fm2-6)/(fs/2),(fc2+fm2+6)/(fs/2)]);
%Butterworth Filter Window Determining for Bandpass Filter
bpf2 = filter(num2,den2,x); %Filtering is done here
[num3, den3] = butter(5, [(fc3-fm3-6)/(fs/2),(fc3+fm3+6)/(fs/2)]);
%Butterworth Filter Window Determining for Bandpass Filter
bpf3 = filter(num3,den3,x); %Filtering is done here
%%
%% Mixing
z1 = 2*bpf1.*c1;
z2 = 2*bpf2.*c2;
z3 = 2*bpf3.*c3;
%%
%% Passing the Mixed Signals Through Lowpass Filter
[num4, den4] = butter(5, (fm1+3)/(fs/2)); %Low pass filter is made here
rec1 = filter(num4,den4,z1); %Filtering is done here
[num5, den5] = butter(5, (fm2+3)/(fs/2)); %Low pass filter is made here
rec2 = filter(num5,den5,z2); %Filtering is done here
[num6, den6] = butter(5, (fm3+3)/(fs/2)); %Low pass filter is made here
rec3 = filter(num6,den6,z3); %Filtering is done here
%%
%% Plotting the Received Signals in Time-Domain and Frequency Domain
figure
subplot(3,1,1)
plot(t,rec1)
xlabel('time')
ylabel('amplitude')
title('received signal 1 in time domain')
ylim([-Am1 Am1])
subplot(3,1,2)
plot(t,rec2)
xlabel('time')
ylabel('amplitude')
title('received signal 2 in time domain')
ylim([-Am2 Am2])
subplot(3,1,3)
plot(t,rec3)
xlabel('time')
ylabel('amplitude')
title('received signal 3 in time domain')
ylim([-Am3 Am3])
R1 = abs(fftshift(fft(rec1)))/(fs/2); %Fourier Transformation is done here
R2 = abs(fftshift(fft(rec2)))/(fs/2); %Fourier Transformation is done here
R3 = abs(fftshift(fft(rec3)))/(fs/2); %Fourier Transformation is done here
figure
subplot(3,1,1)
stem(f,R1)
xlabel('frequency')
ylabel('amplitude')
title('received signal 1 in frequency domain')
xlim([-10 10])
subplot(3,1,2)
stem(f,R2)
xlabel('frequency')
ylabel('amplitude')
title('received signal 2 in frequency domain')
xlim([-10 10])
subplot(3,1,3)
stem(f,R3)
xlabel('frequency')
ylabel('amplitude')
title('received signal 3 in frequency domain')
xlim([-10 10])
%% End

%% Levels for Quantization
L = 8;

%% Quantizing
delta = (max(rec1) - min(rec1))/(L-1); % step size

%% Number of Bits/Sample
nb = log2(L);

%% Encoding
i = round((rec1-min(rec1))/delta); % index for encoding
dig_data_matrix = de2bi(i,nb); % encoded binary bits are as a matrix here
dig_data = reshape(dig_data_matrix',1,[]); % encoded binary bits are as an array here
disp(['The index values for encoding from quantization of the sampled signal are: ',num2str(i)])
disp(['The converted bits from the input analog signal are:',num2str(dig_data)])

