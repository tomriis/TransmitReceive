function [all_data] = get2DScanData(data_directory,fs, TxEvents, NA)
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
        all_data(count).raw_xdr_1 = S.data.tx_data;
        all_data(count).raw_xdr_2 = S.data.rx_data;
        for j = 1:size(S.data.tx_data,1)
            S.data.tx_data(j, :) = filtfilt(dLow, S.data.tx_data(j, :));
            S.data.rx_data(j, :) = filtfilt(dLow, S.data.rx_data(j, :));
            S.data.tx_data(j, :) = filtfilt(dHigh, S.data.tx_data(j, :));
            S.data.rx_data(j, :) = filtfilt(dHigh, S.data.rx_data(j, :));
        end
        all_data(count).filt_xdr_1 = S.data.tx_data;
        all_data(count).filt_xdr_2 = S.data.rx_data;

        for k = 1:TxEvents
            all_data(count).xdr_1(k,:) = mean(S.data.tx_data((k-1)*NA+1:k*NA,:),1);
            all_data(count).xdr_2(k,:) = mean(S.data.rx_data((k-1)*NA+1:k*NA,:),1);
        end
        all_data(count).position = S.data.positions; 
        all_data(count).TxEvents = TxEvents;
        all_data(count).NA = NA;
        count = count + 1;

        disp(['On ',num2str(i), ' of ', num2str(length(Files))]);
    end
end

