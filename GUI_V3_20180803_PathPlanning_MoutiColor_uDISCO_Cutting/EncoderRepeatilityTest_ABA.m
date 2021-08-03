
%% X AXIS
%Snap a picture first 
clc;
classObj.MoCtrCard_GetEncoderVal(255, classObj.gbAxisEnc);
PosBeforeX=classObj.gbAxisEnc(2);
pause(1); 
for i=1:10

if ~mod(i,2)==0
    Distance=-2;
else
    Distance=2;
end
classObj.MoCtrCard_MCrlAxisRelMove(1,Distance,10,5);
pause(3);
% classObj.MoCtrCard_MCrlAxisRelMove(0,-2,10,5);
% pause(3);
end

classObj.MoCtrCard_GetEncoderVal(255, classObj.gbAxisEnc);
PosAfterX=classObj.gbAxisEnc(2);
disp (PosAfterX-PosBeforeX);
%Snap a picture now 
  
%% Y AXIS
%Snap a picture first 
clc;
classObj.MoCtrCard_GetEncoderVal(255, classObj.gbAxisEnc);
PosBeforeY=classObj.gbAxisEnc(2);
pause(1); 
  
classObj.MoCtrCard_MCrlAxisRelMove(1,-2,10,5);
pause(3);
classObj.MoCtrCard_MCrlAxisRelMove(1,2,10,5);
pause(3);

classObj.MoCtrCard_GetEncoderVal(255, classObj.gbAxisEnc);
PosAfterY=classObj.gbAxisEnc(2);
disp (PosAfterY-PosBeforeY);
%Snap a picture now 