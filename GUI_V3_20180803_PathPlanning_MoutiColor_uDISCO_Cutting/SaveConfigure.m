function SaveConfigure(handles)

%% Basic information
P.Date= datetime('now');
P.Magnification=handles.Magnification.String(handles.Magnification.Value);
P.AnimalName=handles.AnimalName.String;
P.SaveFolder=handles.SaveFolderPath.String;
P.ConfigureName=handles.ConfigureName.String;


if ~isfield(handles.my,'EndImStac')
    P.StartImStack=[];
    P.StartImI=[];
    P.StartImJ=[];
    P.EndImStac=[];
    P.EndImI=[];
    P.EndImJ=[];
    P.Xdirection=[];
    P.Ydirection=[];
    P.Zdirection=[];
    P.Xlocation=[];
    P.Ylocation=[];
else
    P.StartImStack=handles.my.StartImStack;
    P.StartImI=handles.my.StartImI;
    P.StartImJ=handles.my.StartImJ;
    
    P.EndImStac=handles.my.EndImStac;
    P.EndImI=handles.my.EndImI;
    P.EndImJ=handles.my.EndImJ;

    P.Xdirection=handles.my.Xdirection;
    P.Ydirection=handles.my.Ydirection;
    P.Zdirection=handles.my.Zdirection;
    P.Xlocation=handles.my.Xlocation;
    P.Ylocation=handles.my.Ylocation;
end
%%
[P.Xstep, P.Xcycle ,P.Ystep ,P.Ycycle ,P.Zstep ,P.Zcycle ,P.Zdifference,P.CutStepReady ,P.CutStepCutting, P.MaxCuttingThickness,P.Zoverlap,P.Zcut]=GetValueMove(handles);
P.Xstep=P.Xstep*1000;
P.Ystep=P.Ystep*1000;
P.Zstep=P.Zstep*1000;
P.Zdifference=P.Zdifference*1000;
P.CutStepReady=P.CutStepReady*1000;
P.CutStepCutting=P.CutStepCutting*1000;
P.MaxCuttingThickness=P.MaxCuttingThickness*1000;
P.Zoverlap=P.Zoverlap*1000;
P.Zcut=P.Zcut*1000;
[P.Normalspeed, P.CutspeedReady, P.CutspeedCutting]=GetSpeed(handles)
P.Acceleration=handles.AccelerationRealMove.String;
    % Xstep: Move X step 
    % Ystep: Move Y step
    % Zstep: Move Z step
    % Xcycle: X cycle
    % Ycycle: Y cycle
    % Zcycle: Z Cycle
    % Zdifference: Distance between light and the blade. Positive: Negative
    % CutStepReady: Move step before cutting
    % CutStepCutting: Move step in cutting
    % MaxCuttingThickness: Max cutting thickness permitted
    % Zoverlap:Overlap between adjacent stacks. 
    
%% Initialize sleep time
[P.SleepTime8 ,P.SleepTime1 ,P.SleepTime10 ,P.SleepTime11 ,P.SleepTime12 ,P.SleepTime2X,P.SleepTime2Y,P.SleepTime2Z,P.SleepTime3X,P.SleepTime3Y,P.SleepTime4,P.SleepTime5,P.SleepTime6,P.SleepTime7,P.SleepTime9,P.SleepTimeCut2]=GetValueSleepTime(handles);
    P.SleepTime8=P.SleepTime8*1000;
    P.SleepTime1=P.SleepTime1*1000;
    P.SleepTime10=P.SleepTime10*1000;
    P.SleepTime11=P.SleepTime11*1000;
    P.SleepTime12=P.SleepTime12*1000;
    P.SleepTime2X=P.SleepTime2X*1000;
    P.SleepTime2Y=P.SleepTime2Y*1000;
    P.SleepTime2Z=P.SleepTime2Z*1000;
    P.SleepTime3X=P.SleepTime3X*1000;
    P.SleepTime3Y=P.SleepTime3Y*1000;
    P.SleepTime4=P.SleepTime4*1000;
    P.SleepTime5=P.SleepTime5*1000;
    P.SleepTime6=P.SleepTime6*1000;
    P.SleepTime7=P.SleepTime7*1000;
    P.SleepTime9=P.SleepTime9*1000;
    P.SleepTimeCut2=P.SleepTimeCut2*1000;
    % SleepTime1: Set SpeedTime
    % SleepTimeCut2: Return Z time
    % SleepTime2X: Move X. 5000ms for 8000step;
    % SleepTime2Y: Move Y. 5000ms for 8000step;
    % SleepTime2Z: Move Z. 5000ms for 8000step;
    % SleepTime3X: Reture to Zero X 6000;
    % SleepTime3Y: Reture to Zero Y.
    % SleepTime4: Cut time ready
    % SleepTime5: Cut time cutting
    % SleepTime6: Return to zero(imaging) after cut
    % SleepTime10: Cutting return to the cut start point in Normal Speed(255) time 
    % SleepTime7: Imaging delay after opening light
    % SleepTime8: Light closing delay after Imaging 
    % SleepTime9: Filter Transfer
    % SleepTime11: Move MaxCuttingThickness in Z;
    % SleepTime12: Move Zdifference time;
