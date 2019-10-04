function ShowImageProcessing(data)
h = figure; 
m_plot = 3;
n_plot = 4;
p = 1;
all_data = evalin('base','all_data');
x1 = evalin('base','x1'); x2 = evalin('base','x2');
fs = evalin('base','fs');

Ns = length(all_data(1).xdr_1);
t= (1/fs:1/fs:(Ns*1/fs));
x = (1:Ns)*1540e3/fs/2/10; %cm

%subplot(m_plot, n_plot, p);

f = data.tx;
disp(length(x))
disp(length(f))
plot(x, f);
title('Windowed');
xlabel('x (cm)');
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
