
function TB6600StepperDriver()

delete(instrfind);   %delete any previously setup communication
connectedArduino = arduino();
stepPin = 'D5'; 
dirPin = 'D2'; 
enPin = 'D8';


writeDigitalPin(connectedArduino, enPin, 0);

for i = 1:20
    stepper_motor_inc(connectedArduino, dirPin, stepPin, 1);
end


end

function stepper_motor_inc(connected_arduino, dir_pin, step_pin, clockwise_flag)
    if clockwise_flag
        writeDigitalPin(connected_arduino, dir_pin, 1);
    else
        writeDigitalPin(connected_arduino, dir_pin, 0);
    end
    for i = 1:4
        writeDigitalPin(connected_arduino, step_pin, 1);
        pause(0.005);
        writeDigitalPin(connected_arduino, step_pin, 0);
        pause(0.005);
    end
end