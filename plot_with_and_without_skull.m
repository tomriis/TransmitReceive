function plot_with_and_without_skull(with_skull, without_skull,frame_number, acq_number)

ws = load(with_skull,'RcvData','Resource','Receive');
[ws_rx_data, ws_tx_data] = get_frame_acq(ws.RcvData, ws.Resource, ws.Receive, frame_number);
fs = ws.Receive(1).ADCRate*1e6/ws.Receive(1).decimFactor;
t= 1e6*(1/fs:1/fs:(size(ws_rx_data,2)*1/fs));
wos = load(without_skull,'RcvData','Resource','Receive');
[wos_rx_data, wos_tx_data] = get_frame_acq(wos.RcvData, wos.Resource, wos.Receive,frame_number);

h = figure;
%subplot(2,1,1);
options.x_axis = t;
options.error = 'std';
options.handle = h;
options.alpha      = 0.5;
options.line_width = 2;
options.color_area = [128 193 219]./255;    % Blue theme
options.color_line = [ 52 148 186]./255;
data = ws_rx_data;
options.DisplayName = 'Skull';
plot_areaerrorbar(data, options)
%plot(t,ws_rx_data(acq_number,:),'DisplayName','Skull');
hold on;
options.color_area = [243 169 114]./255;    % Orange theme
options.color_line = [236 112  22]./255;
data = wos_rx_data;
options.DisplayName = 'No Skull';
plot_areaerrorbar(data, options)
%plot(t,wos_rx_data(acq_number,:),'DisplayName','No Skull');
legend;
title('Through Skull Receive Signal');
xlabel('Time (us)');
figure;
%subplot(2,1,2);
plot(t,ws_tx_data(acq_number,:),'DisplayName','Skull');
hold on;
plot(t,wos_tx_data(acq_number,:),'DisplayName','No Skull');
legend;
title('Through Skull Transmit Signal');
xlabel('Time (us)');
end