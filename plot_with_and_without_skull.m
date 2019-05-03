function plot_with_and_without_skull(with_skull, without_skull,frame_number, acq_number)

ws = load(with_skull,'RcvData','Resource','Receive');
[ws_rx_data, ws_tx_data] = get_frame_acq(ws.RcvData, ws.Resource, ws.Receive, frame_number);
fs = ws.Receive(1).ADCRate*1e6/ws.Receive(1).decimFactor;
t= 1e6*(1/fs:1/fs:(size(ws_rx_data,2)*1/fs));
wos = load(without_skull,'RcvData','Resource','Receive');
[wos_rx_data, wos_tx_data] = get_frame_acq(wos.RcvData, wos.Resource, wos.Receive,frame_number);

figure;
subplot(2,1,1);
plot(t,ws_rx_data(acq_number,:),'DisplayName','Skull');
hold on;
plot(t,wos_rx_data(acq_number,:),'DisplayName','No Skull');
legend;
title('Through Skull Receive Signal');
xlabel('Time (us)');
%figure;
subplot(2,1,2);
plot(t,ws_tx_data(acq_number,:),'DisplayName','Skull');
hold on;
plot(t,wos_tx_data(acq_number,:),'DisplayName','No Skull');
legend;
title('Through Skull Transmit Signal');
xlabel('Time (us)');
end