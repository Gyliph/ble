pkg load signal;
% Read input file csv into matrix
data = csvread('csv.out');

% Need to check and throw out incomplete data points.

% m(n) = r(n) + g(n) + epsilon(n)
% transducer = resp + bcg + noise
x = data(:,1);
y = data(:,2);
z = data(:,3);

% butterworth filter 6th order 
% 3-dB cutoff freq 0.7Hz to 10Hz
% butter(n, Wn, ftype) => order is 2n, 
n = 6;    % Order
% 1 Hz = 2*pi rads/sec
fc1 = 4.39822971; % 0.7 Hz
fc2 = 62.831853;  % 10 Hz
Wn = [fc1 fc2];
ftype = 'bandpass';

[b a] = butter(6, [0.7 10]/(100/2));
x_filtered = filter(b,a,data);

figure;
plot(x_filtered);

figure;
plot(data);
