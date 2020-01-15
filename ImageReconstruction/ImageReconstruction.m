name = '3DScan11';
data_directory = ['C:\Users\Tom\Documents\MATLAB\', name, 'Beaker\'];
control_data_directory = ['C:\Users\Tom\Documents\MATLAB\',name,'Control','\'];

Receive = load([data_directory,'Parameters\','parameters.mat'],'Receive');
Resource = load([data_directory,'Parameters\','parameters.mat'],'Resource');
Receive = Receive.Receive; Resource = Resource.Resource;
scale_mm_per_voxel = 0.5;
c= Resource.Parameters.speedOfSound;
fs = Receive(1).ADCRate*1e6/Receive(1).decimFactor;
TxEvents = 4;%Resource.Parameters.TxEvents; 
NA = 20;%Resource.Parameters.NA/TxEvents;

data = get2DScanData(data_directory, fs, TxEvents, NA);
control_data = get2DScanData(control_data_directory, fs, TxEvents, NA);

nSamples = length(data(1).xdr_1);
if 1
    [xcorr_window(1), xcorr_window(2)] = getTxRxWindow(control_data(1).xdr_1(4,:), control_data(1).xdr_2(1,:), 4, 1);
else
    xcorr_window = [4966, 5491];
end

nSamples = length(data(1).xdr_1);
for i = 1:TxEvents
    if i <= TxEvents/2
        xcorr_signal_i = control_data(1).xdr_2(i,xcorr_window(1):xcorr_window(2));
        xcorr_signal(i,:) = horzcat(xcorr_signal_i, zeros(1, nSamples - length(xcorr_signal_i)));
    else
        xcorr_signal_i = control_data(1).xdr_1(i,xcorr_window(1):xcorr_window(2));
        xcorr_signal(i,:) = horzcat(xcorr_signal_i, zeros(1, nSamples - length(xcorr_signal_i)));
    end
end


L = getTransducerSeparation(control_data, xcorr_signal, fs, c); %296
% Correct the speed of sound based on measured distance.
measured_L = 296;
c = c*measured_L/L;
L = measured_L;
offset = -5/2;
data = set_data_xyz_position(data, L/2,-5/2);%-5/2
random_i = randi(length(data),10,1);
[x1, x2] = getTxRxWindow(data(random_i), data(random_i), 1, 3);

c_data = zero_data(data, x1, x2);
c_control_data = zero_data(control_data, x1, x2);
for i = 1:length(c_data)
    c_data(i).c = c;
    c_data(i).L = L;
    c_data(i).offset = offset;
end

[c_data, N] = data_to_image(c_data(1:length(c_data)), xcorr_signal, L, fs, c, scale_mm_per_voxel);

V_1 = zeros(N);
tx = [2,4];
c_data_1 = c_data(1:length(c_data)/2);
for i = 1:length(c_data_1)
    echo_ijk = c_data(i).echo_ijk;
    for j = 1:length(tx)
        V_1(echo_ijk(tx(j),1), echo_ijk(tx(j),2), echo_ijk(tx(j),3))=1;
    end
end

V_2 = zeros(N);
tx = [2,4];
c_data_2 = c_data(length(c_data)/2:length(c_data));
for i = length(c_data_2):length(c_data)
    echo_ijk = c_data(i).echo_ijk;
    for j = 1:length(tx)
        V_2(echo_ijk(tx(j),1), echo_ijk(tx(j),2), echo_ijk(tx(j),3))=1;
    end
end

% niftiwrite(demo2,'C:\Users\Tom\Documents\MATLAB\V301demo2.nii');