function [d_t] = calculate_speedup(skull,no_skull,frame_number)

ws = load(skull,'RcvData','Resource','Receive');
wos = load(no_skull,'RcvData','Resource','Receive');
[wos_rx_data, wos_tx_data] = get_frame_acq(wos.RcvData, wos.Resource, wos.Receive,frame_number);
[ws_rx_data, ws_tx_data] = get_frame_acq(ws.RcvData, ws.Resource, ws.Receive, frame_number);
fs = ws.Receive(1).ADCRate*1e6/ws.Receive(1).decimFactor;
t= 1e6*(1/fs:1/fs:(size(ws_rx_data,2)*1/fs));

% Isolate window
h = figure;

acqs = size(ws_rx_data,1);

plot(ws_rx_data(1,:));
hold on;
plot(wos_rx_data(1,:));
hold off;
legend;
title('Create search area and press any key to continue');
xlabel('Sample Number');
rect = drawrectangle();
while true
    w = waitforbuttonpress;
    if w==1
        positions = rect.Position;
        x1 = fix(positions(1)); x2 = fix(positions(1)+positions(3));

        break;
    end
end
positions = rect.Position;
close(h);
x1 = fix(positions(1)); x2 = fix(positions(1)+positions(3));

n_acquisitions = size(ws_rx_data,1);
d_t = zeros([1,n_acquisitions]);
for j = 1:n_acquisitions
ws_rx = ws_rx_data(j,x1:x2);
wos_rx = wos_rx_data(j, x1:x2);
t_slice = t(x1:x2);
% Scale data to match

[ws_rx,wos_rx] = scale_with_to_without_skull(ws_rx, wos_rx);
% remove DC offset
ws_rx = ws_rx-mean(ws_rx);
wos_rx = wos_rx-mean(wos_rx);

% Calculate RMSE cost function over overlap range

cost = zeros([1,length(ws_rx)]);
for i = 1:length(ws_rx)
    cost(i) = cost_function(i,ws_rx, wos_rx);
end

[~,i] = min(cost);
u_ws = mean(ws_rx);
new_ws_rx_data = circshift(ws_rx, i);
new_ws_rx_data(1:i) = u_ws;

d_t(j)= i*1/fs;
end
figure;
plot(t_slice-min(t_slice), cost./max(cost));
title('Cost Function');
xlabel('\Delta t');

figure;
subplot(3,1,1);
plot(t_slice, ws_rx,'DisplayName','No Skull');
hold on; plot(t_slice, wos_rx,'DisplayName','Skull'); hold off;
xlabel('Time');
title('Original Signal');

subplot(3,1,2);
plot(t_slice, new_ws_rx_data,'DisplayName','No Skull');
hold on; plot(t_slice, wos_rx,'DisplayName','Skull'); hold off;
xlabel('Time');
title('Shifted Signal');

subplot(3,1,3);
histogram(d_t);
xlabel('\Delta t (us)');
title(strcat(['\Delta t over all ', num2str(n_acquisitions),' Acquisitions']));

end

function J = cost_function(dx, v_ws, v_wos)
u_ws = mean(v_ws); u_wos = mean(v_wos);
v_ws = circshift(v_ws, dx);
if dx > 1
    v_ws(1:dx) = u_ws;
else
    v_ws(end-dx:end) = u_ws;
end
J = sum(sqrt((v_ws-v_wos).^2));
end






