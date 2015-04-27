%send movement

function sendMove(a, b, channel)
    
    command = [a, device, b, channel, lower, upper];

    % Simple Serial Protocol
    % 0x84 = 132
    %command = [132, channel, lower, upper];
    
    
    
    % Send the command
    fwrite(ser1, command);
    