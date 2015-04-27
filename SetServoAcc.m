function SetServoAcc(c, ss)


    port = '/dev/cu.usbmodem00110401';
    ser1 = serial(port);
    fopen(ser1);
    lower = bin2dec(regexprep(mat2str(fliplr(bitget(ss, 1:7))), '[^\w'']', ''));
    upper = bin2dec(regexprep(mat2str(fliplr(bitget(ss, 8:14))), '[^\w'']', ''));
    command = [137, c, lower, upper];
    %send the command to the controller
    fwrite(ser1, command);
    fclose(ser1);
    delete(ser1);