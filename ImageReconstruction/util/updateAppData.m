function app = updateAppData(app, c_data_i, tx_i)
    echo_ijk = app.c_data(c_data_i).echo_ijk(tx_i,:);
    app.data(echo_ijk(1), echo_ijk(2), echo_ijk(3))=0;
    fs = app.fs;
    c = app.c;
    L = app.L;
    scale_mm_per_voxel = app.scale_mm_per_voxel;
    nSamples = length(app.c_data(1).xdr_1);
    data_length_mm = nSamples*1/fs*c*1000/2;
    Nx = round(1/scale_mm_per_voxel*L);
    Ny = round(1/scale_mm_per_voxel*L);
    p = get_unique_positions(app.c_data);
    Nz = round(1/scale_mm_per_voxel*max(p{3}));
    
    N = [Nx, Ny, Nz];
    XYZ = cell(1,3);
    for i = 1:3
        XYZ{i} = linspace(min(p{i}), max(p{i}),N(i));
    end
    
    
    v = app.c_data(c_data_i).v_xyz;
   
    if tx_i <= app.c_data(c_data_i).TxEvents/2
        v0 = v(1,:);
        vEnd = v(2,:);
    else
        v0 = v(2,:);
        vEnd = v(1,:);
    end       
    
    scalar = app.c_data(c_data_i).echo_i(tx_i)/nSamples;
    echo_xyz = v0 + scalar*((vEnd-v0)/L)*data_length_mm;
    echo_ijk = coordinates_to_index(XYZ,echo_xyz);
    app.c_data(c_data_i).echo_ijk(tx_i,:) = echo_ijk;
    
    app.data(echo_ijk(1), echo_ijk(2), echo_ijk(3))=1;
end