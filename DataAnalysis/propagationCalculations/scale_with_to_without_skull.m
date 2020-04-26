function [ws_rx_data, wos_rx_data, scaler] = scale_with_to_without_skull(ws_rx_data,wos_rx_data)
    u_ws = mean(ws_rx_data); sig_ws = std(ws_rx_data);
    u_wos = mean(wos_rx_data); sig_wos = std(wos_rx_data);

    [pk_ws]=findpeaks(ws_rx_data,'MinPeakHeight',u_ws+sig_ws);
    [pk_wos]=findpeaks(wos_rx_data,'MinPeakHeight',u_wos+sig_wos);
    scaler = max(pk_wos)/max(pk_ws);
    ws_rx_data = scaler*ws_rx_data;
