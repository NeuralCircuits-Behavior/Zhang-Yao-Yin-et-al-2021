%% Arduino 'COM25'   
% ArduinoProgram:
% C:\Users\Administrator\Desktop\GratingRulerTriggerCamera_modify_NeedAandInternativeAcquisition\GratingRulerTriggerCamera_modify_ML2
global ARDUINO;
ARDUINO=serial('COM25');
set(ARDUINO,'BaudRate',9600);  
set(ARDUINO,'DataBits',8);
set(ARDUINO,'StopBits',1); 
fopen(ARDUINO); 

fwrite(ARDUINO,'a');%digitalWrite(pin, 1);
% pause(0.1)
 fwrite(ARDUINO,'z');%digitalWrite(pin, 0);
fclose(ARDUINO);

% global Port;
% fwrite(ARDUINO,'s');% both fwrite and fprintf are okay.