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


% Move to the down of the stack
PosOri=GetCurrentStageLocation(classObj,2);
classObj.MoCtrCard_MCrlAxisRelMove(2,-1*abs(TranslationZT),Normalspeed,Acceleration);
[TimeUsedAll,RunTimes]=MoveOrNot_V2(classObj,TimeConstant,PosOri,2)
 
    
% open right light
SetPulsePalVoltageNew(ColorLeft,0); 
SetPulsePalVoltageNew(ColorRight,10);
SetPulsePalVoltage(1,PlanningETLVoltageRight(1));
pause(SleepTime7);
% Move to the top left
MoveToADestination([0 0],MoveToLocationTL,classObj,StepUnit,Normalspeed,Acceleration,TimeConstant);
SnapSingleImage;
% Move to the top right
MoveToADestination(MoveToLocationTL,MoveToLocationTR,classObj,StepUnit,Normalspeed,Acceleration,TimeConstant);
SnapSingleImage;

% open left light
SetPulsePalVoltageNew(ColorRight,0); 
SetPulsePalVoltageNew(ColorLeft,5.4);
SetPulsePalVoltage(2,PlanningETLVoltageLeft(2));
pause(SleepTime7);
% Move to the down right
MoveToADestination(MoveToLocationTR,MoveToLocationDR,classObj,StepUnit,Normalspeed,Acceleration,TimeConstant);
SnapSingleImage;
% Move to the down left
MoveToADestination(MoveToLocationDR,MoveToLocationDL,classObj,StepUnit,Normalspeed,Acceleration,TimeConstant);
SnapSingleImage;

CurrentLocationCenter=[2048/2+(2048-2048*OverLapLowMag),2048/2];


% Close light
SetPulsePalVoltageNew(ColorLeft,0); 
SetPulsePalVoltageNew(ColorRight,0);

% Return to the original location
PosOri=GetCurrentStageLocation(classObj,2);
classObj.MoCtrCard_MCrlAxisRelMove(2,abs(TranslationZT),Normalspeed,Acceleration);
[TimeUsedAll,RunTimes]=MoveOrNot_V2(classObj,TimeConstant,PosOri,2)


