function [Snapcombine,VoltageSampledLeft,VoltageSampledRight]=getValueSnapCombine(handles)
      Snapcombine=handles.CombinePop.Value;
      VoltageSampledLeft=eval(handles.VoltageLeft.String);
      VoltageSampledRight=eval(handles.VoltageRight.String);
end