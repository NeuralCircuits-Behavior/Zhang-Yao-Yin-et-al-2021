Arduino_LeicaVibratome;


% if exist('ChangeToCloseRight')
    SetPulsePalVoltageNew(ColorRight,0); 
    SetPulsePalVoltageNew(ColorLeft,0); 
% end
% in case that the current Z location is the same as initial location
if Zdirection>0
   if exist('TranslationZCon')
       classObj.MoCtrCard_MCrlAxisRelMove(2,abs(TranslationZCon)*-1,Normalspeed,Acceleration);
   else
       classObj.MoCtrCard_MCrlAxisRelMove(2,abs(TranslationZ*(ZImages-1))*-1,Normalspeed,Acceleration);
   end
%    pause(4);

classObj.MoCtrCard_GetEncoderVal(255, classObj.gbAxisEnc);
PosOri=classObj.gbAxisEnc(3);
TimeConstant=200;
[TimeUsedi,RunTimes]=MoveOrNot(classObj,TimeConstant,PosOri);

end

% decide the current X location
if Xdirection>0
    TranslationCutReady=TranslationCutReadyS;
    TranslationCutReturn=TranslationCutReturnS;
else
    TranslationCutReady=TranslationCutReadyL;
    TranslationCutReturn=TranslationCutReturnL;
end


%ready to cut
TranslationCutReady;
classObj.MoCtrCard_MCrlAxisRelMove(0,TranslationCutReady,CutspeedReady,Acceleration);
% pause(SleepTime4);

classObj.MoCtrCard_GetEncoderVal(255, classObj.gbAxisEnc);
PosOri=classObj.gbAxisEnc(1);
TimeConstant=200;
[TimeUsedi,RunTimes]=MoveOrNot_X(classObj,TimeConstant,PosOri);


%return overlap
classObj.MoCtrCard_MCrlAxisRelMove(2,TranslationReturnZ,Normalspeed,Acceleration);
% pause(SleepTimeCut2);
classObj.MoCtrCard_GetEncoderVal(255, classObj.gbAxisEnc);
PosOri=classObj.gbAxisEnc(3);
TimeConstant=200;
[TimeUsedi,RunTimes]=MoveOrNot(classObj,TimeConstant,PosOri);


%Correct difference   the light and vibratome
classObj.MoCtrCard_MCrlAxisRelMove(2,TranslationZdifference,Normalspeed,Acceleration); 
% pause(SleepTime12);
classObj.MoCtrCard_GetEncoderVal(255, classObj.gbAxisEnc);
PosOri=classObj.gbAxisEnc(3);
TimeConstant=200;
[TimeUsedi,RunTimes]=MoveOrNot(classObj,TimeConstant,PosOri);




Cut=Zcut-Zoverlap;
TranslationCutReturnMy=[];
CutNum=0;
BreakTag=0;


