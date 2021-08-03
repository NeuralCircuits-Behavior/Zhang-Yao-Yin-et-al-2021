



% open arduino
a=get(0,'UserData');
if isstruct(a)
    if  isfield(a,'ARDUINO')
        ARDUINO=a.ARDUINO;
    else
%         global ARDUINO;
        ARDUINO=serial('COM6');
        set(ARDUINO,'BaudRate',9600);  
        set(ARDUINO,'DataBits',8);
        set(ARDUINO,'StopBits',1); 
        fopen(ARDUINO);
        a.ARDUINO=ARDUINO;
        set(0,'UserData',a);
    end
end


for i=1:20;
    
    
try
  fwrite(ARDUINO,'a');
catch
  fclose(ARDUINO);
  fopen(ARDUINO);
  fwrite(ARDUINO,'a');
end

pause(1);


classObj.MoCtrCard_MCrlAxisRelMove(2,-1.222,0.1,0.05);
classObj.MoCtrCard_GetEncoderVal(255, classObj.gbAxisEnc);
PosOri=classObj.gbAxisEnc(3);
TimeConstant=200;
[TimeUsedi,RunTimes]=MoveOrNot(classObj,TimeConstant,PosOri);

  
  try
  fwrite(ARDUINO,'z');
catch
  fclose(ARDUINO);
  fopen(ARDUINO);
  fwrite(ARDUINO,'z');
  end
pause(1);

try
  fwrite(ARDUINO,'a');
catch
  fclose(ARDUINO);
  fopen(ARDUINO);
  fwrite(ARDUINO,'a');
end

pause(1);

classObj.MoCtrCard_MCrlAxisRelMove(2,1.222,0.1,0.05);
classObj.MoCtrCard_GetEncoderVal(255, classObj.gbAxisEnc);
PosOri=classObj.gbAxisEnc(3);
[TimeUsedi,RunTimes]=MoveOrNot(classObj,TimeConstant,PosOri);
  
  try
  fwrite(ARDUINO,'z');
catch
  fclose(ARDUINO);
  fopen(ARDUINO);
  fwrite(ARDUINO,'z');
  end
pause(1);
end
























