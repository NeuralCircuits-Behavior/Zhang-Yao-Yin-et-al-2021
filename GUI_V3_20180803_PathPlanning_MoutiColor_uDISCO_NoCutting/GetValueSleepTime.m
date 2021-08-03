
function [SleepTime8 ,SleepTime1 ,SleepTime10 ,SleepTime11 ,SleepTime12 ,SleepTime2X,SleepTime2Y,SleepTime2Z,SleepTime3X,SleepTime3Y,SleepTime4,SleepTime5,SleepTime6,SleepTime7,SleepTime9,SleepTimeCut2]=GetValueSleepTime(handles)
    SleepTime8=str2num(handles.SleepTime8.String)/1000;
    SleepTime1=str2num(handles.SleepTime1.String)/1000;
    SleepTime10=str2num(handles.SleepTime10.String)/1000;
    SleepTime11=str2num(handles.SleepTime11.String)/1000;
    SleepTime12=str2num(handles.SleepTime12.String)/1000;
    SleepTime2X=str2num(handles.SleepTime2X.String)/1000;
    SleepTime2Y=str2num(handles.SleepTime2Y.String)/1000;
    SleepTime2Z=str2num(handles.SleepTime2Z.String)/1000;
    SleepTime3X=str2num(handles.SleepTime3X.String)/1000;
    SleepTime3Y=str2num(handles.SleepTime3Y.String)/1000;
    SleepTime4=str2num(handles.SleepTime4.String)/1000;
    SleepTime5=str2num(handles.SleepTime5.String)/1000;
    SleepTime6=str2num(handles.SleepTime6.String)/1000;
    SleepTime7=str2num(handles.SleepTime7.String)/1000;
    SleepTime9=str2num(handles.SleepTime9.String)/1000;
    SleepTimeCut2=str2num(handles.SleepTimeCut2.String)/1000;
end