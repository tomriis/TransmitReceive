function one_dimensional_scan(RData)
    Resource = evalin('base','Resource');
    
    app = Resource.Parameters.app;
    next_pos = Resource.Paramaters.location+1;
    
    steps = app.one_d_scan.step_size_n;
    
%     if next_pos > Resource.RcvBuffer(1).numFrames
%         VsClose;
%     else
        if strcmp(app.one_d_scan.axis,'X')
            stepper_motor_inc(steps, app.connected_arduino, app.x_dir_pin, app.x_step_pin, app.direction);
        elseif strcmp(app.one_d_scan.axis,'Y')
            stepper_motor_inc(steps, app.connected_arduino, app.y_dir_pin, app.y_step_pin, app.direction);
        else
            stepper_motor_inc(steps, app.connected_arduino, app.theta_dir_pin, app.theta_step_pin, app.direction);
        end
%     end
    Resource.Parameters.location = next_pos;
    assignin('base','Resource',Resource);
end