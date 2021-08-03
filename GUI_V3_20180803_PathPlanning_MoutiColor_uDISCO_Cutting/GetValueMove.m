

function [XStep, XCycle ,YStep ,YCycle ,ZStep ,ZCycle ,ZDifference,CutStepReady ,CutStepCutting, MaxCuttingThickness,ZOverlap,Zcut]=GetValueMove(handles)
   XStep=str2num(handles.XStepSize.String)/1000;    
   XCycle=str2num(handles.XCycle.String);
   YStep=str2num(handles.YStepSize.String)/1000;    
   YCycle=str2num(handles.YCycle.String);
   ZStep=str2num(handles.ZStepSize.String)/1000;    
   ZCycle=str2num(handles.ZCycle.String);
   ZDifference=str2num(handles.ZDifference.String)/1000;  
   CutStepReady=str2num(handles.CutStepReady.String)/1000;  
   CutStepCutting=str2num(handles.CutStepCutting.String)/1000;  
   MaxCuttingThickness=str2num(handles.MaxCuttingThickness.String)/1000;  
   ZOverlap=str2num(handles.ZOverlap.String)/1000;  
   Zcut=str2num(handles.ZCut.String)/1000;  
end