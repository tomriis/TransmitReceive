function ShowImageProcessing(c_data, i, tx_i)
h = figure; 
m_plot = 1;
n_plot = 2;
p = 1;
data = c_data(i);
fs = evalin('base','fs');
xcorr_signal = evalin('base','xcorr_signal');

nSamples = length(data(1).xdr_1);
t= (1/fs:1/fs:(nSamples*1/fs))*1e6;
x = (1:nSamples)*1540e3/fs/2; %cm

% RAW DATA PLOT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(m_plot, n_plot, p);
if tx_i <=2
    f = data.xdr_1(tx_i,:);
else
    f = data.xdr_2(tx_i,:);
end
plot(f); hold on;
plot(data.echo_i(tx_i), f(data.echo_i(tx_i)),'b*');
title('Raw Data');
xlabel('t (us)');
p = p+1;

% Correlation %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(m_plot, n_plot, p);
[c, lags] = xcorr(f, xcorr_signal(tx_i,:));
hilbert_c = abs(hilbert(c));
u = mean(hilbert_c); sig = std(hilbert_c);    
minPeakHeight = u + 1.5*sig;
minPeakProminence = 0.15 * max(hilbert_c);  
[pks, locs] = findpeaks(hilbert_c,'MinPeakHeight',minPeakHeight,'MinPeakProminence',minPeakProminence);
plot(lags, hilbert_c); hold on; 
for i = 1:length(pks)
    plot(lags(locs(i)),pks(i),'r*'); hold on;
end
[~, ind] = min(abs(lags-data.echo_i(tx_i)));
plot(data.echo_i(tx_i), hilbert_c(ind),'b*');

set(h,'Position',[10 100 1200 500])
axesHandles = findobj(get(h,'Children'), 'flat','Type','axes');
% axis(axesHandles,'square')
makeFigureBig(h);

