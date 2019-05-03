function [rx_avg_scan,tx_avg_scan] = plot_TxRxscan(RcvData, Resource, Receive, frame_number)
    [rx_avg_scan, tx_avg_scan] = get_avg_scan(RcvData, Resource, Receive);
    n_frames = Resource.RcvBuffer.numFrames;
    pos = Resource.Parameters.positions;
    fs = Receive(1).ADCRate*1e6/Receive(1).decimFactor;
    figure;
    for i = 1:n_frames
        if i == frame_number || frame_number ==0
        %plot(tx_avg_scan(i,:),'DisplayName',strcat(['Scan ', num2str(i)]));
            plot(rx_avg_scan(i,:),'DisplayName',strcat([' x: ', num2str(pos(i,1)),' y: ', num2str(pos(i,2))]));
        hold on;
        end
    end
    legend;
    xlabel('Sample Number');
    ylabel('Voltage');
    title('Receive Signal');
    
    figure;
     for i = 1:n_frames
          if i == frame_number || frame_number ==0
            plot(tx_avg_scan(i,:),'DisplayName',strcat(['Scan ', num2str(i)]));
            hold on;
          end
    end
    legend;
    xlabel('Sample Number');
    ylabel('Voltage');
    title('Transmit Signal');
        
end