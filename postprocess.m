pkg load signal;
% Read input file csv into matrix
data = csvread('csv.out');

% Need to check and throw out incomplete data points.

% m(n) = r(n) + g(n) + epsilon(n)
% transducer = resp + bcg + noise

% butterworth filter 6th order 
% 3-dB cutoff freq 0.7Hz to 10Hz - 100hz sample rate

[b a] = butter(6, [0.7 10]/(100/2));
data_filtered = filter(b,a,data);
x = data_filtered(:,1);
y = data_filtered(:,2);
window_width = 30;
window_increment = 1;
num_steps = (length(data_filtered)-window_width+1)-1;
for i = 1:window_increment:num_steps;
	xe(i,1) = sumsq(x(i:i+window_width));
	ye(i,1) = sumsq(y(i:i+window_width));
end

% find peaks
[pks_x idx_x] = findpeaks(xe);
[pks_y idx_y] = findpeaks(ye);

% plot peaks on top of signal
subplot(1,2,1);
plot(xe, 'b', idx_x, pks_x, '.r');

subplot(1,2,2);
plot(ye, 'b', idx_y, pks_y, '.r');

% todo - pulse rate estimation from peaks 
% detect and throwout outliers  
%  -> check if pulse rate estimate is too far away from moving pulse rate value