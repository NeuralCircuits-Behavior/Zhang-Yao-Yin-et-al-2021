function JudgeMoveFirst(classObj)
while 1
  ttt = ones (1, 4, 'uint32');
  classObj.MoCtrCard_GetRunState(ttt);
  classObj.gbRunState;
  MovState = bitget(classObj.gbRunState,11);
  if MovState==1
      break;
  end
end
end