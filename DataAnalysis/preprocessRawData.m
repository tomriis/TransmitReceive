function [data] = preprocessRawData(data)
 N = 15;
 n_positions = size(data(1).tx_data,3);
 data.tx = zeros(n_positions, length(data.tx_data(1,:,1)));
for k = 1:n_positions 
    for j = 1:N
        data.tx_data(j, :, k) = filtfilt(d, data.tx_data(j, :, k));
        data.rx_data(j, :, k) = filtfilt(d, data.rx_data(j, :, k));
    end
    data.tx(k,:) = mean(data.tx_data(1 : N, :, k), 1);
    data.rx(k,:) = mean(data.rx_data(1 : N, :, k), 1);
end