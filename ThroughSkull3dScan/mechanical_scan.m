function mechanical_scan(app)
    dx = app.ND_scan.stop-app.ND_scan.start;
    output_filename_base=['C:\Users\Verasonics\Documents\VerasonicsScanFiles\MechanicalScan\2DScan5\e',...,
        '2Dscan_',num2str(dx(1)),'_',num2str(dx(2)),'_',num2str(dx(3)),'_'];
    output_file_name_param = [output_filename_base,'parameters','.mat'];
    positions = app.ND_scan.positions;
    n_positions = size(positions, 1);
    max_positions_per_scan = 100;
    n_scans = floor(n_positions/max_positions_per_scan);
    disp([num2str(n_scans), 'scans of ', num2str(max_positions_per_scan),' positions']);
    last_position = positions(1,:);
    failed = struct();
    failed.count = 1;
    for i = 1:n_scans
        idx = (i-1)*max_positions_per_scan + 1;
        d_steps = move_positioner(app, last_position, positions(idx, :));
        app.position_steps(end+1,:) = d_steps;
        current_positions = positions(idx:idx+max_positions_per_scan-1,:);
        disp(['On ',num2str(idx),' of ', num2str(n_positions)]);
        try
        TxRx_mechanical_scan(current_positions, app);
        catch e
            failed(failed.count).position = current_positions;
            disp(e.message);
            failed.count = failed.count +1;
            VsClose;
        end
            
        last_position = current_positions(end,:);
        output_file_name = [output_filename_base,num2str(i)];
        Resource = evalin('base','Resource');
        app.position_steps = Resource.Parameters.app.position_steps;
        evalin('base','TxRx_get_RcvData(RcvData)')
        evalin('base', sprintf('save(''%s'', ''data'')', output_file_name));
        evalin('base', sprintf('save(''%s'', ''Resource.Parameters'')', output_file_name_param));
    end
    if n_scans == 0
        TxRx_mechanical_scan(positions, app);
        output_file_name = [output_filename_base,num2str(1),'.mat'];
        evalin('base','TxRx_get_RcvData(RcvData)')
        evalin('base', sprintf('save(''%s'',''data'')', output_file_name));
    else
    idx = idx+max_positions_per_scan;
            if n_positions-idx > 1
                d_steps = move_positioner(app, last_position, positions(idx, :));
                app.position_steps(end+1,:) = d_steps;
                current_positions = positions(idx:end,:);
                if mod(size(current_positions,1),2)~=0
                    current_positions = current_positions(1:end-1,:);
                end
                TxRx_mechanical_scan(current_positions, app);
                Resource = evalin('base','Resource');
                app.position_steps = Resource.Parameters.app.position_steps;
                output_file_name = [output_filename_base,num2str(i+1),'.mat'];
                evalin('base','TxRx_get_RcvData(RcvData)')
                evalin('base', sprintf('save(''%s'', ''data'')', output_file_name));
            end
    end
    
    evalin('base', sprintf('save(''%s'', ''Resource'')', output_file_name_param));
    save('C:\Users\Verasonics\Documents\MATLAB\n_mechanical_scan.mat');
end
