function ProbeSpatialSweep(frequency)
    lib = loadSoniqLibrary();
    openSoniq(lib);
    set_oscope_parameters(lib)
    [axis,positions] = verasonics_3d_scan(lib,[-5, -5, 1],[5, 5, 1],[55,55,1]);
    n_positions = length(positions);
    max_positions_per_scan = 400;
    n_scans = floor(n_positions/max_positions_per_scan);
    
    for i = 1:n_scans
        idx = (i-1)*max_positions_per_scan + 1;
        movePositionerAbs(lib, axis(1), positions(idx, 1));
        movePositionerAbs(lib, axis(2), positions(idx, 2));
        movePositionerAbs(lib, axis(3), positions(idx, 3));
        current_positions = positions(idx:idx+max_positions_per_scan-1,:);
        disp(['On ',num2str(idx),' of ', num2str(n_positions)]);
        %LinearArray3DScan(current_positions, lib);
        VerasonicsHydrophone3DScan(current_positions, lib, 'frequency', frequency)
    end
    if n_scans == 0
        %LinearArray3DScan(positions, lib);
        VerasonicsHydrophone3DScan(positions, lib, 'frequency', frequency)
    else
    idx = idx+max_positions_per_scan;
    if n_positions-idx > 1
        current_positions = positions(idx:end,:);
        %LinearArray3DScan(current_positions, lib);
        VerasonicsHydrophone3DScan(current_positions, lib, 'frequency', frequency)
    end
    end
    evalin('base','closeSoniq(lib)');

end
