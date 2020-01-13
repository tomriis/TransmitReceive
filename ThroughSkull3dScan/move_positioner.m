function d_steps = move_positioner(app, current_pos,next_pos, varargin)
    d_steps = round((next_pos-current_pos)./app.scale);
    disp(num2str(d_steps));
    pulse_duration = [1000, 1000, 10000];
    safetyFactor = 1.5;
    
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
            stepper_motor_inc(abs(d_steps(i)),app.connected_arduino, pins{i}{1}, pins{i}{2}, d_steps(i)>0, pulse_duration(i));
        elseif i == 2
%              stepper_motor_inc(0,app.connected_arduino, 1, 1, 0, 0);
            stepper_motor_inc(abs(d_steps(i)),app.connected_arduino, pins{i}{1}, pins{i}{2}, d_steps(i)>0, pulse_duration(i));
%             stepper_motor_inc(0,app.connected_arduino, 0, 0, 0, 0);
        else
            stepper_motor_inc(abs(d_steps(i)),app.connected_arduino, pins{i}{1}, pins{i}{2}, d_steps(i)>0, pulse_duration(i));
        end
        if ~isempty(varargin)
            if (varargin{1}) == 0
                dur = pulse_duration(i)*1e-6*abs(d_steps(i))*2*safetyFactor;
                disp(['Pause for ', num2str(dur)]);
                pause(dur);
                if i == 3 && abs(d_steps(3)>1)
                    pause(3)
                end
            end
            pause(varargin{1});
        end
        
    end
    
end

