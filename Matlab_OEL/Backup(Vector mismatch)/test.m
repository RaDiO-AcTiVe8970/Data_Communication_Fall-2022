% Generate the two signals to be multiplexed
x1 = sin(2*pi*100*t); % First signal
x2 = cos(2*pi*200*t); % Second signal

% Create a carrier signal for ASK
carrier = cos(2*pi*fc*t);

% Multiplex the two signals by modulating them onto the carrier signal
% using ASK
s1 = x1.*carrier;
s2 = x2.*carrier;

% The multiplexed signal is the sum of the two modulated signals
s = s1 + s2;

% Demultiplex the signal by multiplying it with the carrier signal
% and low-pass filtering it
y1 = lowpass(s.*carrier, fc, fs);
y2 = lowpass(s.*carrier, 2*fc, fs);

% Plot the original and demultiplexed signals
plot(t, x1, t, y1);
plot(t, x2, t, y2);
