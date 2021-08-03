%a=get(0,'UserData');

Images=200;
MoveStep=-0.005; % mm
Normalspeed=0.5;
Acceleration=0.5;
for i=1:Images
   SetPulsePalVoltage(3,3.3);
   pause(0.004);
   SetPulsePalVoltage(3,0);
   classObj.MoCtrCard_MCrlAxisRelMove(2,MoveStep,Normalspeed,Acceleration);
   pause(0.8);  
end
% 
% SetPulsePalVoltageNew(2,2)
% classObj.MoCtrCard_MCrlAxisRelMove(2,-1,1,1);
% 
% 
% classObj.MoCtrCard_MCrlAxisRelMoveAndPulse(2,1,3,0.06,0.002,0.002,...
%     0.001,0.001,20);
% 
% 
% 
% 
% 
% 
% 
% classObj.MoCtrCard_MCrlAxisRelMove(2,-0.001,0.001,0.001);
% 
% classObj.MoCtrCard_GetEncoderVal(255, classObj.gbAxisEnc);
% Pos=classObj.gbAxisEnc(3);
% disp (Pos);
% 
% 
% 
