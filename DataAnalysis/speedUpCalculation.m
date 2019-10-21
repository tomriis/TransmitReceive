function data_dt = speedUpCalculation(data, n_ws_rx_data, control_data, fs)
        ws_rx_data = data(n_ws_rx_data).rx;
        
        
        [x1, x2] = getRxWindow(ws_rx_data, wos_rx_data);
        
        speed_up = zeros(2,length(data));
        for k = 1:length(data)