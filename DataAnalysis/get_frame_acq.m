function [rx_data, tx_data] = get_frame_acq(RcvData, Resource, Receive, frame_number)
    rx_channel = Resource.Parameters.rx_channel;
    tx_channel = Resource.Parameters.tx_channel;
    numAvg = Resource.Parameters.numAvg;
    n_frames = Resource.RcvBuffer.numFrames;
    n_samples_per_frame = length(Receive(1).startSample:Receive(1).endSample);

    rx_data = zeros([numAvg, n_samples_per_frame]);
    tx_data = zeros([numAvg, n_samples_per_frame]);
    for j = 1:numAvg
        idx = (frame_number-1)*numAvg+j;
        if iscell(RcvData)
            rx_data(j,:) = RcvData{1}((Receive(idx).startSample:Receive(idx).endSample),...,
                rx_channel, frame_number);
            tx_data(j,:) = RcvData{1}(Receive(idx).startSample:Receive(idx).endSample,...,
                tx_channel, frame_number);
        else
             rx_data(j,:) = RcvData((Receive(idx).startSample:Receive(idx).endSample),...,
                rx_channel);
             tx_data(j,:) = RcvData(Receive(idx).startSample:Receive(idx).endSample,...,
                tx_channel);
        end
    end
end