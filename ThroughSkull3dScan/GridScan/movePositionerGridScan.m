function movePositionerGridScan(RData)
    Resource = evalin('base','Resource');
    app = Resource.Parameters.app;
    disp('N ---------------')
    positions = Resource.Parameters.positions;
    next_pos = Resource.Parameters.position_index + 1;
    if next_pos > size(positions,1)
        VSXquit;
        VsClose;    
    else
        d_steps = move_positioner(app, positions(Resource.Parameters.position_index,:),positions(next_pos,:),0);
        Resource.Parameters.app.position_steps(end+1,:) = d_steps;
        disp('N ---')
        disp(['On position: ', num2str(next_pos),' of ', num2str(size(positions,1))]);
    end
    
    Resource.Parameters.position_index = next_pos;
    
    assignin('base','Resource',Resource);
return