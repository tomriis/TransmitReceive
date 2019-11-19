function [data, N] = data_to_image(data, xcorr_signal, L, fs, c, scale_mm_per_voxel)

    data_length_mm = nSamples*1/fs*c*1000/2;
    Nx = round(1/scale_mm_per_voxel*L);
    Ny = round(1/scale_mm_per_voxel*L);
    p = get_unique_positions(c_data);
    Nz = round(1/scale_mm_per_voxel*max(p{3}));

    N = [Nx, Ny, Nz];
    XYZ = cell(1,3);
    for i = 1:3
        XYZ{i} = linspace(min(p{i}), max(p{i}),N(i));
    end

    for i = 1:length(data)
        [d, d_ijk] = add_data_to_grid(data(i), XYZ, L, data_length_mm, xcorr_signal);
        data(i).echo_i = d;
        data(i).echo_ijk = d_ijk;
        if mod(i, 100)==0
            disp(['On ', num2str(i), ' of ', num2str(length(data))]);
        end
    end

end