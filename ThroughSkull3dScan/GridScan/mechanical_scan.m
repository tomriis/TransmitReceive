function app = mechanical_scan(app)
    output_param_dir = [app.output_file_dir,'\Parameters\'];
    output_filename_param = [output_param_dir, 'parameters.mat'];
    positions = app.ND_scan.positions;
    
    TxRx_mechanical_scan(positions, app);

    Resource = evalin('base','Resource');
    app.position_steps = Resource.Parameters.app.position_steps; 
    if ~exist(output_param_dir, 'dir')
        mkdir(output_param_dir)
    end
    evalin('base', sprintf('save(''%s'', ''Resource'',''Receive'')', output_filename_param));
end
