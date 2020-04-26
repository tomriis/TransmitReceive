function [ max_i ] = findMaxCorrelation(data, xcorr_signal)
    [c, lags] = xcorr(data, xcorr_signal);
    hilbert_c = abs(hilbert(c));
    u = mean(hilbert_c); sig = std(hilbert_c);
    
    minPeakHeight = u + 1.5*sig;
    minPeakProminence = 0.15 * max(hilbert_c);
    
    [pks, locs] = findpeaks(hilbert_c,'MinPeakHeight',minPeakHeight,'MinPeakProminence',minPeakProminence);

    if ~isempty(locs)    
        max_i = lags(locs(1));
    else
        max_i = 1;
        disp('NO PEAK');
        return
    end
    
    minSignalAmplitude = 5;
    if all(data<minSignalAmplitude)
        inds = find(pks>2.5*sig);
        if isempty(inds)
            [~,i] = max(pks);
            max_i = lags(locs(i));
        else
            max_i = lags(locs(inds(1)));
        end
    end
end