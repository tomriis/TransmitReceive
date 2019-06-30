
function TB6600StepperDriver()

delete(instrfind);   %delete any previously setup communication
connectedArduino = arduino();
stepPin = 'D5'; 
dirPin = 'D2'; 
enPin = 'D8';


writeDigitalPin(connectedArduino, enPin, 0);

stepper_motor_inc(200,connectedArduino, dirPin, stepPin, 1);


end

