function [all_data] = get_2D_scan_data(data_directory,fs)
    Files=dir([char(data_directory),'*','.mat']);
    all_data = struct();
    count = 1;
    
%     d = designfilt('lowpassfir','FilterOrder',8, ...
%          'PassbandFrequency',700e3,'PassbandRipple',0.2, ...%'StopbandFrequency',7.3529e+06,...%
%          'SampleRate',fs);
    d = designfilt('lowpassiir','FilterOrder',8, ...
         'PassbandFrequency',700e3,'PassbandRipple',0.2, ...
         'SampleRate',fs);

    for i = 1:length(Files)
        S = load([Files(i).folder,'\',Files(i).name]);
        
        n_positions = size(S.data.positions,1);
        N = 20;
        for k = 1:n_positions 
            for j = 1:N
                S.data.tx_data(j, :, k) = filtfilt(d, S.data.tx_data(j, :, k));
                S.data.rx_data(j, :, k) = filtfilt(d, S.data.rx_data(j, :, k));
            end
            xdr_1 = mean(S.data.tx_data(1 : N, :, k), 1);
            xdr_2 = mean(S.data.rx_data(1 : N, :, k), 1);
            all_data(count).xdr_1(1,:) = xdr_1;
            all_data(count).xdr_2(1,:) = xdr_2;
            all_data(count).position = S.data.positions(k,:); 
            count = count + 1;
        end
        disp(['On ',num2str(i), ' of ', num2str(length(Files))]);
    end
end

