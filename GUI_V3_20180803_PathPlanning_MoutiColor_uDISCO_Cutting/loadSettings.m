function loadSettings(hObject,handles,ConfigureName)

P=file2struct(ConfigureName);
Fields=fields(P);

% Sleep time
handles.SleepTime8.String=P.SleepTime8;
handles.SleepTime1.String=P.SleepTime1;
handles.SleepTime10.String=P.SleepTime10;
handles.SleepTime11.String=P.SleepTime11;
handles.SleepTime12.String=P.SleepTime12;
handles.SleepTime2X.String=P.SleepTime2X;
handles.SleepTime2Y.String=P.SleepTime2Y;
handles.SleepTime2Z.String=P.SleepTime2Z;
handles.SleepTime3X.String=P.SleepTime3X;
handles.SleepTime3Y.String=P.SleepTime3Y;
handles.SleepTime4.String=P.SleepTime4;
handles.SleepTime5.String=P.SleepTime5;
handles.SleepTime6.String=P.SleepTime6;
handles.SleepTime7.String=P.SleepTime7;
handles.SleepTime9.String=P.SleepTime9;
handles.SleepTimeCut2.String=P.SleepTimeCut2;

% Cameral
handles.SnapPoP.Value=P.Snap+1;
if P.ExposureDefault~=1
    P.ExposureDefault=2;
end
handles.ExposureDefaultPoP.Value=P.ExposureDefault;
handles.ExposureBlueLeft.String=P.ExposureBlueLeft;
handles.ExposureBlueRight.String=P.ExposureBlueRight;
handles.ExposureYellowLeft.String=P.ExposureYellowLeft;
handles.ExposureYellowRight.String=P.ExposureYellowRight;
handles.ExposureRedLeft.String=P.ExposureRedLeft;
handles.ExposureRedRight.String=P.ExposureRedRight;

% Light
handles.my.portlightRight=P.portlightRight;
handles.my.portlightLeft=P.portlightLeft;
handles.my.ChangeToBlueOpenRight=P.ChangeToBlueOpenRight;
handles.my.ChangeToBlueCloseRight=P.ChangeToBlueCloseRight;
handles.my.ChangeToYellowOpenRight=P.ChangeToYellowOpenRight;
handles.my.ChangeToYellowCloseRight=P.ChangeToYellowCloseRight;
handles.my.ChangeToRedOpenRight=P.ChangeToRedOpenRight;
handles.my.ChangeToRedCloseRight=P.ChangeToRedCloseRight;
handles.my.ChangeToBlueOpenLeft=P.ChangeToBlueOpenLeft;
handles.my.ChangeToBlueCloseLeft=P.ChangeToBlueCloseLeft;
handles.my.ChangeToYellowOpenLeft=P.ChangeToYellowOpenLeft;
handles.my.ChangeToYellowCloseLeft=P.ChangeToYellowCloseLeft;
handles.my.ChangeToRedOpenLeft=P.ChangeToRedOpenLeft;
handles.my.ChangeToRedCloseLeft=P.ChangeToRedCloseLeft;

% Move
handles.XStepSize.String=P.Xstep;
handles.XCycle.String=P.Xcycle;
handles.YStepSize.String=P.Ystep;
handles.YCycle.String=P.Ycycle;
handles.ZStepSize.String=P.Zstep;
handles.ZCycle.String=P.Zcycle;
handles.ZDifference.String=P.Zdifference;
handles.CutStepReady.String=P.CutStepReady;
handles.CutStepCutting.String=P.CutStepCutting;
handles.MaxCuttingThickness.String=P.MaxCuttingThickness;
handles.ZOverlap.String=P.Zoverlap;
handles.ZCut.String=P.Zcut;

handles.Acceleration.String=P.Acceleration;
handles.Normalspeed.String=P.Normalspeed;
handles.CutspeedReady.String=P.CutspeedReady;
handles.CutspeedCutting.String=P.CutspeedCutting;

% Imaging
handles.LeftImaging.String=P.LeftImaging;
handles.RightImaging.String=P.RightImaging;
if P.BlueImaging~=1
    P.BlueImaging=2;
end
if P.YellowImaging~=1
    P.YellowImaging=2;
end
if P.RedImaging~=1
    P.RedImaging=2;
end
handles.BlueImaging.Value=P.BlueImaging;
handles.YellowImaging.Value=P.YellowImaging;
handles.RedImaging.Value=P.RedImaging;

% Snap Combine

if P.Snapcombine~=1
    P.Snapcombine=2;
end
handles.CombinePoP.Value=P.Snapcombine;
handles.VoltageLeft.String=P.VoltageSampledLeft;
handles.VoltageRight.String=P.VoltageSampledRight;

% Filter
handles.BlueFilter.Value=P.FilterBlue;
handles.YellowFilter.Value=P.FilterYellow;
handles.RedFilter.Value=P.FilterRed;

% Save
handles.SaveFolderPath.String=P.SaveFolder;
handles.ConfigureName.String=P.ConfigureName;
MagValue=find(strcmp(handles.Magnification.String,P.Magnification));
handles.Magnification.Value=MagValue;
handles.AnimalName.String=P.AnimalName;

% my 
handles.my.StartImStack=P.StartImStack;
handles.my.StartImI=P.StartImI;
handles.my.StartImJ=P.StartImJ;

handles.my.EndImStac=P.EndImStac;
handles.my.EndImI=P.EndImI;
handles.my.EndImJ=P.EndImJ;

handles.my.Xdirection=P.Xdirection;
handles.my.Ydirection=P.Ydirection;
handles.my.Zdirection=P.Zdirection;
handles.my.Xlocation=P.Xlocation;
handles.my.Ylocation=P.Ylocation;

guidata(hObject,handles);
end