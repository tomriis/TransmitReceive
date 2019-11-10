function app = mechanical_scan(app)
    
    output_filename_base=app.output_filename_base;
    output_file_name_param = [output_filename_base,'parameters','.mat'];
    positions = app.ND_scan.positions;
    
    TxRx_mechanical_scan(positions, app);

    Resource = evalin('base','Resource');
    app.position_steps = Resource.Parameters.app.position_steps;    
    evalin('base', sprintf('save(''%s'', ''Resource'',''Receive'')', output_file_name_param));
end
