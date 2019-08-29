function data_to_image(data)

Nx = 256;
Ny = 256;
Nz = 95;
V = zeros(Nx,Ny,Nz);
positions = get_unique_positions(data);

grid_xyz = 
binned_data = get_binned_data(data_array, N)

niftiwrite(V,'outbrain.nii');