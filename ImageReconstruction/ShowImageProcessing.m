i = 99;
N = 138;
data_directory = 'C:\Users\Tom\Documents\MATLAB\2DScan4\';
Files=dir([char(data_directory),'*','.mat']);
S = load([Files(2).folder,'\',Files(2).name]);
n_positions = size(S.data.positions,1);
count = 1; all_data = struct();
    d = designfilt('lowpassiir','FilterOrder',8, ...
         'PassbandFrequency',700e3,'PassbandRipple',0.2, ...
         'SampleRate',fs);
     

h = figure; 
m_plot = 3;
n_plot = 4;
p = 1;

f = S.data.tx_data(1, :, i);
t= (1/fs:1/fs:(length(f)*1/fs));
x = (1:length(f))*1540e3/fs; %mm
subplot(m_plot, n_plot, p);
plot(f);
title('Raw Data');
p = p+1;
for k = 1:n_positions 
    for j = 1:15
        S.data.tx_data(j, :, k) = filtfilt(d, S.data.tx_data(j, :, k));
        S.data.rx_data(j, :, k) = filtfilt(d, S.data.rx_data(j, :, k));
    end
    xdr_1 = mean(S.data.tx_data(1 : 15, :, k), 1);
    xdr_2 = mean(S.data.rx_data(1 : 15, :, k), 1);
    all_data(count).xdr_1(1,:) = xdr_1;
    all_data(count).xdr_2(1,:) = xdr_2;
    all_data(count).position = S.data.positions(k,:); 
    count = count + 1;
end
cut_n = 25;
subplot(m_plot, n_plot, p);
f = S.data.tx_data(1, :, i);
f(1:cut_n) = 0;
plot(x, f);
title('Low Pass Filtered');
p = p+1;

subplot(m_plot, n_plot, p);
f=all_data(i).xdr_1;
f(1:cut_n) = 0;
plot(x, f);
title('Averaged Waveforms N = 15');
p = p+1;

data = sort_and_scale_data(all_data);
c_data = slice_data(data);
x = slice_data(x);
subplot(m_plot, n_plot, p);
f = c_data(i).tx;
plot(x, f);
title('Windowed');
p=p+1;
  
f = abs(hilbert(f));
subplot(m_plot, n_plot, p);
plot(x, f);
title('Hilbert Transform');
p=p+1;

f = get_binned_data(f, N);
x = get_binned_data(x, N);
subplot(m_plot, n_plot, p);
plot(x, f);
title('Down Sample Via Moving Average')
p = p+1;

f_std = std(f);
f(f<2.5*f_std) = 0;
subplot(m_plot, n_plot, p);
plot(x, f);
title('Threshold Data < 2 Std')
p = p+1;

subplot(m_plot, n_plot, p);
f(f>0)= log(f(f>0));
plot(x, f);
title('Log Compression')
p = p+1;

[pks,locs] = findpeaks(f);





axesHandles = findobj(get(h,'Children'), 'flat','Type','axes');
axis(axesHandles,'square')
makeFigureBig(h);
% 
% axis square

% i = 200;
% N = 138;
% figure; 
% f = c_data(i).tx;
% subplot(1,6,1);
% plot(f);
% axis square 
% 
%     dlow = designfilt('lowpassiir','FilterOrder',8, ...
%          'PassbandFrequency',550e3,'PassbandRipple',0.2, ...
%          'SampleRate',fs);
%     dhigh = designfilt('highpassiir','FilterOrder',8, ...
%          'PassbandFrequency',450e3,'PassbandRipple',0.2, ...
%          'SampleRate',fs);
%      
% f = filtfilt(dhigh, f);
% subplot(1,6,2);
% plot(f);
% axis square
% 
% 
% f = abs(f);
% subplot(1,6,3);
% plot(f)
% axis square
% 
% f = filtfilt(dlow, f);
% subplot(1,6,4);
% plot(f)
% axis square
% f(end) = 0;
% f = get_binned_data(f, N);
% subplot(1,6,5);
% plot(f);
% axis square
% 
% f_std = std(f);
% f(f<2*f_std) = 0;
% subplot(1,6,6);
% plot(f);
% 
% axis square