%%% The procedure is used to open the Leica Vibratome or to close it. 
%%% Run this program to open the vibratome, run it again, the vibratome will be closed.
% VibratomePort=handles.my.LeicaVibratome;
% fopen(VibratomePort); 
% fwrite(VibratomePort,'s');%digitalWrite(pin, 1);
% pause(0.1)
% fwrite(VibratomePort,'c');%digitalWrite(pin, 0);
% fclose(VibratomePort);
VibratomePort=handles.my.LeicaVibratome;

try
  fopen(VibratomePort);
  fwrite(VibratomePort,'s');
catch
  fclose(VibratomePort);
  fopen(VibratomePort);
  fwrite(VibratomePort,'s');
end
pause(0.1)

try
   fwrite(VibratomePort,'c');%digitalWrite(pin, 0);
   fclose(VibratomePort);
catch
   fclose(VibratomePort);
   fopen(VibratomePort);
   fwrite(VibratomePort,'c');
   fclose(VibratomePort);
end