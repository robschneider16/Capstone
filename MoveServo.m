function MoveServo(channel, servo_setting)
    
    %initialize the port and device numer. 
    %device is default to 12
    %port is the serial port name, choose the lower number and the CU as
    %the command port. 
    port = '/dev/cu.usbmodem00110401';
    device = 12;
    ser1 = serial(port);
    fopen(ser1);
    ss = servo_setting * 4;

    %servo range values = 2400 - 496 which = 180 degrees.
    %Continuous SErvo = 0 for stop, Home = 1475, 1700 and 1260 are the approx 
    %high and low ends. 
    % Format servo command
    lower = bin2dec(regexprep(mat2str(fliplr(bitget(ss, 1:7))), '[^\w'']', ''));
    upper = bin2dec(regexprep(mat2str(fliplr(bitget(ss, 8:14))), '[^\w'']', ''));
    
    % Advanced Serial Protocol
    % 0xAA = 170
    % 4 = action (set target)
    command = [170, device, 4, channel, lower, upper];
    %command = [132, 0, 104, 0];
    
    %send the command to the controller
    fwrite(ser1, command);
    
    % Clean up - NB: On some Mac MATLAB versions, fclose will crash MATLAB
    % If so, you'll need to modify this function to pass in a serial
    % instance, and then never close the port in your own code
    fclose(ser1);
    delete(ser1);
end