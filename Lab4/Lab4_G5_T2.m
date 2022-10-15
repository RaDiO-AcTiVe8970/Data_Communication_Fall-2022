clc
clear all
close all
bit_stream = [0 1 0 1 0 1 0 0 0 1 1 0];
no_bits = length(bit_stream);
bit_rate = 1000; 
pulse_per_bit = 2; 
pulse_duration = 1/((pulse_per_bit)*(bit_rate));
no_pulses = no_bits*pulse_per_bit;
samples_per_pulse = 500;
fs = (samples_per_pulse)/(pulse_duration); 
t = 0:1/fs:(no_pulses)*(pulse_duration); 
no_samples = length(t); 
dig_sig = zeros(1,no_samples);
max_voltage = +5;
min_voltage = -5;
inv_bit = 1; 
last_state = max_voltage;
inv_last_state = min_voltage; 
for i = 1:no_bits
 j = (i-1)*2;
 if bit_stream(i) == inv_bit
 
dig_sig((j*(samples_per_pulse)+1):(j+1)*(samples_per_pulse)) = inv_last_state*ones(1,samples_per_pulse);
 
dig_sig(((j+1)*(samples_per_pulse)+1):(j+2)*(samples_per_pulse)) = last_state*ones(1,samples_per_pulse);
 else
 
dig_sig((j*(samples_per_pulse)+1):(j+1)*(samples_per_pulse)) = last_state*ones(1,samples_per_pulse);
 
dig_sig(((j+1)*(samples_per_pulse)+1):(j+2)*(samples_per_pulse)) = inv_last_state*ones(1,samples_per_pulse);
 temp_cons = last_state; 
 last_state = inv_last_state;
 inv_last_state = temp_cons;
 end
end
figure
plot(t,dig_sig,'linewidth',1.5)
grid on
xlabel('time in seconds')
ylabel('Voltage')
ylim([(min_voltage - (max_voltage)*0.2) 
(max_voltage+max_voltage*0.2)])
title(['Differential Manchester for ',num2str(bit_stream),', last state = ',num2str(last_state),', inverting bit is ',num2str(inv_bit),''])
