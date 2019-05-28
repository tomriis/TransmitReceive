
with_frame = 'V_50_cycles_15_with_skull_frames_100.mat';
without_frame = 'V_50_cycles_15_without_skull_frames_100.mat';

ws = load(with_frame,'RcvData','Resource','Receive');
wos = load(without_frame,'RcvData','Resource','Receive');

fs = ws.Receive(1).ADCRate*1e6/ws.Receive(1).decimFactor;


rcv = ws.RcvData{1}(:,100,1);
rcv_wos = wos.RcvData{1}(:,100,1);

t= 1e6*(1/fs:1/fs:(size(rcv,1)*1/fs));

figure; 
plot(t, rcv, 'DisplayName','Skull'); hold on;
plot(t, rcv_wos, 'DisplayName','No Skull');
title('Receive 15 Cycles');
xlabel('Time (us)');
ylabel('Amplitude');
legend;

tx = ws.RcvData{1}(:,1,1);
tx_wos = wos.RcvData{1}(:,1,1);

figure;
plot(t, tx, 'DisplayName','Skull'); hold on;
plot(t, tx_wos, 'DisplayName','No Skull');
title('Transmit 15 Cycles');
xlabel('Time (us)');
ylabel('Amplitude');
legend;

