function stepper_motor_inc(steps, connected_arduino, dir_pin, step_pin, clockwise_flag)
    if clockwise_flag
        writeDigitalPin(connected_arduino, dir_pin, 1);
    else
        writeDigitalPin(connected_arduino, dir_pin, 0);
    end
    for k = 1:steps
        writeDigitalPin(connected_arduino, step_pin, 1);
        pause(0.005);
        writeDigitalPin(connected_arduino, step_pin, 0);
        pause(0.005);
    end
end