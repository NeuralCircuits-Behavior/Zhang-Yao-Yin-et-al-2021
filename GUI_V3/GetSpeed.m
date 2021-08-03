

function [Normalspeed, CutspeedReady, CutspeedCutting Acceleration]=GetSpeed(handles)
Normalspeed = str2num(handles.Normalspeed.String);
CutspeedReady=str2num(handles.CutspeedReady.String);
CutspeedCutting=str2num(handles.CutspeedCutting.String);
Acceleration=str2num(handles.AccelerationRealMove.String);
end

