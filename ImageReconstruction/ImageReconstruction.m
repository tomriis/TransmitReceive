name = '2DScan9Taylor';
data_directory = ['C:\Users\Tom\Documents\MATLAB\', name, '\'];
control_data_directory = [data_directory,name,'Control','\'];

Receive = load([data_directory,'Parameters\','parameters.mat'],'Receive');
Resource = load([data_directory,'Parameters\','parameters.mat'],'Resource');
Receive = Receive.Receive; Resource = Resource.Resource;
scale_mm_per_voxel = 0.75;
c= Resource.Parameters.speedOfSound;
fs = Receive(1).ADCRate*1e6/Receive(1).decimFactor;
TxEvents = Resource.Parameters.TxEvents; 
NA = Resource.Parameters.NA/TxEvents;

data = get2DScanData(data_directory, fs, TxEvents, NA);
control_data = get2DScanData(control_data_directory, fs, TxEvents, NA);

nSamples = length(data(1).xdr_1);
if 1
    [xcorr_window(1), xcorr_window(2)] = getRxWindow(control_data(1).xdr_1(4,:), control_data(1).xdr_2(1,:));
else
    xcorr_window = [3842, 4628];
end

for i = 1:TxEvents
    if i <= TxEvents/2
        xcorr_signal_i = control_data(1).xdr_2(i,xcorr_window(1):xcorr_window(2));
        xcorr_signal(i,:) = horzcat(xcorr_signal_i, zeros(1, nSamples - length(xcorr_signal_i)));
    else
        xcorr_signal_i = control_data(1).xdr_1(i,xcorr_window(1):xcorr_window(2));
        xcorr_signal(i,:) = horzcat(xcorr_signal_i, zeros(1, nSamples - length(xcorr_signal_i)));
    end
end

L = getTransducerSeparation(control_data, xcorr_signal, fs, c);

data = set_data_xyz_position(data, L/2);

x1 = 600; x2 = xcorr_window(2);
c_data = zero_data(data, x1, x2);
c_control_data = zero_data(control_data, x1, x2);

[c_data, N] = data_to_image(c_data, xcorr_signal, L, fs, c, scale_mm_per_voxel);

V = zeros(N);
tx = [2,4];
for i = 1:length(c_data)
    echo_ijk = c_data(i).echo_ijk;
    for j = 1:length(tx)
        V(echo_ijk(tx(j),1), echo_ijk(tx(j),2), echo_ijk(tx(j),3))=1;
    end
end

% niftiwrite(demo2,'C:\Users\Tom\Documents\MATLAB\V301demo2.nii');