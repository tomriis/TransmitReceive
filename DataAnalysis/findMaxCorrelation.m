function [ max_i ] = findMaxCorrelation(data, xcorr_signal)
    [c, lags] = xcorr(data, xcorr_signal);
    [~, i] = max(c);
    max_i = lags(i);
end