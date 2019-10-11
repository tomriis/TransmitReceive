function N_dimensional_scan(RData)
    Resource = evalin('base','Resource');
    
    app = Resource.Parameters.app;
    disp('N ---------------')
    positions = Resource.Parameters.positions;
    next_pos = Resource.Parameters.position_index + 1;
    d_steps = move_positioner(app, positions(Resource.Parameters.position_index,:),positions(next_pos,:));
    
    disp('N ---------------')
    disp(['On position: ', num2str(next_pos),' of ', num2str(size(positions,1))]);
    Resource.Parameters.position_index = next_pos;
    Resource.Parameters.app.position_steps(end+1,:) = d_steps;
    assignin('base','Resource',Resource);
end