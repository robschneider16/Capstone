function MoveContinuousServo(curDegree, destDegree, channel)
    format longE
    %Continuous SErvo = 0 for stop, Home = 1475, 1700 and 1260 are the approx 
    %high and low ends.
    Rate = 3; %deg/sec MUST COMPUTE THIS EMPERICALLY
    time = (destDegree - curDegree)/rate;
    ss = 1700;
    if time <= 0
        ss = 1260;
    end
    MoveServo(channel, ss);
    pause(abs(t));
    MoveServo(channel, 0);
end








