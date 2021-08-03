


SavedFoldName=[handles.SaveFolderPath.String,'\'];    
if ~exist(SavedFoldName,'dir')
    mkdir(SavedFoldName);
end
%%
[classObj]=GetValueNormal(handles);

%% Initialize move parameters
[Xstep, Xcycle ,Ystep ,Ycycle ,Zstep ,Zcycle ,Zdifference,CutStepReady ,CutStepCutting, MaxCuttingThickness,Zoverlap,Zcut]=GetValueMove(handles);

if mod(Zcut,Zstep)
    warning('Please make sure mod(Zut,Zstep)==0');
end
    
Zstacks=ceil(Zstep*Zcycle/Zcut);
% SlicesPerStack=Zcut/Zstep+1;
SlicesPerStack=Zcut/Zstep;
SlicesLastStack=SlicesPerStack; %mod(Zcycle,SlicesPerStack);

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
[SleepTime8 ,SleepTime1 ,SleepTime10 ,SleepTime11 ,SleepTime12 ,SleepTime2X,SleepTime2Y,SleepTime2Z,SleepTime3X,SleepTime3Y,SleepTime4,SleepTime5,SleepTime6,SleepTime7,SleepTime9,SleepTimeCut2]=GetValueSleepTime(handles);
    

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
[Snap ,ExposureDefault ,ExposureBlueLeft ,ExposureBlueRight ,ExposureYellowLeft ,ExposureYellowRight ,ExposureRedLeft ,ExposureRedRight]=GetValueCamera(handles);

% This is a trick. Setting the ExposureBlue and ExposureRed as a one dimensional vector can facilitate the following procedure. It does not have any meaning. 
if ExposureDefault==1
    ExposureBlueLeft=[100];
    ExposureRedLeft=[100];
    ExposureYellowLeft=[100];
    ExposureBlueRight=[100];
    ExposureRedRight=[100];
    ExposureYellowRight=[100];
end

    % Snap; Snap(1) or not  
    % ExposureDefault: If the ExposureDefault equals to 1, the exposure time would be the current set exposure time, otherwise it would use the exposure time we set.
    % Exposure*: Exposure time for each side and each light. 

%% Initialize stage move parameters
[Normalspeed, CutspeedReady, CutspeedCutting,Acceleration]=GetSpeed(handles);

TranslationXP=Xstep*-1;
TranslationXN=Xstep;
TranslationYP=Ystep*-1;
TranslationYN=Ystep;
TranslationZP=Zstep*-1;
TranslationZN=Zstep;
TranslationZT=Zcut*-1;
TranslationZTN=Zcut;

TranslationCutReadyS=CutStepReady; % long 
TranslationCutReadyL=(CutStepReady+(Xcycle-1)*Xstep); % short

TranslationCutCutting=CutStepCutting;
CutReturnS=(CutStepReady+CutStepCutting)*-1;
CutReturnL=(CutStepReady+(Xcycle-1)*Xstep+CutStepCutting)*-1;

TranslationCutReturnS=abs(CutReturnS)*-1;
TranslationCutReturnL=abs(CutReturnL)*-1;

TranslationReturnZ=Zoverlap;
ReturnZmove=300/1000; %default 300
ReturnZmoveReverse=300/1000*-1; %default 300

TranslationZdifference=Zdifference;
TranslationZdifferenceReverse=Zdifference*-1;



%% Initialize filter parameters
FilterStr=GetFilterString;
FilterBlue=handles.BlueFilter.Value;
FilterYellow=handles.YellowFilter.Value;
FilterRed=handles.RedFilter.Value;
Wheel = instrfind('Type', 'serial', 'Port', handles.my.WheelPort, 'Tag', '');




%% Initialize light parameters
[LeftImaging,RightImaging,BlueImaging,YellowImaging,RedImaging]=GetValueImaging(handles);

if handles.ContinuslyMove.Value==1
    SnapTag='SnapAZStackSingleChannelContinuously';
    if BlueImaging==1
        ColorLeft=1;
        ColorRight=2;
    elseif RedImaging==1
        ColorLeft=3;
        ColorRight=4;
    elseif YellowImaging==1
        ColorLeft=3;
        ColorRight=4;
    end
else
    if BlueImaging+YellowImaging+RedImaging==5
        SnapTag='SnapAZStackSingleChannel';
        if BlueImaging==1
            ColorLeft=1;
            ColorRight=2;
        elseif RedImaging==1
            ColorLeft=3;
            ColorRight=4;
        elseif YellowImaging==1
            ColorLeft=3;
            ColorRight=4;
        end
    else
        SnapTag='SnapAZStackMultiChannel';
        ColorLeft=1;
        ColorRight=2;
    end
end
%% Voltage change with Y
% VoltageLeft=[];
% VoltageRight=[];

%% snap combine
[Snapcombine,VoltageSampledLeft,VoltageSampledRight]=GetValueSnapCombine(handles);
if ~exist('j')  |  exist('j')==5
    j=1;
end
VoltageSampledLeftN=VoltageSampledLeft(j,:);
VoltageSampledRightN=VoltageSampledRight(j,:);

% external trigger of cameral
Exposure=str2num(handles.ExposureEdit.String);
SetCameralETLVoltageTrain;

    % Snapcombine: Snapcombine(1) or not.
    % VoltageSampledLeft: Sampled voltage for left light, from small to big
    % VoltageSampledRight: Sampled voltage for Right light, from big to small
%% Initial move direction
XdirectionI=1;% 1 from left to right; -1 from right to left (X axis)
YdirectionI=1;% 1 from top to down; -1 from down to top (Y axis)
ZdirectionI=1;% 1 from top to down; -1 form down to top( Z axis)
SaveFolder='D:\WholeBrainImagingData\20180711_ToBeDel\Stack_1\';

