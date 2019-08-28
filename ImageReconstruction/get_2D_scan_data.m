function [all_data] = get_2D_scan_data(data_directory)
    Files=dir([char(data_directory),'*','.mat']);
    all_data = struct();
    count = 1;
    for i = 1:length(Files)
        S = load([Files(i).folder,'\',Files(i).name]);
        n_scans_per_pos = size(S.data.tx_data, 1)/2;
        n_positions = size(S.data.positions,1);
        for k = 1:n_positions 
            for j = 1:2
                send = mean(S.data.tx_data((j-1)*n_scans_per_pos+1 : (j*n_scans_per_pos), :, k), 1);
                receive = mean(S.data.rx_data((j-1)*n_scans_per_pos+1 : (j*n_scans_per_pos), :, k), 1);
                all_data(count).tx(j,:) = send;
                all_data(count).rx(j,:) = receive;
                all_data(count).position = S.data.positions(k,:); 
            end
            count = count + 1;
        end
        disp(['On ',num2str(i), ' of ', num2str(length(Files))]);
    end
end

