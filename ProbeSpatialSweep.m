function ProbeSpatialSweep(frequency)
    lib = loadSoniqLibrary();
    openSoniq(lib);
    set_oscope_parameters(lib)
    [axis,positions] = verasonics_3d_scan(lib,[7,-94,91.5],[7,-94,91.5],[4,1,1]);
    n_positions = length(positions);
    max_positions_per_scan = 500;
    n_scans = floor(n_positions/max_positions_per_scan);
    
    for i = 1:n_scans
        idx = (i-1)*max_positions_per_scan + 1;
        movePositionerAbs(lib, axis(1), positions(idx, 1));
        movePositionerAbs(lib, axis(2), positions(idx, 2));
        movePositionerAbs(lib, axis(3), positions(idx, 3));
        current_positions = positions(idx:idx+max_positions_per_scan-1,:);
        disp(['On ',num2str(idx),' of ', num2str(n_positions)]);
        LinearArray3DScan(current_positions, lib);
    end
    if n_scans == 0
        LinearArray3DScan(positions, lib);
    else
    idx = idx+max_positions_per_scan;
    if n_positions-idx > 1
        current_positions = positions(idx:end,:);
        LinearArray3DScan(current_positions, lib);
    end
    end
    evalin('base','closeSoniq(lib)');

end
