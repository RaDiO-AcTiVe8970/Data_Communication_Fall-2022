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
bitstream=[0 1 0 1 0 1 0 0 0 1 1 0];
no_bits= length(bitstream);
bit_rate=1000;
pulse_per_bit=1;
pulse_duration=1/((pulse_per_bit)*(bit_rate));
no_pulses=no_bits*pulse_per_bit;
samples_per_pulse = 500;
fs = (samples_per_pulse)/(pulse_duration);
t = 0:1/fs:(no_pulses)*(pulse_duration);
no_samples = length(t); 
dig_sig = zeros(1,no_samples);
max_voltage = 5;
mid_voltage = 0;
min_voltage = -5;
last_nonzero = min_voltage;
last_state=mid_voltage;

for i=1:no_bits
    if bitstream(i) == 1
        if last_nonzero==min_voltage && last_state ==mid_voltage
            dig_sig(((i-1)*(samples_per_pulse)+1):(i)*(samples_per_pulse)) = max_voltage*ones(1,samples_per_pulse);
            last_nonzero=max_voltage;
            last_state=max_voltage;
        elseif last_nonzero==min_voltage && last_state ==min_voltage
            dig_sig(((i-1)*(samples_per_pulse)+1):(i)*(samples_per_pulse)) = mid_voltage*ones(1,samples_per_pulse);
            last_nonzero=min_voltage;
            last_state=mid_voltage;
        elseif last_nonzero==max_voltage && last_state==max_voltage
            dig_sig(((i-1)*(samples_per_pulse)+1):(i)*(samples_per_pulse)) = mid_voltage*ones(1,samples_per_pulse);
            last_state=mid_voltage;
          
         elseif last_nonzero==max_voltage && last_state==mid_voltage
             
            dig_sig(((i-1)*(samples_per_pulse)+1):(i)*(samples_per_pulse)) = min_voltage*ones(1,samples_per_pulse);
            last_nonzero=min_voltage;
            last_state=min_voltage;
        end
    else
        
        dig_sig(((i-1)*(samples_per_pulse)+1):(i)*(samples_per_pulse)) = last_state*ones(1,samples_per_pulse);
    end
end
figure
plot(t,dig_sig,'linewidth',1.5)
grid on
xlabel('time in seconds')
ylabel('Voltage')
ylim([(min_voltage -(max_voltage)*0.2) (max_voltage+max_voltage*0.2)])
title(['MLT3 for ',num2str(bitstream)])
            