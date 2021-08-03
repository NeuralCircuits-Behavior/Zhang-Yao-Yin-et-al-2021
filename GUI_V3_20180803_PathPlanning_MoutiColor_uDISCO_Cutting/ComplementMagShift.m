function  ComplementMagShift(CurrentMag,MoveToMag,MagResolutionHigh,classObj,Normalspeed,Acceleration,TimeConstant,HighPixel,LowPixel)
    
    StepUnit=MagResolutionHigh;
    % complement from high to low
    if CurrentMag>MoveToMag
        MoveToADestination(HighPixel,LowPixel,classObj,StepUnit,Normalspeed,Acceleration,TimeConstant);
    elseif MoveToMag>CurrentMag
        MoveToADestination(LowPixel,HighPixel,classObj,StepUnit,Normalspeed,Acceleration,TimeConstant);
    end
end