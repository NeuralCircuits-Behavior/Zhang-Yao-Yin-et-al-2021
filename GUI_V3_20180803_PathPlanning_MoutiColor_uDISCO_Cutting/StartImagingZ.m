%%% This is the main function of imaging. 
%%% Usage: 
%%%     StartImaging(hObject,eventdata,handles)
%%% YX, 20170821



function StartImagingZ(hObject,eventdata,handles)


%% Initialize
Update;
query(Wheel, FilterStr(FilterBlue), '%c\n');
FilterState=FilterBlue;
%% continure or not
if handles.ContinueCheck.Value
    if handles.my.EscapLocation==1 
        TagSnap=0;
        handles.my.StartImJ=handles.my.EndImJ;
        handles.my.StartImI=handles.my.EndImI;
        handles.my.StartImStack=handles.my.EndImStack;
    elseif handles.my.EscapLocation==2
        TagSnap=0;
        handles.my.StartImJ=handles.my.EndImJ;
        handles.my.StartImI=handles.my.EndImI+1;
        handles.my.StartImStack=handles.my.EndImStack;
    end
    
    Xdirection=handles.my.Xdirection;
    Ydirection=handles.my.Ydirection;
    Zdirection=handles.my.Zdirection;
    Xlocation=handles.my.Xlocation;
    Ylocation=handles.my.Ylocation;
    
    StartS=handles.my.StartImStack;
    StartI=handles.my.StartImI;
    StartJ=handles.my.StartImJ;
else
    TagSnap=1;
    handles.my.StartImStack=1;
    handles.my.StartImI=1;
    handles.my.StartImJ=1;
    
    Xdirection=XdirectionI; 
    Ydirection=YdirectionI; 
    Zdirection=ZdirectionI; 
    Xlocation=0;Ylocation=0;
    
    StartS=1;
    StartI=1;
    StartJ=1;
    Step=1;
    EndJ=Ycycle;
end

guidata(hObject,handles);
%% Start moving and imaging. You should first move to the top left 
StackNow=0;
ImageNumAfterAStack=DetectLastImageNum(SaveFolder);
DirectionAll=[];
RightOrWrong=[]; % 1 right, 0 wrong
for s=StartS:Zstacks
    for j=StartJ:Step:EndJ % y
        VoltageSampledRightN=VoltageSampledRight(j,:);
        VoltageSampledLeftN=VoltageSampledLeft(j,:);
%         SetCameralETLVoltageTrain;
        WorkShell_Synchronization;
        % Get images
        if TagSnap~=0
            TagSnap=1;
            StackNow=StackNow+1;
            display(['Stack:',num2str(s), '      Xlocation:',num2str(Xlocation),'      Ylocation:',num2str(Ylocation),'    Snap'])               
            eval(SnapTag);
            handles.my.EscapLocation=1;
%             % judege stop or update after each stack;
            Judge;
            if handles.Break.Value==1
                  handles.StartImaging.Value=0;
                  guidata(hObject,handles);
                  break;
            end
           
        end
        if Xcycle~=1 % in case that the Xcycle==1
            for i=StartI:Xcycle-1 % x
                if Xdirection>0
                    TranslationX=TranslationXP;
                    DeltaX=Xstep;
                else
                    TranslationX=TranslationXN;
                    DeltaX=-Xstep;
                end
                % move X                
                classObj.MoCtrCard_MCrlAxisRelMove(0,TranslationX,Normalspeed,Acceleration);
                %   pause(SleepTime2X);
                classObj.MoCtrCard_GetEncoderVal(255, classObj.gbAxisEnc);
                PosOri=classObj.gbAxisEnc(1);
                TimeConstant=200;
                [TimeUsedi,RunTimes]=MoveOrNot_X(classObj,TimeConstant,PosOri);


                Xlocation=Xlocation+DeltaX;
                display(['Stack:',num2str(s), '      Xlocation:',num2str(Xlocation),'      Ylocation:',num2str(Ylocation),'     MoveX Snap'])             
                % get images
                StackNow=StackNow+1;
                eval(SnapTag);
                handles.my.EscapLocation=2;
                % judege stop or update after each stack; 
                Judge;
                if handles.Break.Value==1
                      handles.StartImaging.Value=0;
                      guidata(hObject,handles);
                      break;
                end
           end
        end %if Xcycle~=1
        
        if (j~=Ycycle & Step>0) |  (j~=1 & Step<0)        
            if Ydirection>0
                TranslationY=TranslationYP;
                DeltaY=Ystep;
            else
                TranslationY=TranslationYN;
                DeltaY=-Ystep;
            end
            
            classObj.MoCtrCard_MCrlAxisRelMove(1,TranslationY,Normalspeed,Acceleration);
            %  pause(SleepTime2Y);
            classObj.MoCtrCard_GetEncoderVal(255, classObj.gbAxisEnc);
            PosOri=classObj.gbAxisEnc(2);
            TimeConstant=200;
            [TimeUsedi,RunTimes]=MoveOrNot_Y(classObj,TimeConstant,PosOri);


            Ylocation=Ylocation+DeltaY;
            display(['Stack:',num2str(s), '      Xlocation:',num2str(Xlocation),'      Ylocation:',num2str(Ylocation),'    MoveY'])                  
        end
        Xdirection=-1*Xdirection;
    end %j
    Ydirection=-1*Ydirection;
    ToCut;
    Zdirection=ZdirectionI; % initilize Z direction
    Step=-1*Step; T=EndJ;  EndJ=StartJ; StartJ=T; % change J direction
    
    % judge stop or update after each stack; 
    Judge;
    if handles.Break.Value==1
          handles.StartImaging.Value=0;
          guidata(hObject,handles);
          break;
    end
end



if ~exist('i')  |  exist('i')==5
    i=1;
end
handles.my.EndImStack=s;
handles.my.EndImI=i;
handles.my.EndImJ=j;
handles.my.Xdirection=Xdirection;
handles.my.Ydirection=Ydirection;
handles.my.Zdirection=Zdirection;
handles.my.Xlocation=Xlocation;
handles.my.Ylocation=Ylocation;
SaveConfigure(handles);


