% Snap a stack of images of single light. Only for left light or right light seperately
% YX, 20170903

if s~=Zstacks
    ZImages=SlicesPerStack;
else
    ZImages=SlicesLastStack;
end

if Zdirection>0
    TranslationZ=TranslationZP;
    TranslationZCon=TranslationZT; 
else
    TranslationZ=TranslationZN;
    TranslationZCon=TranslationZTN;
end

if Ycycle-LeftImaging<j
    SetPulsePalVoltageNew(ColorRight,0); 
    SetPulsePalVoltageNew(ColorLeft,5.4);
    FirstVoltage=VoltageSampledLeftN(1);
    Side=2;
    pause(SleepTime7);
elseif RightImaging>=j
    SetPulsePalVoltageNew(ColorLeft,0); 
    SetPulsePalVoltageNew(ColorRight,10);
    FirstVoltage=VoltageSampledRightN(1);
    Side=1;
    pause(SleepTime7);
end
    

% set first voltage
if Side==1
    SetPulsePalVoltage(1,FirstVoltage);
else
    SetPulsePalVoltage(2,FirstVoltage);
end
j
FirstVoltage

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
        pause(1);
        a.ARDUINO=ARDUINO;
        set(0,'UserData',a);
    end
end


try
  fwrite(ARDUINO,'a');
catch
  fclose(ARDUINO);
  fopen(ARDUINO);
  pause(1);
  fwrite(ARDUINO,'a');
end


    

% classObj.MoCtrCard_MCrlAxisRelMove(2,-1.222,0.1,0.05);

display(['Move' num2str(TranslationZCon)])
classObj.MoCtrCard_MCrlAxisRelMove(2,TranslationZCon,0.1,0.05);
classObj.MoCtrCard_GetEncoderVal(255, classObj.gbAxisEnc);
PosOri=classObj.gbAxisEnc(3);
TimeConstant=200;
[TimeUsedi,RunTimes]=MoveOrNot(classObj,TimeConstant,PosOri);

try
  fwrite(ARDUINO,'z');
catch
  fclose(ARDUINO);
  fopen(ARDUINO);
  pause(1);
  fwrite(ARDUINO,'z');
end



 

% time delay
% SleepMyTime1=1.5;% first move
% SleepMyTime2=15; % move and snap
% SleepMyTime3=3; % return time 


% tell the arduino not to snap
% try
%   fwrite(ARDUINO,'z');
% catch
%   fclose(ARDUINO);
%   fopen(ARDUINO);
%   fwrite(ARDUINO,'z');
% end


% % return
% SnapMoveReturn=Zcut+1;
% classObj.MoCtrCard_MCrlAxisRelMove(2,SnapMoveReturn,1,1);
% pause(SleepMyTime3)
% 
% 
% 
% % first move 
% classObj.MoCtrCard_MCrlAxisRelMove(2,-1,1,1);
% pause(SleepMyTime1)

% tell the arduino to be ready
% try
%   fwrite(ARDUINO,'a');
% catch
%   fclose(ARDUINO);
%   fopen(ARDUINO);
%   fwrite(ARDUINO,'a');
% end
% 
% pause(1);

% move and snap
% SnapMove=Zcut*-1;
% classObj.MoCtrCard_MCrlAxisRelMove(2,SnapMove,0.1,0.1);
% pause(SleepMyTime2)
% 
% try
%   fwrite(ARDUINO,'z');
% catch
%   fclose(ARDUINO);
%   fopen(ARDUINO);
%   fwrite(ARDUINO,'z');
% end
% pause(0.5);

MakeAStackEndTag(SaveFolder)

% judge right or wrong
ImagesPerStack=200;
ImageLastNum=ImageNumAfterAStack(end)+ImagesPerStack;
DirectionAll(end+1)=Zdirection;
ImageLastNumFinal=ImageNumAfterAStack(1:end);

if exist([SaveFolder,'ImageLastNum.mat'])
    save([SaveFolder,'ImageLastNum.mat'],'ImageLastNumFinal','-append');
    save([SaveFolder,'DirectionAll.mat'],'DirectionAll','-append');
else
    save([SaveFolder,'ImageLastNum.mat'],'ImageLastNumFinal');
    save([SaveFolder,'DirectionAll.mat'],'DirectionAll');
end


if exist([SaveFolder,'Image1_',num2str(ImageLastNum),'.tif'])    
    if exist([SaveFolder,'Image1_',num2str(ImageLastNum+1),'.tif'])
        LastImageNum=DetectLastImageNum(SaveFolder);
        ImageNumAfterAStack(end+1)=LastImageNum;
        Zdirection=-1*Zdirection;
        StackNow=StackNow+1;
        RightOrWrong(end+1)=0;
        eval(SnapTag);
    else
        RightOrWrong(end+1)=1;
        ImageNumAfterAStack(end+1)=ImageNumAfterAStack(end)+ImagesPerStack;
        Zdirection=-1*Zdirection;        
    end
else
     LastImageNum=DetectLastImageNum(SaveFolder);
     ImageNumAfterAStack(end+1)=LastImageNum;
     Zdirection=-1*Zdirection;
     StackNow=StackNow+1;
     RightOrWrong(end+1)=0;
     eval(SnapTag);
end

if exist([SaveFolder,'RightOrWrong.mat'])
    save([SaveFolder,'RightOrWrong.mat'],'RightOrWrong','-append');
else
    save([SaveFolder,'RightOrWrong.mat'],'RightOrWrong');
end













