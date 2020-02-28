clear;

h = figure; m = 3; n = 1; d = 0.0059; cw = 1487.6;
% 
% [rx_data, tx_data] = get_frame_acq(RcvData, Resource, Receive, 1);
% fs = Receive(1).ADCRate*1e6/Receive(1).decimFactor;
% save('Tx6Data_3.mat','rx_data','tx_data','fs');
index = 1;

load('ControlDataEpotek301FL.mat');
control = rx_data(index,:);
load('Tx6Data_2.mat');

ml = rx_data(index,:);

di = [0,0];
subplot(m,n,1)
plot(ml); hold on; 
plot(control);
title('Original Signals');

subplot(m,n,2);
x_cut = 948;
ml(1:x_cut) = 0;
control(1:x_cut) = 0;
[r,lags] = xcorr(control, ml);
[~,max_i] = max(r);
plot(circshift(ml, max_i)); hold on;
plot(control);

disp(lags(max_i)/fs)
di(1) = lags(max_i);
dt = lags(max_i)/fs;
title(['Correlation Matching: Speed Up ', num2str(di(1)), ' Samples']);

speed = (1/(1/cw-dt/d));
disp(['~ ', num2str(speed),' m/s']);

[~, max_c_i] = max(control);
[~, max_ml_i] = max(ml);
% max_ml_i = 3367;%2138;

di(2) = abs(max_ml_i-max_c_i);

subplot(m,n,3);
plot(circshift(ml,di(2))); hold on;
plot(control);
disp('-------------------------');
dt = di(2)/fs;
disp(dt);
speed = (1/(1/cw-dt/d));
disp(['~ ',num2str(speed), ' m/s']);
disp('-------------------------');
title(['Max Peak Matching: Speed Up ', num2str(di(2)), ' Samples']);
set(gcf,'color','w');
