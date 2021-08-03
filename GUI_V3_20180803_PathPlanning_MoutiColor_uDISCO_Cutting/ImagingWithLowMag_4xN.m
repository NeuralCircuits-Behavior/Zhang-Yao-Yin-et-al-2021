% Start Imaging With Low Magnification
% Usually, imaging with 0.63x. Start with the current center
OverLapLowMag=str2num(handles.OverlapPlanning.String)/100;
StepUnit=1;

StepLowMag=2048*ResolutionProgramme-2048*ResolutionProgramme*OverLapLowMag;
MoveToLocationTL=[2048*ResolutionProgramme/2-2048*ResolutionProgramme*OverLapLowMag/2 2048*ResolutionProgramme/2-2048*ResolutionProgramme*OverLapLowMag/2];
MoveToLocationTL=MoveToLocationTL*-1;
MoveToLocationTR=[MoveToLocationTL(1)  MoveToLocationTL(2)*-1];
MoveToLocationDR=[MoveToLocationTL(1)*-1  MoveToLocationTL(2)*-1];
MoveToLocationDL=[MoveToLocationTL(1)*-1  MoveToLocationTL(2)];


% % Move to the down of the stack
% PosOri=GetCurrentStageLocation(classObj,2);
% classObj.MoCtrCard_MCrlAxisRelMove(2,-1*abs(TranslationZT),Normalspeed,Acceleration);
% [TimeUsedAll,RunTimes]=MoveOrNot_V2(classObj,TimeConstant,PosOri,2)
 
% suppose you are in the super surface


TranslationZCon=TranslationZT;

% initialization
% ImagesPerStackPlanning=101;% #
ImagesPerStackPlanning=11;% # 5000um
% ImagesPerStackPlanning=12;% #5500um

DirectionPlanning=1;
% get the initial image number
ImageNumAfterAStackPlanning(end+1)=DetectLastImageNum(SaveFolder);
% RightOrWrongPlanning=[];

for M=1:4
   if M==1
       CurrentLoactionN=[0 0];
       MoveToLocationN=MoveToLocationTL;
   elseif M==2
       CurrentLoactionN=MoveToLocationTL;
       MoveToLocationN=MoveToLocationTR;
   elseif M==3
       CurrentLoactionN=MoveToLocationTR;
       MoveToLocationN=MoveToLocationDR;
   elseif M==4
       CurrentLoactionN=MoveToLocationDR;
       MoveToLocationN=MoveToLocationDL;
   end
   
%    WorkShell_SynchronizationLowMag;
   if M==1
       % open right light
        SetPulsePalVoltageNew(ColorLeft,0); 
        SetPulsePalVoltageNew(ColorRight,ColorIntensityLowMagRight);
%         SetPulsePalVoltage(1,PlanningETLVoltageRight(1));
        pause(SleepTime7);
   end
   
   if M==3
       % open left light
        SetPulsePalVoltageNew(ColorRight,0); 
        SetPulsePalVoltageNew(ColorLeft,ColorIntensityLowMagLeft);
%         SetPulsePalVoltage(2,PlanningETLVoltageLeft(2));
        pause(SleepTime7);
   end
   
   % move to a location
   MoveToADestination(CurrentLoactionN,MoveToLocationN,classObj,StepUnit,Normalspeed,Acceleration,TimeConstant);
   % move along Z to get Images
   %% 2018/10/25 continuouse move
%    PosOri=GetCurrentStageLocation(classObj,2);
%    classObj.MoCtrCard_MCrlAxisRelMoveAndPulse(2,GetDi(DirectionPlanning),3,abs(TranslationZCon),0.002,0.002,0.1,0.005,10); % Change Di, snap et,al.
%    [TimeUsedAll,RunTimes]=MoveOrNot_V2(classObj,TimeConstant,PosOri,2);
    SingleMoveLowMag;
    DirectionPlanning=DirectionPlanning*-1;
    DirectionAllPlanning(end+1)=DirectionPlanning;

%%
       
%old before 20190424
while 1
       ImageLastNumPlanning=ImageNumAfterAStackPlanning(end)+ImagesPerStackPlanning;
        if exist([SaveFolder,'Image1_',num2str(ImageLastNumPlanning),'.tif'])    
            if exist([SaveFolder,'Image1_',num2str(ImageLastNumPlanning+1),'.tif'])
                ImageLastNumPlanning=DetectLastImageNum(SaveFolder);
                ImageNumAfterAStackPlanning(end+1)=ImageLastNumPlanning;
                RightOrWrongPlanning(end+1)=0;
                SingleMoveLowMag;
                DirectionPlanning=-1*DirectionPlanning;
                DirectionAllPlanning(end+1)=DirectionPlanning;
            else
                RightOrWrongPlanning(end+1)=1;
                ImageNumAfterAStackPlanning(end+1)=ImageNumAfterAStackPlanning(end)+ImagesPerStackPlanning;
                break;
            end
        else
             ImageLastNumPlanning=DetectLastImageNum(SaveFolder);
             ImageNumAfterAStackPlanning(end+1)=ImageLastNumPlanning;
             RightOrWrongPlanning(end+1)=0;
             SingleMoveLowMag;
             DirectionPlanning=-1*DirectionPlanning;
             DirectionAllPlanning(end+1)=DirectionPlanning;
        end
        pause(0.1)
       
   end
   
end


save([SaveFolder,'ImageLastNumPlanning.mat'],'ImageNumAfterAStackPlanning');
save([SaveFolder,'DirectionAllPlanning.mat'],'DirectionAllPlanning');
save([SaveFolder,'RightOrWrongPlanning.mat'],'RightOrWrongPlanning');


CurrentLocationCenter=[2048/2+(2048-2048*OverLapLowMag),2048/2];
% Close light
SetPulsePalVoltageNew(ColorLeft,0); 
SetPulsePalVoltageNew(ColorRight,0);

% Return to the original location
% change
if DirectionPlanning==-1
    PosOri=GetCurrentStageLocation(classObj,2);
    classObj.MoCtrCard_MCrlAxisRelMove(2,abs(TranslationZCon),Normalspeed,Acceleration);
    [TimeUsedAll,RunTimes]=MoveOrNot_V2(classObj,TimeConstant,PosOri,2);
end


