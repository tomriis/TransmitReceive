name = '2DScan6';
data_directory = ['C:\Users\Tom\Documents\MATLAB\', name, '\'];
control_data_directory = [data_directory,name,'control','\'];

Receive = evalin('base','Receive');
Resource = evalin('base','Resource');
scale_mm_per_voxel = 1;
c= Resource.Parameters.speedOfSound;
fs = Receive(1).ADCRate*1e6/Receive(1).decimFactor;
volume_center_length = 12;
Z_lower_bound = 36;
innerRadius = 17;

data = get_2D_scan_data(data_directory,fs);
control_data = get_2D_scan_data(control_data_directory, fs);

L = 234; %[mm] length of arm 
data = set_data_xyz_position(data, L/2);
nSamples = length(data(1).xdr_1);
if 1 
    [xcorr_window(1), xcorr_window(2)] = getRxWindow(zeros(1,nSamples), control_data(1).xdr_2(1,:));
else
    xcorr_window = [3098, 3522];
end

x1 = 600; x2 = xcorr_window(2);
c_data = zero_data(data, x1, x2);
c_control_data = zero_data(control_data, x1, x2);

xcorr_signal = c_control_data(1).xdr_2(:,xcorr_window(1):xcorr_window(2));
xcorr_signal = horzcat(xcorr_signal, zeros(2, nSamples - length(xcorr_signal)));

data_length_mm = nSamples*1/fs*c*1000/2;
x_axis = (1:nSamples)*1/fs*c*1000/2;
N_data = round(1/scale_mm_per_voxel*data_length_mm);
Nx = round(1/scale_mm_per_voxel*L);
Ny = round(1/scale_mm_per_voxel*L);
p = get_unique_positions(c_data);
Nz = round(1/scale_mm_per_voxel*max(p{3}));

[Vcorr2, c_data] = data_to_image(c_data, Nx, Ny, Nz, N_data, L, xcorr_signal);


% V1 = zero_volume_center(V, volume_center_length);
% 
% V1 = zero_upper_edge(V1, Z_lower_bound, innerRadius);

% niftiwrite(demo2,'C:\Users\Tom\Documents\MATLAB\V301demo2.nii');