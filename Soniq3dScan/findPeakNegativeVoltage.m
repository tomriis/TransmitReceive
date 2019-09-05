function pnv = findPeakNegativeVoltage(v,nCycles)
if nCycles < 5
    pnv = -min(v);
else
    threshold = 0.65*max(v);
    idx = find(v>=threshold);
    idx1 = idx(1);
    idxEnd = idx(end);
    pulse = -v(idx1:idxEnd);
    [peaks,idx] = findpeaks(pulse,'MinPeakProminence',threshold);
    idx = idx(peaks>0);
    peaks = peaks(peaks>0);
%     if length(peaks) > nCycles
%         peaks = peaks(1:nCycles);
%         idx = idx(1:nCycles);
%     end
    pnv = median(peaks);
end
if 0
    figure
    subplot(211)
    plot(v)
    hold on
    plot([1,length(v)],-[pnv,pnv],'--')
    subplot(212)
    plot(pulse)
    hold on
    plot(idx,peaks,'*')
end

