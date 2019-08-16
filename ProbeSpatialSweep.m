function ProbeSpatialSweep()
    pos = {[0 0 23], [10 0 23]};
    
    for kk = 1:2
    try
    lib = loadSoniqLibrary();
    openSoniq(lib);
    set_oscope_parameters(lib)
    [axis,positions] = verasonics_3d_scan(lib,[17,1,1],[43,40,1],[68,100,1]);
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
        LinearArray3DScan(current_positions, lib,'file_name',scans{kk},...,
            'target_position',pos{kk});
    end
    idx = idx+max_positions_per_scan+1;
    if n_positions-idx > 1
        current_positions = positions(idx:end,:);
        LinearArray3DScan(current_positions, lib);
    end
    catch e
        disp(e.message);
        exit
    end

end