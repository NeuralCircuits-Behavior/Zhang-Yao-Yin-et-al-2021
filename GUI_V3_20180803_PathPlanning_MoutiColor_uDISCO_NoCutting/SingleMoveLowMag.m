
WorkShell_SynchronizationLowMag;

% Step=10; % micrometer #
% Step=100; % micrometer #
Step=500; % micrometer #
SleepAfterSnap=0.35; % second #
% SleepAfterSnap=0.6; % second # 


MoveDistance=abs(TranslationZCon);
MoveSpeedN=1;
Step=Step/1000;          
ZCycleT=MoveDistance/Step;
ZCycleN=floor(ZCycleT);
RemainingD=MoveDistance-ZCycleN*Step; % millisecond
% classObj.MoCtrCard_GetEncoderVal(255, classObj.gbAxisEnc);
% PosOriOri=classObj.gbAxisEnc(2+1);


TriggerPulsePal([4]);
for Move=1:ZCycleN
    if GetDi(DirectionPlanning)==1
        DiN=-1;
    else
        DiN=1;
    end
%     classObj.MoCtrCard_GetEncoderVal(255, classObj.gbAxisEnc);
%     PosOri=classObj.gbAxisEnc(2+1);
    classObj.MoCtrCard_MCrlAxisRelMove(2,Step*DiN,MoveSpeedN,1);
    pause(0.3);
%     MoveOrNot_V2(classObj,TimeConstant,PosOri,2)
    TriggerPulsePal([4]);
    pause(SleepAfterSnap);
end



% classObj.MoCtrCard_GetEncoderVal(255, classObj.gbAxisEnc);
% PosEnd=classObj.gbAxisEnc(2+1);
% 
% if (PosEnd-PosOriOri)~=0
%     ComplementD=(PosEnd-PosOriOri)/1000;
%     if ComplementD>0
%         DiN=1;
%     else
%         DiN=-1;
%     end
%     classObj.MoCtrCard_MCrlAxisRelMove(2,ComplementD*DiN,MoveSpeedN,1);
%     MoveOrNot_V2(classObj,TimeConstant,PosEnd,2)
% end
    
