pkg load signal;
% Read input file csv into matrix
data = csvread('csv2.out');

% Need to check and throw out incomplete data points.

% m(n) = r(n) + g(n) + epsilon(n)
% transducer = resp + bcg + noise

% butterworth filter 6th order 
% 3-dB cutoff freq 0.7Hz to 10Hz - 100hz sample rate
[b a] = butter(6, 0.3, 'low');
data_l = filter(b,a,data);

subplot(3,1,1);
plot(data_l);

[b a] = butter(6, [0.7 10]/(100/2));
data_filtered = filter(b,a,data_l);
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
subplot(3,1,2);
plot(xe, 'b', idx_x, pks_x, '.r');

subplot(3,1,3);
plot(ye, 'b', idx_y, pks_y, '.r');

p_window_width = 1000;
p_window_increment = 500;
p_num_steps = (length(xe)-p_window_width+1)-1;
for i = 1:p_window_increment:p_num_steps-1;
  % Grab window value
  xt = xe(i:i+p_window_width);
  yt = ye(i:i+p_window_width);
  % Find peaks in window
  [pks_x idx_x] = findpeaks(xt);
  [pks_y idx_y] = findpeaks(yt);
  % Estimate pulse rate from peaks
  % find distance between peaks
  if(length(idx_x) > 1) 
      average_num_periods = mean(abs(diff(idx_x)));
      %period_sec = 0.01*average_num_periods;
      period_sec = 0.01*average_num_periods
      bps = 1/period_sec;
      bpm = bps*60
   end
   subplot(3,1,2);
   plot(xt, 'b', idx_x, pks_x, '.r');
   subplot(3,1,3); 
   plot(yt, 'g', idx_y, pks_y, '.r');
   waitforbuttonpress;
   
end
% todo - pulse rate estimation from peaks 
% detect and throwout outliers  
%  -> check if pulse rate estimate is too far away from moving pulse rate value