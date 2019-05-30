function plot_with_and_without_skull(with_skull, without_skull,frame_number, acq_number)

ws = load(with_skull,'RcvData','Resource','Receive');
[ws_rx_data, ws_tx_data] = get_frame_acq(ws.RcvData, ws.Resource, ws.Receive, frame_number);
fs = ws.Receive(1).ADCRate*1e6/ws.Receive(1).decimFactor;
t= 1e6*(1/fs:1/fs:(size(ws_rx_data,2)*1/fs));
wos = load(without_skull,'RcvData','Resource','Receive');
[wos_rx_data, wos_tx_data] = get_frame_acq(wos.RcvData, wos.Resource, wos.Receive,frame_number);
% wos_rx_data = wos_tx_data;
% ws_rx_data = ws_tx_data;
h = figure;
%subplot(2,1,1);
options.x_axis = t;
options.error = 'std';
options.handle = h;
options.alpha      = 0.5;
options.line_width = 2;
options.color_area = [243 169 114]./255;    % Orange theme
options.color_line = [236 112  22]./255;
data = wos_rx_data;
options.DisplayName = 'No Skull';
plot_areaerrorbar(data, options)
%plot(t,ws_rx_data(acq_number,:),'DisplayName','Skull');
hold on;
%plot(t,wos_rx_data(acq_number,:),'DisplayName','No Skull');
options.color_area = [128 193 219]./255;    % Blue theme
options.color_line = [ 52 148 186]./255;
data = 45*ws_rx_data;
options.DisplayName = 'Skull';
plot_areaerrorbar(data, options)
legend;
title('184 Rx 15 Cycles');
xlabel('Time (us)');
hold off;

% figure;
% acqs = size(ws_rx_data,1);
% a_n = [1, floor(acqs/2), acqs];
% for i = 1:3
% plot(t,ws_rx_data(a_n(i),:),'DisplayName',strcat(['Skull ',num2str(a_n(i))]));
% hold on;
% plot(t,wos_rx_data(a_n(i),:),'DisplayName',strcat(['No Skull ',num2str(a_n(i))]));
% hold on;
% end
% hold off;
% legend;
% title('184 mm Rx 15 Cycles, Individual Traces');
% xlabel('Time (us)');

% [Ps,f1] = fft_of(ws_rx_data(a_n(i),:),fs);
% [Pos,f2] = fft_of(wos_rx_data(a_n(i),:),fs);
% figure;
% plot(f1,Ps,'DisplayName','Skull'); hold on;
% plot(f2,Pos,'DisplayName','No Skull');
% title('Single-Sided Amplitude Spectrum of X(t)')
% xlabel('f (Hz)')
% ylabel('|P1(f)|')

end

function [P1,fs] = fft_of(excitation,fs)
    L = length(excitation);       % Length of s
    Y = fft(excitation);
    P2 = abs(Y/L);
    P1 = P2(1:round(L/2)+1);
    P1(2:end-1) = 2*P1(2:end-1);
    f = fs*(0:(L/2))/L;
end
