function ShowImageProcessing(data)
h = figure; 
m_plot = 3;
n_plot = 4;
p = 1;
all_data = evalin('base','all_data');
x1 = evalin('base','x1'); x2 = evalin('base','x2');
fs = evalin('base','fs');

Ns = length(all_data(1).xdr_1);
t= (1/fs:1/fs:(Ns*1/fs))*1e6;
x = (1:Ns)*1540e3/fs/2/10; %cm

%subplot(m_plot, n_plot, p);
f_rx = data.rx;

f = data.tx;
% f_rx(1:50)=0; f(1:50)=0;
plot(t, f,'DisplayName','Tx'); hold on;
plot(t,f_rx,'DisplayName','Rx');
title('Windowed');
xlabel('t (us)');
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