%% initialize cameral parameters
[P.Snap ,P.ExposureDefault ,P.ExposureBlueLeft ,P.ExposureBlueRight ,P.ExposureYellowLeft ,P.ExposureYellowRight ,P.ExposureRedLeft ,P.ExposureRedRight]=GetValueCamera(handles);

    % Snap; Snap(1) or not  
    % ExposureDefault: If the ExposureDefault equals to 1, the exposure time would be the current set exposure time, otherwise it would use the exposure time we set.
    % Exposure*: Exposure time for each side and each light. 

%% Initialize stage move parameters
% P.port=handles.my.port;
%% Initialize filter parameters
P.FilterBlue=handles.BlueFilter.Value;
P.FilterYellow=handles.YellowFilter.Value;
P.FilterRed=handles.RedFilter.Value;

%% Initialize light parameters

[P.LeftImaging,P.RightImaging,P.BlueImaging,P.YellowImaging,P.RedImaging]=GetValueImaging(handles);
% [P.portlightRight,P.portlightLeft,P.ChangeToBlueOpenRight,P.ChangeToBlueCloseRight, P.ChangeToYellowOpenRight,P.ChangeToYellowCloseRight,P.ChangeToRedOpenRight,P.ChangeToRedCloseRight,P.ChangeToBlueOpenLeft,P.ChangeToBlueCloseLeft,P.ChangeToYellowOpenLeft,P.ChangeToYellowCloseLeft,P.ChangeToRedOpenLeft,P.ChangeToRedCloseLeft]=GetValueLight(handles);



%% Initialize save parameters
P.SaveType=2; % 1 .mat,  2 .tif, 3 .jpg 

%% Trigger, synchronization ETL and sCMOS
P.Synchronization=0;

%% Voltage change with Y
% VoltageLeft=[];
% VoltageRight=[];

%% snap combine
[P.Snapcombine,P.VoltageSampledLeft,P.VoltageSampledRight]=GetValueSnapCombine(handles);
P.VoltageSampledLeft=handles.VoltageLeft.String;
P.VoltageSampledRight=handles.VoltageRight.String;
    % Snapcombine: Snapcombine(1) or not.
    % VoltageSampledLeft: Sampled voltage for left light, from small to big
    % VoltageSampledRight: Sampled voltage for Right light, from big to small




%% make cfg

File=which('ImagingV');
Folder=fileparts(File);
CfgTemplatePath=[Folder,'\template.cfg'];
CfgDestination=[P.SaveFolder,filesep(),P.ConfigureName];
CfgDestinationT=CfgDestination;
if ~exist(P.SaveFolder,'dir')
    mkdir(P.SaveFolder);
end
n=0;
while 1
    n=n+1;
    if exist(CfgDestination,'file')
        CfgDestination=subsFileExt(CfgDestinationT,'');
        CfgDestination=[CfgDestination,'_',num2str(n),'.cfg'];
    else
        break;
    end
end


copyfile(CfgTemplatePath,CfgDestination);
struct2file(P,CfgDestination);

end