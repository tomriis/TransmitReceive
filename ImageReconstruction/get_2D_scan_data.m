function [all_data] = get_2D_scan_data(data_directory,fs)
    Files=dir([char(data_directory),'*','.mat']);
    all_data = struct();
    count = 1;
    


dLow = designfilt('lowpassfir','PassbandFrequency',600000, ...
     'StopbandFrequency',1000000,'PassbandRipple',0.0001, ...
     'StopbandAttenuation',20,'DesignMethod','kaiserwin', 'SampleRate',fs);

dHigh = designfilt('highpassfir','PassbandFrequency',300000, ...
     'StopbandFrequency',50000,'PassbandRipple',0.0001, ...
     'StopbandAttenuation',30,'DesignMethod','kaiserwin', 'SampleRate',fs);


    for i = 1:length(Files)
        S = load([Files(i).folder,'\',Files(i).name]);
        
        n_positions = size(S.data.positions,1);
        N = 19;
        if S.data.failed
            disp('Failed on ')
            disp(Files(i).name);
        else
            for k = 1:n_positions 
                all_data(count).raw_xdr_1(1,:) = mean(S.data.tx_data(1:N, :, k),1);
                all_data(count).raw_xdr_1(2,:) = mean(S.data.tx_data(N+1:end, :,k),1);
                all_data(count).raw_xdr_2(1,:) = mean(S.data.rx_data(1:N, :, k),1);
                all_data(count).raw_xdr_2(2,:) = mean(S.data.rx_data(N+1:end, :, k),1);
                
                for j = 1:size(S.data.tx_data,1)
                    S.data.tx_data(j, :, k) = filtfilt(dLow, S.data.tx_data(j, :, k));
                    S.data.rx_data(j, :, k) = filtfilt(dLow, S.data.rx_data(j, :, k));
                    S.data.tx_data(j, :, k) = filtfilt(dHigh, S.data.tx_data(j, :, k));
                    S.data.rx_data(j, :, k) = filtfilt(dHigh, S.data.rx_data(j, :, k));
                end
                xdr_1 = mean(S.data.tx_data(1 : N, :, k), 1);
                xdr_1_short_pulse = mean(S.data.tx_data(N+1:end,:,k),1);
                xdr_2 = mean(S.data.rx_data(1 : N, :, k), 1);
                xdr_2_short_pulse = mean(S.data.rx_data(N+1:end, :, k), 1);
                all_data(count).xdr_1(1,:) = xdr_1;
                all_data(count).xdr_1(2,:) = xdr_1_short_pulse;
                all_data(count).xdr_2(1,:) = xdr_2;
                all_data(count).xdr_2(2,:) = xdr_2_short_pulse;
                all_data(count).position = S.data.positions(k,:); 
                count = count + 1;
            end
        end
        disp(['On ',num2str(i), ' of ', num2str(length(Files))]);
    end
end

