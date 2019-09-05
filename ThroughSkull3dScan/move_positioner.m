function move_positioner(app, current_pos,next_pos)
    rate = 0.008;
    d_steps = round((next_pos-current_pos)./app.scale);
    disp(num2str(d_steps));
    
    pins = {{app.x_dir_pin, app.x_step_pin};
            {app.y_dir_pin, app.y_step_pin};
            {app.theta_dir_pin, app.theta_step_pin}};
        
    for i = 1:3
        if i == 3
            stepper_motor_inc(abs(d_steps(i)),app.connected_arduino, pins{i}{1}, pins{i}{2}, d_steps(i)>0, 15000);
        else
            stepper_motor_inc(abs(d_steps(i)),app.connected_arduino, pins{i}{1}, pins{i}{2}, d_steps(i)>0);
        end
        %pause(abs(d_steps(i))*rate);
    end
    
end

