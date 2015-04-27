%Initialize ServoController

%for wrist and shoulder, they are continuous servos, so target degree much be
%computed based on a saved global variable. I am not sure if they will be
%accurate enough for accurate 

%set accelerations and speed
%144 = get position
%137 for acc
%135 for speed
%132 for set position.

%before MoveServo(0, deg2ss(qd(1)));
%SetServoAcc(0, 5); %range from 1 -> 255, 0 is instant
%SetServoSpeed(0, ); %range from 1 -> 0.25 ?s)/(10 ms),, 0 is closest to instant
SetServoAcc(1, 15); %range from 1 -> 255, 0 is instant
SetServoAcc(2, 15); %range from 1 -> 255, 0 is instant
SetServoAcc(3, 15); %range from 1 -> 255, 0 is instant
SetServoAcc(4, 15); %range from 1 -> 255, 0 is instant
