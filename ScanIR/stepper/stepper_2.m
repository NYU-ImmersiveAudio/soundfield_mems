%% connect
a = arduino('/dev/tty.usbmodem1421', 'Uno', 'Libraries', 'Adafruit\MotorShieldV2');

%% initialize
shield = addon(a, 'Adafruit\MotorShieldV2');
addrs = scanI2CBus(a, 0);
sm = stepper(shield, 2, 200, 'stepType', 'Single');
sm.RPM = 100;


%% step once
steps = 2;
move(sm, steps);
release(sm); 