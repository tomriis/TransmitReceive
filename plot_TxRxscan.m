function [rx_avg_scan,tx_avg_scan] = plot_TxRxscan(RcvData, Resource, Receive, frame_number)
    [rx_avg_scan, tx_avg_scan] = get_avg_scan(RcvData, Resource, Receive);
    n_frames = Resource.RcvBuffer.numFrames;
    pos = Resource.Parameters.positions;
    fs = Receive(1).ADCRate*1e6/Receive(1).decimFactor;
    t= 1e6*(1/fs:1/fs:(size(rx_avg_scan,2)*1/fs));
    figure;
    for i = 1:n_frames
        if i == frame_number || frame_number ==0
        %plot(tx_avg_scan(i,:),'DisplayName',strcat(['Scan ', num2str(i)]));
            plot(t, rx_avg_scan(i,:),'DisplayName',strcat([' x: ', num2str(pos(i,1)),' y: ', num2str(pos(i,2))]));
        hold on;
        end
    end
    legend;
    xlabel('Time (us)');
    ylabel('Voltage');
    title('Receive Signal');
    
    figure;
     for i = 1:n_frames
          if i == frame_number || frame_number ==0
            plot(t, tx_avg_scan(i,:),'DisplayName',strcat(['Transmit ', num2str(i)]));
            hold on;
            plot(t, rx_avg_scan(i,:),'DisplayName',strcat(['Receive ', num2str(i)]));
          end
    end
    legend;
    xlabel('Time (us)');
    ylabel('Voltage');
    title('Transmit/Receive Signal');

    
        
end