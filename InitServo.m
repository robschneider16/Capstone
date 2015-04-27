port = '/dev/cu.usbmodem00110403';
device = 12;
servo_setting = 6120;
channel = 0;

% Initialize
ser1 = serial(port);
%set(ser1, 'InputBufferSize', 2048);
%set(ser1, 'BaudRate', 9600);
%set(ser1, 'DataBits', 8);
%set(ser1, 'Parity', 'none');
%set(ser1, 'StopBits', 1);
fopen(ser1);

% Format servo command
lower = bin2dec(regexprep(mat2str(fliplr(bitget(6120, 1:7))), '[^\w'']', ''));
upper = bin2dec(regexprep(mat2str(fliplr(bitget(servo_setting, 8:14))), '[^\w'']', ''));