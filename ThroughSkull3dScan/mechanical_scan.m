function mechanical_scan(app)
    dx = app.ND_scan.stop-app.ND_scan.start;
    output_filename_base=['C:\\','\scan_',num2str(dx(1)),'_',num2str(dx(2)),'_',num2str(dx(3)),'_'];
    positions = app.ND_scan.positions;
    n_positions = size(positions, 1);
    max_positions_per_scan = 500;
    n_scans = floor(n_positions/max_positions_per_scan);
    disp([num2str(n_scans), ' of ', num2str(max_positions_per_scan),' positions']);
    last_position = positions(1,:);
    for i = 1:n_scans
        idx = (i-1)*max_positions_per_scan + 1;
        move_positioner(app, last_position, positions(idx, 1));
        current_positions = positions(idx:idx+max_positions_per_scan-1,:);
        disp(['On ',num2str(idx),' of ', num2str(n_positions)]);
        TxRx_mechanical_scan(current_positions, app);
        last_postion = current_positions(end,:);
        output_file_name = [output_filename_base,num2str(idx)];
        evalin('base', sprintf('save(''%s'')', output_file_name));
    end
    if n_scans == 0
        TxRx_mechanical_scan(positions, app);
        output_file_name = [output_filename_base,num2str(1)];
        evalin('base', sprintf('save(''%s'')', output_file_name));
    else
    idx = idx+max_positions_per_scan;
            if n_positions-idx > 1
                move_positioner(app, last_position, positions(idx, 1));
                current_positions = positions(idx:end,:);
                TxRx_mechanical_scan(current_positions, app);
                output_file_name = [output_filename_base,num2str(idx)];
                evalin('base', sprintf('save(''%s'')', output_file_name));
            end
    end

end

end