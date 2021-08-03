
%% Inatialization
SZX2=a.Focus

port = 'COM2';
SZX2 = serial(port,'BaudRate', 19200,'Parity', 'even','StopBits', 2.0);
fopen(SZX2);
%% LOG in or out
fprintf(SZX2, '%s\r\n', '3LOG IN');
pause(1);
Login = fscanf(SZX2)

fprintf(SZX2, '%s\r\n', '3LOG OUT');
pause(1);
Login = fscanf(SZX2)
%%  Read Positon
%fgetl_ = @(s)char(fread(s,s.BytesAvailable));
fgetl_ = @(SZX2)char(fread(SZX2,SZX2.BytesAvailable));
if SZX2.BytesAvailable;fgetl_(SZX2);end
fprintf(SZX2, '%s\r\n', '3FCPOS?');
while ~SZX2.BytesAvailable;end
pos = split(fgetl_(SZX2)',' ');
pos = str2double(pos(end));
disp(pos);
%% Moves the focusing
fprintf(SZX2, '%s\r\n', '3FCL N,11196');
fprintf(SZX2, '%s\r\n', '3FCL N,400');
fprintf(SZX2, '%s\r\n', '3FCL N,13638');% Moves the focusing in low speed
fprintf(SZX2, '%s\r\n', '3FCH N,80');% Moves the focusing in high speed
fprintf(SZX2, '%s\r\n', '3FCH F,80');

fprintf(SZX2, '%s\r\n', '3FCSETPOS 0');% Sets the focusing position
fprintf(SZX2, '%s\r\n', 'FCSTOP');% Stop the focusing

%% Close
fclose(SZX2);
