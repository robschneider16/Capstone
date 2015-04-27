function ss = deg2ss(deg)
%2400 - 496 which = 180 degrees.
max = 2400; %might need to determine these more precicelsy
min = 496; %might need to determine these more precicelsy
rate = (max - min)/180; %ss pulses/degree
ss = (deg*rate) + min;