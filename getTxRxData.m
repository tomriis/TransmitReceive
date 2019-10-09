function data = getTxRxData(RcvData, Resource, Receive)
    data = struct();
    [rx_data, tx_data] = get_frame_acq(RcvData, Resource, Receive, 1);
    data.tx_data = zeros([size(tx_data),size(RcvData{1},3)]);
    data.rx_data = zeros([size(rx_data),size(RcvData{1},3)]);
    for i = 1:size(RcvData{1},3)
        [rx_data, tx_data] = get_frame_acq(RcvData, Resource, Receive, i);
        data.tx_data(:,:,i) = tx_data;
        data.rx_data(:,:,i) = rx_data;
    end
end