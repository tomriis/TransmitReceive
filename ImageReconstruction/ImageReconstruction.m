data_directory = 'C:\Users\Tom\Documents\MATLAB\2DScan4\';
Receive = evalin('base','Receive');
fs = Receive(1).ADCRate*1e6/Receive(1).decimFactor;
volume_center_length = 12;
Z_lower_bound = 36;
innerRadius = 17;

[all_data] = get_2D_scan_data(data_directory,fs);

data = sort_and_scale_data(all_data);

c_data = slice_data(data);

V = data_to_image(c_data);

V1 = zero_volume_center(V, volume_center_length);

V1 = zero_upper_edge(V1, Z_lower_bound, innerRadius);

%niftiwrite(V,'C:\Users\Tom\Documents\MATLAB\Harisonics1.nii');