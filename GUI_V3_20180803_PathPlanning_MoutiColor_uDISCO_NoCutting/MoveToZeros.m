
OriginalLocation=[31200 3398];
DeltaPermitted=1;
PaTime=1;
break1=0;
break2=0;
while 1
      classObj.MoCtrCard_GetEncoderVal(255, classObj.gbAxisEnc);
      PosX=classObj.gbAxisEnc(1);
      classObj.MoCtrCard_GetEncoderVal(255, classObj.gbAxisEnc);
      PosY=classObj.gbAxisEnc(2);
      CurrentPosition=[PosX PosY];
      DeltaPostion=double(CurrentPosition)-OriginalLocation;
      if DeltaPostion(1)>DeltaPermitted
          classObj.MoCtrCard_MCrlAxisRelMove(0,DeltaPostion(1)/1000*-1,1,1);%(Axis,RelativePosition,Speed,Acceleration).
          pause(PaTime);
          break1=0;
      else
          break1=1;
      end
      if DeltaPostion(2)>DeltaPermitted
          classObj.MoCtrCard_MCrlAxisRelMove(1,DeltaPostion(2)/1000*-1,1,1);%(Axis,RelativePosition,Speed,Acceleration)
          pause(PaTime);
          break2=0;
      else
          break2=1;
      end
      
      if break1==1 & break2==1
          break;
      end
      
      pause(0.1) 
end

 
classObj.MoCtrCard_GetEncoderVal(255, classObj.gbAxisEnc);
PosX=classObj.gbAxisEnc(1);



classObj.MoCtrCard_GetEncoderVal(255, classObj.gbAxisEnc);
PosY=classObj.gbAxisEnc(2);


display(['Original Pos: [' num2str(OriginalLocation(1)) ',' num2str(OriginalLocation(2)) ']' ])

display(['Current Pos: [' num2str(PosX) ',' num2str(PosY) ']' ])




