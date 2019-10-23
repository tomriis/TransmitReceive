function ShowImageProcessing(data)
h = figure; 
m_plot = 3;
n_plot = 4;
p = 1;
tx_i = 2;

fs = evalin('base','fs');
xcorr_signal = evalin('base','xcorr_signal');

nSamples = length(data(1).xdr_1);
t= (1/fs:1/fs:(nSamples*1/fs))*1e6;
x = (1:nSamples)*1540e3/fs/2; %cm

%subplot(m_plot, n_plot, p);
f_rx = data.xdr_1(tx_i,:);

f = data.xdr_1(tx_i,:);

[c, lags] = xcorr(f, xcorr_signal(tx_i,:));
c = c(lags>0);
lags = lags(lags>0);
plot(x, f,'DisplayName','Tx'); hold on;
corr_marker = zeros(1,nSamples);
corr_marker(data.echo_i) = max(f);

plot(lags*1/fs*1000*1540/2,c/max(c)*max(f))
plot(x, corr_marker); hold on;
% plot(x,f_rx,'DisplayName','Rx');
title('Tx Data');
xlabel('x (mm)');
legend
p=p+1;
  
% f = abs(hilbert(f));
% subplot(m_plot, n_plot, p);
% plot(x, f);
% title('Hilbert Transform');
% p=p+1;
% 
% f = get_binned_data(f, N);
% x = get_binned_data(x, N);
% subplot(m_plot, n_plot, p);
% plot(x, f);
% title('Down Sample Via Moving Average')
% p = p+1;
% 
% f_std = std(f);
% f(f<2.5*f_std) = 0;
% subplot(m_plot, n_plot, p);
% plot(x, f);
% title('Threshold Data < 2 Std')
% p = p+1;
% 
% subplot(m_plot, n_plot, p);
% f(f>0)= log(f(f>0));
% plot(x, f);
% title('Log Compression')
% p = p+1;
% 
% [pks,locs] = findpeaks(f);

axesHandles = findobj(get(h,'Children'), 'flat','Type','axes');
axis(axesHandles,'square')
makeFigureBig(h);
