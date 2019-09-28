function V = data_to_image(data, Nx, Ny, Nz, N_data)
    V = zeros(Nx,Ny,Nz);
    p = get_unique_positions(data);
    N = [Nx, Ny, Nz];
    XYZ = cell(1,3);
    for i = 1:3
        XYZ{i} = linspace(min(p{i}), max(p{i}),N(i));
    end

    for i = 1:length(data)
        ijk = coordinates_to_index(XYZ, data(i).v_xyz);
        V = V + add_data_to_grid(ijk, data(i), XYZ, V, N_data);
        if mod(i, 1000)==0
            disp(['On ', num2str(i), ' of ', num2str(length(data))]);
        end
    end

end