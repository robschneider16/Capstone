function Destination = MoveArmJoints(ql, qd)
    format longE
    %Continuous Servo = 0 for stop, Home = 1475, 1700 and 1260 are the approx 
    %high and low ends.MUST COMPUTE THIS EMPERICALLY
    rate = 600; %deg/sec MUST COMPUTE THIS EMPERICALLY
    HighLine = 1550;    %MUST COMPUTE THIS EMPERICALLY
    LowLine = 1430;     %MUST COMPUTE THIS EMPERICALLY
    t01 = (ql(1) - qd(1))/rate;
    t61 = (ql(6) - qd(6))/rate;
    
    if abs(t01) > abs(t61)
       t1 = abs(t61);
       t2 = abs(t01) - abs(t61);
       c1 = 5;
       c2 = 0;
    else
       t1 = abs(t01);
       t2 = abs(t61) - abs(t01);
       c1 = 0;
       c2 = 5;
    end
   
    ss0 = HighLine;
    ss5 = HighLine;
    if t01 <= 0
        ss0 = LowLine;
    end
    if t61 <= 0
        ss5 = LowLine;
    end
   
    MoveServo(1, deg2ss(qd(2)));
    MoveServo(2, deg2ss(qd(3)));
    MoveServo(3, deg2ss(qd(4)));
    MoveServo(4, deg2ss(qd(5)));
    MoveServo(0, ss0);
    MoveServo(5, ss5);
    pause(t1);
    MoveServo(c1, 0);
    pause(t2);
    MoveServo(c2, 0);
    Destination = qd;