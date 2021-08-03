%%% This is the main function of imaging. 
%%% Usage: 
%%%     StartImaging_Planning(hObject,eventdata,handles)
%%% YX, 20180717



function StartImaging_Planning(hObject,eventdata,handles)


%% Initialize
Update;
query(Wheel, FilterStr(FilterBlue), '%c\n');
FilterState=FilterBlue;

%% Start Planning
% OverallDirection=1; % 1 from the top left to down right; -1 from the down right to the top left
% ImagingMatrixA=[];
% PlannedPathA=[];
% ZDirectionAll=[];
% StackAll=[];
% DirectionAll=[];
% RightOrWrong=[]; % 1 right, 0 wrong
% CurrentColorAll=[];
warning off

OverallDirection=1; % 1 from the top left to down right; -1 from the down right to the top left
ImagingMatrixA=[];
PlannedPathA=[];
ZDirectionAll=[];
StackAll=[];
DirectionAll=[];
RightOrWrong=[]; % 1 right, 0 wrong
ImageNumAfterAStack=[];
RightOrWrongPlanning=[];
ImageNumAfterAStackPlanning=[];
DirectionAllPlanning=[];
CurrentColorAll=[];

for s=1:Zstacks
    if handles.Planning.Value==1
        % if this is not the first stack, we should first move the current
        % field of view to the center
        if s~=1
            CurrentImagingCenterLocation=GetCenterLocation(CurrentLocation,StartRowA,EndRowAV,StartColumnA,EndColumnAV,SizeImagingMatrix);
            StepUnit=MagResolutionLow;
            MoveToADestination(CurrentImagingCenterLocation,ImagingCenterLocation,classObj,StepUnit,Normalspeed,Acceleration,TimeConstant);
        end
        
          
        % Change the magnification
        MagResolutionHigh=GetResolution(MagImaging);
        PreviousMag=CurrentMagnification;
        CurrentMagnification=ChangeMagfication(hObject,handles,CurrentMagnification,LowMagnification);
        ComplementMagShift(CurrentMagnification,LowMagnification,MagResolutionHigh,classObj,Normalspeed,Acceleration,TimeConstant,HighPixel,LowPixel)
    
        % Adjust the focus, MoveDirection, 1 up, -1 down
        if CurrentMagnification~=PreviousMag
            AdJustFocus(handles,FocusMoveHightLow,1);
        end
        % Start imaging with low magnification (0.63x) ,first we should align the center of the current field of view and the current image.
        ImagingWithLowMag_4xN;
        
        % Load images
%         InputVoulum=LoadImages(SaveFolder,OverLapLowMag);
%         TheCurrentMaxProjectionImage=max(InputVoulum,3);
%         SizeMPLow=size(TheCurrentMaxProjectionImage);
%         ImagingCenterLocation=size(TheCurrentMaxProjectionImage)/2;
%         % analyze images to find the optimal path
%         [ImagingMatrix,StepStage,StartRowA,EndRowA,StartColumnA,EndColumnA,MagResolutionLow,MagResolutionHigh,EndRowAV,EndColumnAV]=FindImagingMatrix(TheCurrentMaxProjectionImage,DownfactorXY,DownfactorZ,MagLow,MagImaging,OverlapImaging,CutoffSignal,CutoffImagingRatio);
        InputVoulum=LoadImages_4xN(SaveFolder,OverLapLowMag,ImagesPerStackPlanning,ReferenceName,OverLapLowMag);
        TheCurrentMaxProjectionImage=max(InputVoulum,3);
        SizeMPLow=size(TheCurrentMaxProjectionImage);
        ImagingCenterLocation=size(TheCurrentMaxProjectionImage)/2;
        % detect axon signal
        seg=Axon_Segmentation(TheCurrentMaxProjectionImage);
        % analyze images to find the optimal path
        [ImagingMatrix,StepStage,StartRowA,EndRowA,StartColumnA,EndColumnA,MagResolutionLow,MagResolutionHigh,EndRowAV,EndColumnAV]=FindImagingMatrix(seg,DownfactorXY,DownfactorZ,MagLow,MagImaging,OverlapImaging,CutoffSignal,CutoffImagingRatio);
        Update;
        SizeImagingMatrix=size(ImagingMatrix);
        
        if ShowPlanning==1
            if handles.CheckPlanning.Value==1
                h.fig = figure;
                BackCol = [1 1 1];
                TheCurrentMaxProjectionImageHDR=tonemap(double(TheCurrentMaxProjectionImage),'AdjustSaturation',1);
                set(h.fig, 'Units', 'Normalized', 'Position', [0 1 0 1]);
