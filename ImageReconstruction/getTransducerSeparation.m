function L = getTransducerSeparation(control_data, xcorr_signal, fs, c)
    corr_i = ones(1,length(control_data));
    max_peak = ones(size(corr_i));
    for i = 1:length(control_data)
        try
        f = control_data(i).xdr_2(1,:);
        corr_i(i) = findMaxCorrelation(f, xcorr_signal(1,:));
        hilb = abs(hilbert(control_data(i).xdr_2(2,:)));
        [pks,locs,w]=findpeaks(hilb,'MinPeakHeight',0.65* max(f));
        [~,max_i] = max(pks);
        max_peak(i) = locs(max_i)-w(max_i)/2;
        catch e
            disp(e.message)
            disp(i)
        end
    end
    median_i = median(corr_i); 
    sig = std(corr_i);
    disp(strcat(['Median: ',num2str(median_i)]));
    disp(strcat(['STD: ', num2str(sig)]));
    t = median_i*1/fs;
    L = t*c*1000; %mm
%     disp(num2str(L));
%     x = zeros(1, length(f));
%     x(round(median_i)) = max(f);
%     figure; plot(f); hold on; plot(x);
%     title('Correlation');
%     disp('________________________');
%         median_i = median(max_peak); 
%     sig = std(max_peak);
%     disp(strcat(['Median: ',num2str(median_i)]));
%     disp(strcat(['STD: ', num2str(sig)]));
%     t = median_i*1/fs;
%     L = t*c*1000; %mm
%     disp(num2str(L));
%     x = zeros(1, length(f));
%     x(round(median_i)) = max(f);
%     figure; plot(f); hold on; plot(x);
%     title('Max Value');
end
    