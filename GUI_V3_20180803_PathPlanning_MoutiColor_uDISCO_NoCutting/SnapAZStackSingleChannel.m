% Snap a stack of images of single light. Only for left light or right light seperately
% YX, 20170903

if s~=Zstacks
    ZImages=SlicesPerStack;
else
    ZImages=SlicesLastStack;
end

if Zdirection>0
    TranslationZ=TranslationZP;
else
    TranslationZ=TranslationZN;
end

if Ycycle-LeftImaging<j
    SetPulsePalVoltageNew(ColorRight,0); 
    SetPulsePalVoltageNew(ColorLeft,10);
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
    

TriggerPulsePal([4])
pause(SleepTime8);
n=0;

% classObj.MoCtrCard_EnableCompensateFunction (2);
% MoveOrNot(classObj);
for z=1:ZImages-1
    n=n+1;
    if Side==1
        SetPulsePalVoltage(1,FirstVoltage);
    else
        SetPulsePalVoltage(2,FirstVoltage);
    end
    
%     if n==1
%         TimeConstant=1000;
%         Speed=2;
%         Accel=0.4;
%     else
        if Zdirection==1 % stage from down to top
            Speed=2;
            Accel=0.4;
            TimeConstant=10;
        elseif Zdirection==-1 % stage from top to down
            Speed=2;
            Accel=0.4;
            TimeConstant=10;
        end
%     end
    
    classObj.MoCtrCard_GetEncoderVal(255, classObj.gbAxisEnc);
    PosOri=classObj.gbAxisEnc(3);
    
    classObj.MoCtrCard_MCrlAxisRelMove(2,TranslationZ,Speed,Accel);
%     [TimeUsedi,RunTimes]=MoveOrNot(classObj,TimeConstant,PosOri);
%     TimeUsed(n)=TimeUsedi;
%     classObj.MoCtrCard_GetEncoderVal(255, classObj.gbAxisEnc);
%     PosFirst=classObj.gbAxisEnc(3);
%     a(n)=PosFirst;

    TriggerPulsePal([4])
    pause(SleepTime8);
end


Zdirection=-1*Zdirection;

% for i=1:length(a)
%    Diff(i)= abs(a(i)-a(1))-10*(i-1);
% end
% Diff
% % a
% % diff(a)
% mean(TimeUsed)
% 
% a;

