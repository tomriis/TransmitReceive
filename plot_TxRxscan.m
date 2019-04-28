function [rx_avg_scan,tx_avg_scan] = plot_TxRxscan(RcvData, Resource, Receive)
    rx_channel = Resource.Parameters.rx_channel;
    tx_channel = Resource.Parameters.tx_channel;
    numAvg = Resource.Parameters.numAvg;
    n_frames = Resource.RcvBuffer.numFrames;
    fs = Receive(1).ADCRate*1e6/Receive(1).decimFactor;
    n_samples_per_frame = length(Receive(1).startSample:Receive(1).endSample);
    rx_avg_scan = zeros([n_frames, n_samples_per_frame]);
    tx_avg_scan = zeros([n_frames, n_samples_per_frame]);
    for i = 1:n_frames
        rx_data = zeros([numAvg, n_samples_per_frame]);
        tx_data = zeros([numAvg, n_samples_per_frame]);
        for j = 1:numAvg
            idx = (i-1)*numAvg+j;
            rx_data(j,:) = RcvData{1}(Receive(idx).startSample:Receive(idx).endSample,...,
                rx_channel, i);
            tx_data(j,:) = RcvData{1}(Receive(idx).startSample:Receive(idx).endSample,...,
                tx_channel, i);
        end
        rx_avg_scan(i,:) = sum(rx_data,1)/numAvg;
        tx_avg_scan(i,:) = sum(tx_data,1)/numAvg;
    end
    
    for i = 1:n_frames
        plot(rx_avg_scan(i,:),'DisplayName',strcat(['Scan ', num2str(i)]));
        hold on;
    end
    legend;
    xlabel('Sample Number');
    ylabel('Voltage');
    title('Receive Signal');
    
        
end