data_directory = 'C:\Users\Tom\Documents\MATLAB\2DScan4\';
Receive = evalin('base','Receive');
Resource = evalin('base','Resource');
scale_mm_per_voxel = 1;
c= Resource.Parameters.speedOfSound;
fs = Receive(1).ADCRate*1e6/Receive(1).decimFactor;
volume_center_length = 12;
Z_lower_bound = 36;
innerRadius = 17;

[all_data] = get_2D_scan_data(data_directory,fs);

L = 234; %[mm] length of arm 
data = set_data_xyz_position(all_data, L/2);

x1 = 600;
x2 = 2550;
c_data = zero_data(data,x1, x2);

data_length_mm = length(c_data(1).tx)*1/fs*c*1000/2;
N_data = round(1/scale_mm_per_voxel*data_length_mm);
Nx = round(1/scale_mm_per_voxel*L);
Ny = round(1/scale_mm_per_voxel*L);
p = get_unique_positions(c_data);
Nz = round(1/scale_mm_per_voxel*max(p{3}));

% V = data_to_image(c_data, Nx, Ny, Nz, N_data);
% 
% V1 = zero_volume_center(V, volume_center_length);
% 
% V1 = zero_upper_edge(V1, Z_lower_bound, innerRadius);

% niftiwrite(demo2,'C:\Users\Tom\Documents\MATLAB\V301demo2.nii');