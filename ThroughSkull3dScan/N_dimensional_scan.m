function N_dimensional_scan(RData)
    Resource = evalin('base','Resource');
    
    app = Resource.Parameters.app;
    
    positions = Resource.Parameters.positions;
    next_pos = Resource.Parameters.position_index + 1;
%     if next_pos > Resource.RcvBuffer(1).numFrames
%         VsClose;
%     else
    move_positioner(app, positions(Resource.Parameters.position_index,:),positions(next_pos,:))
%     end
    disp(['On position: ', num2str(next_pos),' of ', num2str(size(positions,1))]);
    Resource.Parameters.position_index = next_pos;
    assignin('base','Resource',Resource);
end