while 1
    CutNum=CutNum+1;
    display(['Cut num:',num2str(CutNum)]);
    if Cut>MaxCuttingThickness & CutNum==1
        % first return Z
        ZreturnFirstStep=Cut-MaxCuttingThickness;
        ZreturnFirst=ZreturnFirstStep;
        classObj.MoCtrCard_MCrlAxisRelMove(2,ZreturnFirst,Normalspeed,Acceleration); 
        %         pause(SleepTime11);
        classObj.MoCtrCard_GetEncoderVal(255, classObj.gbAxisEnc);
        PosOri=classObj.gbAxisEnc(3);
        TimeConstant=200;
        [TimeUsedi,RunTimes]=MoveOrNot(classObj,TimeConstant,PosOri);
        Cut=Cut-MaxCuttingThickness;
        TranslationCutReturnMy=CutStepCutting*-1;
        SleepTimeMy=SleepTime10;
    elseif Cut<=MaxCuttingThickness & CutNum==1
        BreakTag=1;
        TranslationCutReturnMy=TranslationCutReturn;
        SleepTimeMy=SleepTime6;
    elseif Cut>MaxCuttingThickness & CutNum>1
        ZCutNext=MaxCuttingThickness*-1;
        classObj.MoCtrCard_MCrlAxisRelMove(2,ZCutNext,Normalspeed,Acceleration); 
        %         pause(SleepTime11);
        classObj.MoCtrCard_GetEncoderVal(255, classObj.gbAxisEnc);
        PosOri=classObj.gbAxisEnc(3);
        TimeConstant=200;
        [TimeUsedi,RunTimes]=MoveOrNot(classObj,TimeConstant,PosOri);


        Cut=Cut-MaxCuttingThickness;
        TranslationCutReturnMy=CutStepCutting*-1;
        SleepTimeMy=SleepTime10;
    elseif  Cut<=MaxCuttingThickness & CutNum>1
        ZCutNext=Cut*-1;
        classObj.MoCtrCard_MCrlAxisRelMove(2,ZCutNext,Normalspeed,Acceleration);      
        %         pause(SleepTime11);
        classObj.MoCtrCard_GetEncoderVal(255, classObj.gbAxisEnc);
        PosOri=classObj.gbAxisEnc(3);
        TimeConstant=200;
        [TimeUsedi,RunTimes]=MoveOrNot(classObj,TimeConstant,PosOri);


        BreakTag=1;
        TranslationCutReturnMy=TranslationCutReturn;
        SleepTimeMy=SleepTime6;
    else 
        BreakTag=1;
        TranslationCutReturnMy=TranslationCutReturn;
        SleepTimeMy=SleepTime6;

    end
    %Cutting
%   classObj.MoCtrCard_MCrlAxisRelMove(0,TranslationCutCutting,CutspeedCutting,Acceleration);  
    classObj.MoCtrCard_MCrlAxisRelMove(0,TranslationCutCutting,0.4,Acceleration);
    %     pause(SleepTime5); 
    classObj.MoCtrCard_GetEncoderVal(255, classObj.gbAxisEnc);
    PosOri=classObj.gbAxisEnc(1);
    TimeConstant=200;
    [TimeUsedi,RunTimes]=MoveOrNot_X(classObj,TimeConstant,PosOri);


    %Return Z, ready to return
    classObj.MoCtrCard_MCrlAxisRelMove(2,ReturnZmove,Normalspeed,Acceleration);       
    %     pause(SleepTimeCut2);
    classObj.MoCtrCard_GetEncoderVal(255, classObj.gbAxisEnc);
    PosOri=classObj.gbAxisEnc(3);
    TimeConstant=200;
    [TimeUsedi,RunTimes]=MoveOrNot(classObj,TimeConstant,PosOri);


    %Reverse difference between the light and vibratome
    if BreakTag==1
        classObj.MoCtrCard_MCrlAxisRelMove(2,TranslationZdifferenceReverse,Normalspeed,Acceleration);       
        %         pause(SleepTime12);
        classObj.MoCtrCard_GetEncoderVal(255, classObj.gbAxisEnc);
        PosOri=classObj.gbAxisEnc(3);
        TimeConstant=200;
        [TimeUsedi,RunTimes]=MoveOrNot(classObj,TimeConstant,PosOri);

    end
    %Start returning
    classObj.MoCtrCard_MCrlAxisRelMove(0,TranslationCutReturnMy,CutspeedReady,Acceleration);
    %     pause(SleepTimeMy);
    classObj.MoCtrCard_GetEncoderVal(255, classObj.gbAxisEnc);
    PosOri=classObj.gbAxisEnc(1);
    TimeConstant=200;
    [TimeUsedi,RunTimes]=MoveOrNot_X(classObj,TimeConstant,PosOri);

    %Reverse Z returning
    classObj.MoCtrCard_MCrlAxisRelMove(2,ReturnZmoveReverse,Normalspeed,Acceleration);       
%     pause(SleepTimeCut2);
classObj.MoCtrCard_GetEncoderVal(255, classObj.gbAxisEnc);
PosOri=classObj.gbAxisEnc(3);
TimeConstant=200;
[TimeUsedi,RunTimes]=MoveOrNot(classObj,TimeConstant,PosOri);


    if BreakTag==1
        break;
    end
end
Arduino_LeicaVibratome;
