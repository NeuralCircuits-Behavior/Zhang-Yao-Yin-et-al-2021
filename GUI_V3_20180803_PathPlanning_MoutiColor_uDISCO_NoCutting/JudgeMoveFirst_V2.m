function JudgeMoveFirst_V2(classObj,PosFirst)
while 1
  classObj.MoCtrCard_GetEncoderVal(255, classObj.gbAxisEnc);
  PosNow=classObj.gbAxisEnc(3);
  if abs(PosNow-PosFirst)>=1
      break;
  end
end
end