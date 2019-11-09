function d_steps = move_positioner(app, current_pos,next_pos, varargin)
    rate = 0.008;
    d_steps = round((next_pos-current_pos)./app.scale);
    disp(num2str(d_steps));
    
    pins = {{app.x_dir_pin, app.x_step_pin};
            {app.y_dir_pin, app.y_step_pin};
            {app.theta_dir_pin, app.theta_step_pin}};
    order= 1:3;
    if ~isempty(varargin)
        try
            if varargin{2} == 3
                order = 3:-1:1;
            end
        catch
        end
    end
                
    for i = order
        if i == 3
            stepper_motor_inc(abs(d_steps(i)),app.connected_arduino, pins{i}{1}, pins{i}{2}, d_steps(i)>0, 10000);
        elseif i == 2
%              stepper_motor_inc(0,app.connected_arduino, 1, 1, 0, 0);
            stepper_motor_inc(abs(d_steps(i)),app.connected_arduino, pins{i}{1}, pins{i}{2}, d_steps(i)>0, 50000);
%             stepper_motor_inc(0,app.connected_arduino, 0, 0, 0, 0);
        else
            stepper_motor_inc(abs(d_steps(i)),app.connected_arduino, pins{i}{1}, pins{i}{2}, d_steps(i)>0);
        end
        if ~isempty(varargin)
            pause(varargin{1});
        end
        
    end
    
end

