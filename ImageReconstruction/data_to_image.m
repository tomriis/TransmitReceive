function [V, data] = data_to_image(data, Nx, Ny, Nz, N_data, L, xcorr_signal)
    V = zeros(Nx,Ny,Nz);
    p = get_unique_positions(data);
    N = [Nx, Ny, Nz];
    XYZ = cell(1,3);
    for i = 1:3
        XYZ{i} = linspace(min(p{i}), max(p{i}),N(i));
    end

    for i = 1:length(data)
        ijk = coordinates_to_index(XYZ, data(i).v_xyz);
        [V2, d, d_ijk] = add_data_to_grid(ijk, data(i), XYZ, V, N_data, L, xcorr_signal);
        data(i).echo_i = d;
        data(i).echo_ijk = d_ijk;
        V = V + V2;
        if mod(i, 1000)==0
            disp(['On ', num2str(i), ' of ', num2str(length(data))]);
        end
    end

end