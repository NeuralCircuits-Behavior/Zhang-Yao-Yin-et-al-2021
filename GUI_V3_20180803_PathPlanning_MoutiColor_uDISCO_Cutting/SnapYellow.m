% Snap a stack of images of single light. Only for left light or right light seperately
% Using motor control instead of the grating ruler.

% ImagesPerStack=1100;
%     ImagesPerStack=200;
ImagesPerStack=200;
for lig=2
    
   
    % yellow imaging
    if lig==2
        if YellowImaging~=1
            continue;
        else
            ColorRight=ColorRightYellow;
            ColorLeft=ColorLeftYellow;
            LightVoltageLeft=LeftYellowVoltage;
            LightVoltageRight=RightYellowVoltage;
            CurrentColor=2;
            if FilterState~=FilterYellow
               query(Wheel, FilterStr(FilterYellow), '%c\n'); 
               pause(SleepTime9);
               FilterState=FilterYellow;
            end
        end
    end   
    
 
    
    if Zdirection>0
        TranslationZ=TranslationZP;
        TranslationZCon=TranslationZT; 
    else
        TranslationZ=TranslationZN;
        TranslationZCon=TranslationZTN;
    end
    
    
    
    
    
    if Ycycle-LeftImaging<j
%         SetPulsePalVoltageNew(ColorRight,0); 
    %     SetPulsePalVoltageNew(ColorLeft,10);
        SetPulsePalVoltageNew(ColorLeft,LightVoltageLeft);
        FirstVoltage=VoltageSampledLeftN(1);
        Side=2;
        pause(SleepTime7);
    elseif RightImaging>=j
%         SetPulsePalVoltageNew(ColorLeft,0); 
        LightVoltageRight=6;
        SetPulsePalVoltageNew(ColorRight,LightVoltageRight);
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


    display(['Move' num2str(TranslationZCon)])
    % classObj.MoCtrCard_MCrlAxisRelMove(2,TranslationZCon,0.1,0.05);
    if TranslationZCon<0
       Di=1;
    elseif TranslationZCon>0
       Di=0;
    end
    % classObj.MoCtrCard_MCrlAxisRelMoveAndPulse(2,Di,3,abs(TranslationZCon)+0.004,0.002,0.002,...
    %     0.1,0.005,10);
%     classObj.MoCtrCard_MCrlAxisRelMoveAndPulse(2,Di,3,abs(TranslationZCon),0.002,0.002,...
%          0.1,0.005,10);
    % classObj.MoCtrCard_MCrlAxisRelMoveAndPulse(2,Di,3,abs(TranslationZCon),0.002,0.002,...
    %    0.16,0.008,10);
%       classObj.MoCtrCard_MCrlAxisRelMoveAndPulse(2,Di,3,abs(TranslationZCon),0.01,0.01,...
%          0.08,0.005,10);
classObj.MoCtrCard_MCrlAxisRelMoveAndPulse(2,Di,3,abs(TranslationZCon),0.005,0.005,...
         0.1,0.005,10);

    classObj.MoCtrCard_GetEncoderVal(255, classObj.gbAxisEnc);
    PosOri=classObj.gbAxisEnc(3);
    TimeConstant=200;
    [TimeUsedi,RunTimes]=MoveOrNot(classObj,TimeConstant,PosOri);







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
%     ImagesPerStack=200;

    ImageLastNum=ImageNumAfterAStack(end)+ImagesPerStack;
    DirectionAll(end+1)=Zdirection;
    CurrentColorAll(end+1)=CurrentColor;
    ImageLastNumFinal=ImageNumAfterAStack(1:end);

    if exist([SaveFolder,'ImageLastNum.mat'])
        save([SaveFolder,'ImageLastNum.mat'],'ImageLastNumFinal','-append');
        save([SaveFolder,'DirectionAll.mat'],'DirectionAll','-append');
        save([SaveFolder,'CurrentColorAll.mat'],'CurrentColorAll','-append');
    else
        save([SaveFolder,'ImageLastNum.mat'],'ImageLastNumFinal');
        save([SaveFolder,'DirectionAll.mat'],'DirectionAll');
        save([SaveFolder,'CurrentColorAll.mat'],'CurrentColorAll');
    end

    
    
    LastImageNumReal=DetectLastImageNum(SaveFolder);
    if abs(LastImageNumReal-ImageLastNum)<=MaxErrorPermitted % correct
          RightOrWrong(end+1)=1;
          ImageNumAfterAStack(end+1)=LastImageNumReal;
          Zdirection=-1*Zdirection;       
    else % Error
         ImageNumAfterAStack(end+1)=LastImageNumReal;
         Zdirection=-1*Zdirection;
         StackNow=StackNow+1;
         RightOrWrong(end+1)=0;
         SnapYellow;
    end
    
%     if exist([SaveFolder,'Image1_',num2str(ImageLastNum),'.tif'])    
%         if exist([SaveFolder,'Image1_',num2str(ImageLastNum+1),'.tif'])
%             LastImageNum=DetectLastImageNum(SaveFolder);
%             ImageNumAfterAStack(end+1)=LastImageNum;
%             Zdirection=-1*Zdirection;
%             StackNow=StackNow+1;
%             RightOrWrong(end+1)=0;
%             eval(SnapTag);
%         else
%             RightOrWrong(end+1)=1;
%             ImageNumAfterAStack(end+1)=ImageNumAfterAStack(end)+ImagesPerStack;
%             Zdirection=-1*Zdirection;        
%         end
%     else
%          LastImageNum=DetectLastImageNum(SaveFolder);
%          ImageNumAfterAStack(end+1)=LastImageNum;
%          Zdirection=-1*Zdirection;
%          StackNow=StackNow+1;
%          RightOrWrong(end+1)=0;
%          eval(SnapTag);
%     end

    if exist([SaveFolder,'RightOrWrong.mat'])
        save([SaveFolder,'RightOrWrong.mat'],'RightOrWrong','-append');
    else
        save([SaveFolder,'RightOrWrong.mat'],'RightOrWrong');
    end
    
    ZDirectionAll(end+1)=Zdirection;
    %         Zdirection=Zdirection*-1;

    
    
%     SetPulsePalVoltageNew(ColorLeftBlue,0);
%     SetPulsePalVoltageNew(ColorRightBlue,0);
%     SetPulsePalVoltageNew(ColorLeftYellow,0);
%     SetPulsePalVoltageNew(ColorRightYellow,0);
%     SetPulsePalVoltageNew(ColorLeftRed,0);
%     SetPulsePalVoltageNew(ColorRightRed,0);

        
    SetPulsePalVoltageNew(ColorLeft,0);
    SetPulsePalVoltageNew(ColorRight,0);
    
   

    
    
    pause(0.2)
    
end










