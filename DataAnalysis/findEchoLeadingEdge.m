function [ leadingEdge_i ] = findEchoLeadingEdge(data, xcorr_signal)
    [c, lags] = xcorr(data, xcorr_signal);
    u = mean(c); sig = std(c);
    
    minPeakHeight = u + 1.5*sig;
    minPeakProminence = 0.15 * max(c);
    
    [pks, locs] = findpeaks(c,'MinPeakHeight',minPeakHeight,'MinPeakProminence',minPeakProminence);

    if ~isempty(locs)
        if length(locs)==1    
            leadingEdge_i = lags(locs(1));
        else
            leadingEdge_i = lags(locs(2));
        end
    else
        leadingEdge_i = 1;
        disp('NO PEAK');
        return
    end 
end