%                 set(h.fig, 'DefaultAxesLineWidth', 2, 'DefaultAxesFontSize', 12, 'Color', BackCol);
                set(h.fig, 'WindowButtonDownFcn', {@figClick, h.fig,StartRowA,EndRowA,StartColumnA,EndColumnA,ImagingMatrix,TheCurrentMaxProjectionImageHDR});
                h.ax(1) = axes;
                h.axim(1) = imshow(TheCurrentMaxProjectionImageHDR,[]); hold on;
                PlotGrids(StartRowA,EndRowA,StartColumnA,EndColumnA,ImagingMatrix);
                h.ImagingMatrix=ImagingMatrix;
                guidata(h.fig, h);
                while 1
                    if handles.StartI.Value==1
                        handles.StartI.Value=0;
                        break;
                    end
                    h = guidata(h.fig);
                    ImagingMatrix=h.ImagingMatrix;
                    pause(0.01)
                end
            else
                figure;
                imshow(TheCurrentMaxProjectionImageHDR,[ ])
                hold on
                PlotGrids(StartRowA,EndRowA,StartColumnA,EndColumnA,ImagingMatrix);
            end
        end
        % find the planning path, bug when there are no images detected

        [PlannedPath XDirectionAll]=FoundPlannedPath(ImagingMatrix,OverallDirection);
        % change to imaging magnification 
        PreviousMag=CurrentMagnification;
        CurrentMagnification=ChangeMagfication(hObject,handles,CurrentMagnification,MagImaging);
        ComplementMagShift(CurrentMagnification,MagImaging,MagResolutionHigh,classObj,Normalspeed,Acceleration,TimeConstant,HighPixel,LowPixel)
        
        % Complement Low To High
        % complement the center difference between this two focus
        % first you should know where you are after path planning with low
        % magnification. Suppose there is a difference between the center of low
        % magnification and high magnification.
        % DeltaCenter=CenterOfHighMag-CenterOfLowMag;
        % Move To Low Mag Center when in high Mag
        
        
        if PreviousMag~=CurrentMagnification
            AdJustFocus(handles,FocusMoveLow2High,-1);
        end
        
        
        
        % Move To the first location of the PlannedPath
        if ~isempty(PlannedPath)
    %         ImagingCenterLocation=fix(SizeMPLow/2);   
%             DestinationImagingCenterLocation=GetCenterLocation(PlannedPath(1,:),StartRowA,EndRowAV,StartColumnA,EndColumnAV,SizeImagingMatrix);
%             StepUnit=MagResolutionLow;
%             MoveToADestination(CurrentLocationCenter,DestinationImagingCenterLocation,classObj,StepUnit,Normalspeed,Acceleration,TimeConstant);
%             CurrentLocation=PlannedPath(1,:);
            DestinationImagingCenterLocation=GetCenterLocation(PlannedPath(1,:),StartRowA,EndRowAV,StartColumnA,EndColumnAV,SizeImagingMatrix);
            StepUnit=MagResolutionLow;
            MoveToADestination(CurrentLocationCenter,DestinationImagingCenterLocation,classObj,StepUnit,Normalspeed,Acceleration,TimeConstant);
            CurrentLocation=PlannedPath(1,:);
        end
    end
    ImagingMatrixA(:,:,s)=ImagingMatrix;
    
    % Start Moving And Imaging. The first ZDirection is +1
    Zdirection=1;
    ImageNumAfterAStack=DetectLastImageNum(SaveFolder);
    
     
    StackNow=0;
    Ycycle=SizeImagingMatrix(1);
    jI=0;
    
    LinkNone;
    for i=1:size(PlannedPath,1)
        j=PlannedPath(i,1);
        VoltageSampledRightN=VoltageSampledRight(j,:);
        VoltageSampledLeftN=VoltageSampledLeft(j,:);
        if jI~=j
            NonsynLink; % close it when using Synchronization
%             WorkShell_Synchronization; % only use when using synchronization with lightsheet mode
              jI=j;
        end
        
        MoveToLocation=PlannedPath(i,:);
        StepUnit=StepStage; % um
        MoveToADestination(CurrentLocation,MoveToLocation,classObj,StepUnit,Normalspeed,Acceleration,TimeConstant);
        CurrentLocation=MoveToLocation;
        display(['Current Location: [',num2str(CurrentLocation(1)),',',num2str(CurrentLocation(2)),']'])
        Xdirection=XDirectionAll(i);
        eval(SnapTag);
        PlannedPathA(end+1,1:2)=PlannedPath(i,:);
        StackAll(end+1)=s;
        
        Planning.PlannedPathA=PlannedPathA;
        Planning.StackAll=StackAll;
        Planning.ImagingMatrixA=ImagingMatrixA;
        Planning.ZDirectionAll=ZDirectionAll;

        save([SaveFolder,'Planning.mat'],'Planning'); 
    end
    handles.my.CurrentLocation=CurrentLocation;
    Judge;
    if handles.Break.Value==1
      handles.StartImaging.Value=0;
      guidata(hObject,handles);
      break;
    end

    % Complement the Current location, because the current location may not the
    % TranslationCutReadyS or TranslationCutReadyL. Suppose that the
    % TranslationCutReadyS and TranslationCutReadyL were computed from the
    % center of the image 
    
    CurrentImagingCenterLocation=GetCenterLocation(CurrentLocation,StartRowA,EndRowAV,StartColumnA,EndColumnAV,SizeImagingMatrix);      
    TranslationCutReadyS=TranslationCutReadyS-(ImagingCenterLocation(2)-CurrentImagingCenterLocation(2))*MagResolutionLow/1000;
    TranslationCutReadyL=TranslationCutReadyS;
    
    CutReturnS=abs(TranslationCutReadyS)+abs(CutStepCutting);
    CutReturnL=CutReturnS;
    TranslationCutReturnS=abs(CutReturnS)*-1;
    TranslationCutReturnL=abs(CutReturnL)*-1;

    
    
    % To Cut
    ToCut;
    OverallDirection=OverallDirection*-1;
    Judge;
    if handles.Break.Value==1
      handles.StartImaging.Value=0;
      guidata(hObject,handles);
      break;
    end

