function ShowImageProcessing(data, c_data)
h = figure; 
m_plot = 2;
n_plot = 2;
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
u = mean(f);
sig = std(f);
[c, lags] = xcorr(f, xcorr_signal(tx_i,:));
fh = abs(hilbert(f));
xcorrh =abs(hilbert(xcorr_signal(tx_i,:)));
[ch, lagsh] = xcorr(fh, xcorrh);
ch = ch(lagsh>0);
lagsh = lagsh(lagsh>0);

c = c(lags>0);
lags = lags(lags>0);
subplot(m_plot, n_plot, p);
plot(t, f,'DisplayName','Tx'); hold on;
corr_marker = zeros(1,nSamples);
corr_marker(data.echo_i) = max(f);

% plot(lags*1/fs*1000,c/max(c)*max(f))
plot(t, corr_marker); hold on;
plot(t,u+sig*ones(size(t)),'DisplayName','Rx');
plot(t,u+2*sig*ones(size(t)),'DisplayName','Rx');
title('Tx Data');
xlabel('t (us)');
legend

p=p+1;
subplot(m_plot, n_plot,p);
hilbert_c = abs(hilbert(c));

plot(hilbert_c/max(hilbert_c),'DisplayName','hilbert C'); hold on;
plot(c/max(c),'DisplayName', 'Original C'); hold on;

[ max_corr_i, mph ] = findMaxCorrelation(data.xdr_1(tx_i,:), xcorr_signal(tx_i,:));
plot(max_corr_i, hilbert_c(max_corr_i)/max(hilbert_c),'b*');
plot(mph*ones(size(c))/max(hilbert_c)); hold on;
p = p+1;





subplot(m_plot, n_plot, p);
plot(t, fh,'DisplayName','Tx'); hold on;
plot(lagsh*1/fs*1e6, (ch/max(ch))*max(fh),'DisplayName','xcorr'); hold on;
[pks, locs] = findpeaks(ch,'MinPeakHeight',0.33*max(ch)); hold on;

xcx = (1:length(xcorrh))*1/fs*1e6;

plot(locs(1)*1/fs*1e6, (pks(1)/max(ch))*max(fh), 'b*'); hold on;
plot(xcx, circshift(xcorrh, locs(1))/max(xcorrh)*max(fh),'DisplayName', 'OrigSignal')
legend;
p=p+1;

subplot(m_plot,n_plot,p);
Nx = 234; Ny = 234; N_data = 159; L = 234;
v = data.v_xyz;
x_end = -v(1);
y_end = v(2)-L*sin(deg2rad(data.position(3)));
z_end = v(3);
im = zeros(Nx, Ny);
for i = 1:length(data.line_ijk)
    im(data.line_ijk(i,1),data.line_ijk(i,2)) = 1;
end
[ max_corr_i ] = findMaxCorrelation(data.xdr_1(tx_i,:), xcorr_signal(tx_i,:));
i = round(max_corr_i/length(data.xdr_1(tx_i,:)) * N_data);

XYZ = evalin('base','XYZ');
scalar = max_corr_i/length(data.xdr_1(tx_i,:));
    echo_xy = v(1:2) + scalar* [x_end-v(1), y_end-v(2)]*159/234;
    echo_ijk = coordinates_to_index(XYZ,[echo_xy, v(3)]);
im(echo_ijk(1), echo_ijk(2)) = 2;   
    
im(data.line_ijk(i,1), data.line_ijk(i,2)) = 2;
imagesc(im);
% xyz = zeros(length(data),3);
% for i = 1:length(c_data)
%     xyz(i,:) = c_data(i).v_xyz;
% end
% plot(xyz(:,2),-xyz(:,1),'b*');hold on;
% plot(data.v_xyz(2), -data.v_xyz(1),'r*');

axesHandles = findobj(get(h,'Children'), 'flat','Type','axes');
% axis(axesHandles,'square')
makeFigureBig(h);
