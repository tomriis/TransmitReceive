function stepper_motor_inc(steps, connected_arduino, dir_pin, step_pin, clockwise_flag, varargin)

    if ~isempty(varargin)
        pulse_duration = varargin{1};
    else
        pulse_duration = 1000;
    end

    fprintf(connected_arduino,'%s\n',strcat([num2str(steps),',',num2str(dir_pin),',',...,
        num2str(step_pin),',',num2str(clockwise_flag),',',num2str(pulse_duration)]));
end