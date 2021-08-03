

function [TimeUsedAll,RunTimes]=MoveOrNot_V2(classObj,TimeConstant,PosOri,Axis)
 tic
%  TimeConstant=200; % ms within which the position remaines unchanged.
 TimeConstant=TimeConstant/1000; % transfer to second
 classObj.MoCtrCard_GetEncoderVal(255, classObj.gbAxisEnc);
 PosFirst=classObj.gbAxisEnc(Axis+1);

 
 n=0;RunTimes=0;
 while 1
     RunTimes=RunTimes+1;
     a=get(0,'UserData');
     classObj=a.classObj;
     classObj.MoCtrCard_GetEncoderVal(255, classObj.gbAxisEnc);
     Pos=classObj.gbAxisEnc(Axis+1);
     if Pos==PosFirst
         if n==0
             TimeStart=toc;
         end
         n=n+1;
         TimeUsedNow=toc;
         if TimeUsedNow-TimeStart>=TimeConstant & abs(Pos-PosOri)>=2
             break;
         end
     else
         n=0;
         PosFirst=Pos;
     end
 end
 TimeUsedAll=toc; 
end
