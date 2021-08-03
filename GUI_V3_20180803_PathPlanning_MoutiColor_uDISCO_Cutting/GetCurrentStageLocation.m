
function      PosOri=GetCurrentStageLocation(classObj,Axis)
    classObj.MoCtrCard_GetEncoderVal(255, classObj.gbAxisEnc);
    PosOri=classObj.gbAxisEnc(Axis+1);
end

