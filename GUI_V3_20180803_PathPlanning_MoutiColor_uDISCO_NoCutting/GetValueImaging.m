function [LeftImaging,RightImaging,BlueImaging,YellowImaging,RedImaging]=getValueImaging(handles)
      
      LeftImaging=str2num(handles.LeftImaging.String);
      RightImaging=str2num(handles.RightImaging.String);
      BlueImaging=handles.BlueImaging.Value;
      YellowImaging=handles.YellowImaging.Value;
      RedImaging=handles.RedImaging.Value;

end