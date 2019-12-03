function [app] = ShowImageProcessing(c_data, i, tx_i, h, app)
m_plot = 2;
n_plot = 2;
p = 1;
data = c_data(i);
fs = evalin('base','fs');
xcorr_signal = evalin('base','xcorr_signal');

nSamples = length(data(1).xdr_1);
t= (1/fs:1/fs:(nSamples*1/fs))*1e6;
x = (1:nSamples)*1540e3/fs/2; %cm

% RAW DATA PLOT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp(['This is echo i: ', num2str(data.echo_i(tx_i))]);
subplot(m_plot, n_plot, p);
f = plotRawData(data, tx_i);
app.oversight.roi1 = images.roi.Point(gca, 'Position',[data.echo_i(tx_i),f(data.echo_i(tx_i))]);
p = p+1;
hold off;

% Correlation %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(m_plot, n_plot, p);
[lags, hilbert_c, locs] = plotCorrelationData(f, xcorr_signal, tx_i);
[~, ind] = min(abs(lags-data.echo_i(tx_i)));
app.oversight.roi = images.roi.Point(gca, 'Position',[data.echo_i(tx_i), hilbert_c(ind)]);
app.oversight.peak_i = lags(locs);
p = p+1;
hold off;

if tx_i == 2
    tx_i_2 = 1;
else
    tx_i_2 = 3;
end
%%% Second Row
%%%% plot raw data
subplot(m_plot, n_plot, p);
plotRawData(data,tx_i_2);
app.oversight.roi3 = images.roi.Point(gca, 'Position',[data.echo_i(tx_i),f(data.echo_i(tx_i))]);
p = p+1;
hold off;

%%%% plot correlation data
subplot(m_plot, n_plot, p);
[lags, hilbert_c, locs] = plotCorrelationData(f, xcorr_signal, tx_i_2);
p = p+1;
hold off;

set(h,'Position',[720 0 1200 1000])
axesHandles = findobj(get(h,'Children'), 'flat','Type','axes');
axis(axesHandles,'square')
makeFigureBig(h);

end

function f = plotRawData(data, tx_i)
    if tx_i <=2
        f = data.xdr_1(tx_i,:);
    else
        f = data.xdr_2(tx_i,:);
    end
    plot(f); hold on;
    plot(data.echo_i(tx_i), f(data.echo_i(tx_i)),'b*');
    title(['Echo Index: ',num2str(data.echo_i(tx_i))]);
end

function [lags, hilbert_c, locs] = plotCorrelationData(f, xcorr_signal, tx_i)
    [c, lags] = xcorr(f, xcorr_signal(tx_i,:));
    hilbert_c = abs(hilbert(c));
    u = mean(hilbert_c); sig = std(hilbert_c);    
    minPeakHeight = u + 1.5*sig;
    minPeakProminence = 0.15 * max(hilbert_c);
    mask = lags>=0;
    hilbert_c2 = hilbert_c(mask);
    lags2 = lags(mask);
    
    [pks, locs] = findpeaks(hilbert_c,'MinPeakHeight',minPeakHeight,'MinPeakProminence',minPeakProminence);
    plot(lags2, hilbert_c2); hold on; 
    for i = 1:length(pks)
        plot(lags(locs(i)),pks(i),'r*'); hold on;
    end
end
