


%% z
classObj.MoCtrCard_GetEncoderVal(255, classObj.gbAxisEnc);
PosOri=classObj.gbAxisEnc(3);
TimeConstant=200;
[TimeUsedi,RunTimes]=MoveOrNot(classObj,TimeConstant,PosOri);

%% Y
classObj.MoCtrCard_GetEncoderVal(255, classObj.gbAxisEnc);
PosOri=classObj.gbAxisEnc(2);
TimeConstant=200;
[TimeUsedi,RunTimes]=MoveOrNot_Y(classObj,TimeConstant,PosOri);


%% x

classObj.MoCtrCard_GetEncoderVal(255, classObj.gbAxisEnc);
PosOri=classObj.gbAxisEnc(1);
TimeConstant=200;
[TimeUsedi,RunTimes]=MoveOrNot_X(classObj,TimeConstant,PosOri);