end



%% Start moving and imaging. You should first move to the top left 
% StackNow=0;
% ImageNumAfterAStack=DetectLastImageNum(SaveFolder);
% DirectionAll=[];
% RightOrWrong=[]; % 1 right, 0 wrong
% for s=StartS:Zstacks
%     for j=StartJ:Step:EndJ % y
%         VoltageSampledRightN=VoltageSampledRight(j,:);
%         VoltageSampledLeftN=VoltageSampledLeft(j,:);
% %         SetCameralETLVoltageTrain;
%         % Get images
%         if TagSnap~=0
%             TagSnap=1;
%             StackNow=StackNow+1;
%             display(['Stack:',num2str(s), '      Xlocation:',num2str(Xlocation),'      Ylocation:',num2str(Ylocation),'    Snap'])               
%             eval(SnapTag);
%             handles.my.EscapLocation=1;
% %             % judege stop or update after each stack;
%             Judge;
%             if handles.Break.Value==1
%                   handles.StartImaging.Value=0;
%                   guidata(hObject,handles);
%                   break;
%             end
%            
%         end
%         if Xcycle~=1 % in case that the Xcycle==1
%             for i=StartI:Xcycle-1 % x
%                 if Xdirection>0
%                     TranslationX=TranslationXP;
%                     DeltaX=Xstep;
%                 else
%                     TranslationX=TranslationXN;
%                     DeltaX=-Xstep;
%                 end
%                 % move X                
%                 classObj.MoCtrCard_MCrlAxisRelMove(0,TranslationX,Normalspeed,Acceleration);
%                 %   pause(SleepTime2X);
%                 classObj.MoCtrCard_GetEncoderVal(255, classObj.gbAxisEnc);
%                 PosOri=classObj.gbAxisEnc(1);
%                 TimeConstant=200;
%                 [TimeUsedi,RunTimes]=MoveOrNot_X(classObj,TimeConstant,PosOri);
% 
% 
%                 Xlocation=Xlocation+DeltaX;
%                 display(['Stack:',num2str(s), '      Xlocation:',num2str(Xlocation),'      Ylocation:',num2str(Ylocation),'     MoveX Snap'])             
%                 % get images
%                 StackNow=StackNow+1;
%                 eval(SnapTag);
%                 handles.my.EscapLocation=2;
%                 % judege stop or update after each stack; 
%                 Judge;
%                 if handles.Break.Value==1
%                       handles.StartImaging.Value=0;
%                       guidata(hObject,handles);
%                       break;
%                 end
%            end
%         end %if Xcycle~=1
%         
%         if (j~=Ycycle & Step>0) |  (j~=1 & Step<0)        
%             if Ydirection>0
%                 TranslationY=TranslationYP;
%                 DeltaY=Ystep;
%             else
%                 TranslationY=TranslationYN;
%                 DeltaY=-Ystep;
%             end
%             
%             classObj.MoCtrCard_MCrlAxisRelMove(1,TranslationY,Normalspeed,Acceleration);
%             %  pause(SleepTime2Y);
%             classObj.MoCtrCard_GetEncoderVal(255, classObj.gbAxisEnc);
%             PosOri=classObj.gbAxisEnc(2);
%             TimeConstant=200;
%             [TimeUsedi,RunTimes]=MoveOrNot_Y(classObj,TimeConstant,PosOri);
% 
% 
%             Ylocation=Ylocation+DeltaY;
%             display(['Stack:',num2str(s), '      Xlocation:',num2str(Xlocation),'      Ylocation:',num2str(Ylocation),'    MoveY'])                  
%         end
%         Xdirection=-1*Xdirection;
%     end %j
%     Ydirection=-1*Ydirection;
%     ToCut;
%     Zdirection=ZdirectionI; % initilize Z direction
%     Step=-1*Step; T=EndJ;  EndJ=StartJ; StartJ=T; % change J direction
%     
%     % judge stop or update after each stack; 
%     Judge;
%     if handles.Break.Value==1
%           handles.StartImaging.Value=0;
%           guidata(hObject,handles);
%           break;
%     end
% end
% 
% 
% 
% if ~exist('i')  |  exist('i')==5
%     i=1;
% end
% handles.my.EndImStack=s;
% handles.my.EndImI=i;
% handles.my.EndImJ=j;
% handles.my.Xdirection=Xdirection;
% handles.my.Ydirection=Ydirection;
% handles.my.Zdirection=Zdirection;
% handles.my.Xlocation=Xlocation;
% handles.my.Ylocation=Ylocation;
SaveConfigure(handles);


