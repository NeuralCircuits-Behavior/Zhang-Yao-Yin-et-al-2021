function MoveToADestination(CurrentLocation,DestiLocation,classObj,StepUnit,Speed,Acceleration,TimeConstant)
    

    DestiLocation=fix(DestiLocation);
    CurrentLocation=fix(CurrentLocation);
    DeltaMove=(DestiLocation-CurrentLocation)/1000;
    if DeltaMove(1)~=0
        PosOri=GetCurrentStageLocation(classObj,1);
        classObj.MoCtrCard_MCrlAxisRelMove(1,DeltaMove(1)*StepUnit*-1,Speed,Acceleration);
        [TimeUsedAll,RunTimes]=MoveOrNot_V2(classObj,TimeConstant,PosOri,1);
    end
    
    if DeltaMove(2)~=0
        PosOri=GetCurrentStageLocation(classObj,0);
        classObj.MoCtrCard_MCrlAxisRelMove(0,DeltaMove(2)*StepUnit*-1,Speed,Acceleration);
        [TimeUsedAll,RunTimes]=MoveOrNot_V2(classObj,TimeConstant,PosOri,0);
    end
end