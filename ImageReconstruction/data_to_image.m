function [V, data] = data_to_image(data, Nx, Ny, Nz, N_data, L, xcorr_signal, tx_i)
    V = zeros(Nx,Ny,Nz);
    p = get_unique_positions(data);
    N = [Nx, Ny, Nz];
    XYZ = cell(1,3);
    for i = 1:3
        XYZ{i} = linspace(min(p{i}), max(p{i}),N(i));
    end

    for i = 1:length(data)
        ijk = coordinates_to_index(XYZ, data(i).v_xyz);
        [V, d, d_ijk, line_ijk] = add_data_to_grid(ijk, data(i), XYZ, V, N_data, L, xcorr_signal, tx_i);
      
        data(i).echo_i = d;
        data(i).echo_ijk = d_ijk;
        data(i).line_ijk = line_ijk;
        data.tx_i = tx_i;
        if mod(i, 1000)==0
            disp(['On ', num2str(i), ' of ', num2str(length(data))]);
        end
    end

end