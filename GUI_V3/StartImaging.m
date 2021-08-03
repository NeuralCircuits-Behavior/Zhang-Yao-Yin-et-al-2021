%%% This is the main function of imaging. 
%%% Usage: 
%%%     StartImaging(hObject,eventdata,handles)
%%% YX, 20170821



function StartImaging(hObject,eventdata,handles)


%% Initialize

Update;
%% Others

% close/open light

mmc.setSerialPortCommand(portlightRight, ChangeToBlueCloseRight, commandTerminator); 
gui.sleep(10);
mmc.setSerialPortCommand(portlightRight, ChangeToRedCloseRight, commandTerminator); 
gui.sleep(10);
mmc.setSerialPortCommand(portlightRight, ChangeToYellowCloseRight, commandTerminator); 
gui.sleep(10);
mmc.setSerialPortCommand(portlightLeft, ChangeToBlueCloseLeft, commandTerminator); 
gui.sleep(10);
mmc.setSerialPortCommand(portlightLeft, ChangeToRedCloseLeft, commandTerminator); 
gui.sleep(10);
mmc.setSerialPortCommand(portlightLeft, ChangeToYellowCloseLeft, commandTerminator);
gui.sleep(10);



% if BlueImaging==1 & RedImaging==0 & Snap==1
%     mmc.setSerialPortCommand(portlightRight, ChangeToBlueOpenRight, commandTerminator); 
% end
% 
% if BlueImaging==0 & RedImaging==1 & Snap==1
%     mmc.setSerialPortCommand(portlightRight, ChangeToRedOpenRight, commandTerminator); 
% end


% change filter

mmc.setProperty('Wheel-A', 'State', num2str(FilterBlue));
gui.sleep(20);
FilterState=FilterBlue;

%% 



mmc.setSerialPortCommand(port, Normalspeed, commandTerminator); 
gui.sleep(SleepTime1);



%%
if handles.ContinueCheck.Value & isfield(handles.my,'EndImN')
    handles.my.StartImN=handles.my.EndImN+1;
    handles.my.StartZlocation=handles.my.EndZlocation+Zstep;
    StartK=handles.my.StartImN;
    Xlocation=0;Ylocation=0;Zlocation=handles.my.StartZlocation; 
else
    handles.my.StartImN=1;
    handles.my.StartZlocation=0;
    StartK=1;
    Xlocation=0;Ylocation=0;Zlocation=0; 
end

% guidata(hObject,handles);
%% Start moving and imaging. You should first move to the top left 
for k=StartK:Zcycle % z 
    namei=1;
    pause(0.1)   
    while 1
       if handles.StartImaging.Value==1 | handles.Break.Value==1
           break;
       else
           pause(0.1);
%            guidata(hObject,handles);
       end
    end
    if handles.Break.Value==1
        SaveConfigure(handles);
        handles.StartImaging.Value=0;
        handles.Break.Value=0;
        break;
    end
    if handles.Update.Value==1
        Update;
        SaveConfigure(handles);
        handles.my.StartImN=k;
        handles.my.StartZlocation=Zlocation;
        guidata(hObject,handles);
        handles.Update.Value=0;
        pause(0.01);
    end
    
    for j=1:Ycycle % y
        nameip=1;
        namein=Xcycle;
        % Get images
        if Snap==1            
            %Snap a picture
            SnapAImage;
            display(['Xlocation:',num2str(Xlocation),'      Ylocation:',num2str(Ylocation),'      Zlocation:',num2str(Zlocation),'    Snap'])               
        end
          
        if Xcycle~=1 % in case that the Xcycle==1
            for i=1:Xcycle-1 % x
                if mod(j,2)==1
                    TranslationX=TranslationXP;
                    nameip=nameip+1;
                    namei=nameip;
                    DeltaX=Xstep;
                else
                    TranslationX=TranslationXN;
                    namein=namein-1;
                    namei=namein;
                    DeltaX=-Xstep;
                end
                % move X
                mmc.setSerialPortCommand(port, TranslationX, commandTerminator);
                gui.sleep(SleepTime2X);
                Xlocation=Xlocation+DeltaX;
                display(['Xlocation:',num2str(Xlocation),'      Ylocation:',num2str(Ylocation),'      Zlocation:',num2str(Zlocation),'     MoveX Snap'])             

                if Snap==1
                    tic
                   SnapAImage;
                   toc
                end 
           end
        else %if Xcycle~=1
           if Snap==1
               SnapAImage;
           end
               display(['Xlocation:',num2str(Xlocation),'      Ylocation:',num2str(Ylocation),'      Zlocation:',num2str(Zlocation),'     Snap'])             
        end
        
        
        if j==Ycycle
        else
            DeltaY=Ystep;
            mmc.setSerialPortCommand(port, TranslationY, commandTerminator);
            gui.sleep(SleepTime2Y);
            Ylocation=Ylocation+DeltaY;
            display(['Xlocation:',num2str(Xlocation),'      Ylocation:',num2str(Ylocation),'      Zlocation:',num2str(Zlocation),'    MoveY'])                  
        end
    end %j
    
    % reture to zero point
    TranslationZeroX=['X-',num2str(Xlocation)];
    TranslationZeroY=['Y+',num2str(Ylocation)];
    if Xlocation~=0
        mmc.setSerialPortCommand(port, TranslationZeroX, commandTerminator);
        gui.sleep(SleepTime3X);
        Xlocation=0;
    end
    display(['Xlocation:',num2str(Xlocation),'      Ylocation:',num2str(Ylocation),'      Zlocation:',num2str(Zlocation),'   ReturnX']);  
    if Ylocation~=0
        mmc.setSerialPortCommand(port, TranslationZeroY, commandTerminator);
        gui.sleep(SleepTime3Y);
        Ylocation=0;
    end
    display(['Xlocation:',num2str(Xlocation),'      Ylocation:',num2str(Ylocation),'      Zlocation:',num2str(Zlocation),'   ReturnY']);  
    
    
    
    %To Cut
    if mod((k-1)*Zstep,Zcut)==0 & k~=1 %&  k~=Zcycle % &
        Arduino_LeicaVibratome;
        %ready to cut
        mmc.setSerialPortCommand(port, CutspeedReady, commandTerminator); 
        gui.sleep(SleepTime1);
        mmc.setSerialPortCommand(port, TranslationCutReady, commandTerminator);
        gui.sleep(SleepTime4);
        
        %return overlap
        mmc.setSerialPortCommand(port, TranslationReturnZ, commandTerminator);
        gui.sleep(SleepTimeCut2);
        %Complete difference between the light and vibratome
        mmc.setSerialPortCommand(port, Normalspeed, commandTerminator);
        gui.sleep(SleepTime1);
        mmc.setSerialPortCommand(port, TranslationZdifference, commandTerminator); 
        gui.sleep(SleepTime12);
        
        
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
                ZreturnFirst=['Z-',num2str(ZreturnFirstStep)];
                mmc.setSerialPortCommand(port, 'V255', commandTerminator); 
                gui.sleep(SleepTime1);
                mmc.setSerialPortCommand(port, ZreturnFirst, commandTerminator);
                gui.sleep(SleepTime11);
                
                Cut=Cut-MaxCuttingThickness;
                TranslationCutReturnMy=['X+',num2str(CutStepCutting)];
                SleepTimeMy=SleepTime10;
            elseif Cut<=MaxCuttingThickness & CutNum==1
                BreakTag=1;
                TranslationCutReturnMy=TranslationCutReturn;
                SleepTimeMy=SleepTime6;
            elseif Cut>MaxCuttingThickness & CutNum>1
                ZCutNext=['Z+',num2str(MaxCuttingThickness)];
                mmc.setSerialPortCommand(port, 'V255', commandTerminator); 
                gui.sleep(SleepTime1);
                mmc.setSerialPortCommand(port, ZCutNext, commandTerminator);
                gui.sleep(SleepTime11);
                Cut=Cut-MaxCuttingThickness;
                TranslationCutReturnMy=['X+',num2str(CutStepCutting)];
                SleepTimeMy=SleepTime10;
            elseif  Cut<=MaxCuttingThickness & CutNum>1
                ZCutNext=['Z+',num2str(Cut)];
                mmc.setSerialPortCommand(port, 'V255', commandTerminator); 
                gui.sleep(SleepTime1);
                mmc.setSerialPortCommand(port, ZCutNext, commandTerminator);
                gui.sleep(SleepTime11);
                BreakTag=1;
                TranslationCutReturnMy=TranslationCutReturn;
                SleepTimeMy=SleepTime6;
            else 
                BreakTag=1;
                TranslationCutReturnMy=TranslationCutReturn;
                SleepTimeMy=SleepTime6;
            
            end
            %Cutting
            mmc.setSerialPortCommand(port, CutspeedCutting, commandTerminator); 
            gui.sleep(SleepTime1);
            mmc.setSerialPortCommand(port, TranslationCutCutting, commandTerminator);
            gui.sleep(SleepTime5); 
            %Return Z, ready to return
            mmc.setSerialPortCommand(port, ReturnZmove, commandTerminator);
            gui.sleep(SleepTimeCut2);
            %Reverse difference between the light and vibratome
            if BreakTag==1
                mmc.setSerialPortCommand(port, Normalspeed, commandTerminator);
                gui.sleep(SleepTime1);
                mmc.setSerialPortCommand(port, TranslationZdifferenceReverse, commandTerminator); 
                gui.sleep(SleepTime12);
            end
            %Start returning
            mmc.setSerialPortCommand(port, CutspeedReady, commandTerminator); 
            gui.sleep(SleepTime1);
            mmc.setSerialPortCommand(port, TranslationCutReturnMy, commandTerminator);
            gui.sleep(SleepTimeMy);
            %Reverse Z returning
            mmc.setSerialPortCommand(port, ReturnZmoveReverse, commandTerminator);
            gui.sleep(SleepTimeCut2);
            if BreakTag==1
                break;
            end
        end
        Arduino_LeicaVibratome;
    end
    

    handles.my.EndImN=k; % The last image number
    handles.my.EndZlocation=Zlocation; % The last image Z location
   
    % Z translation
    if k==Zcycle
        SaveConfigure(handles);
    else
    DeltaZ=Zstep;
    mmc.setSerialPortCommand(port, TranslationZ, commandTerminator);                   
    gui.sleep(SleepTime2Z);
    Zlocation=Zlocation+DeltaZ;
    display(['Xlocation:',num2str(Xlocation),'      Ylocation:',num2str(Ylocation),'      Zlocation:',num2str(Zlocation),'    Move Z, Current Location'] ) % This is the current location, and images have not yet been collected.
    end
    
    
    
    
    % Save images
    if Snap==2
        if BlueImaging==1 
             BlueImageNameLeft=[SavedFoldName,date,'_','ImageBlueLeft','_',num2str(k)];
             BlueImageNameRight=[SavedFoldName,date,'_','ImageBlueRight','_',num2str(k)];
             SIze=size(ImageBlueRight);
             switch length(SIze)
                 case 2
                     r=1;c=1;e=1;
                 case 3
                     r=SIze(3);c=1;e=1;
                 case 4
                     r=SIze(3);c=SIze(4);e=1;
                 case 5
                     r=SIze(3);c=SIze(4);e=SIze(5);
             end
             
             for ex=1:e
                 for col=1:c
                     for raw=1:r
                         BlueImageNameLeftN=[BlueImageNameLeft,'_',num2str(ex),'_',num2str(col),'_',num2str(raw)];
                         BlueImageNameRightN=[BlueImageNameRight,'_',num2str(ex),'_',num2str(col),'_',num2str(raw)];
                         if exist('ImageBlueLeft')
                             if c+LeftImaging>Ycycle
                                 switch SaveType
                                     case 1
                                        save(BlueImageNameLeftN,'ImageBlueLeft');
                                     case 2 
                                        writeTifFast([BlueImageNameLeftN,'.tif'],ImageBlueLeft(:,:,raw,col),16);
                                     case 3 
                                        imwrite(ImageBlueLeft(:,:,raw,col),BlueImageNameLeftN,'Mode','lossless','Bitdepth', 16)
                                 end
                             end
                         end
                         if exist('ImageBlueRight')
                           if c<=RightImaging
                                 switch SaveType
                                     case 1 
                                         save(BlueImageNameRightN,'ImageBlueRight');
                                     case 2
                                         writeTifFast([BlueImageNameRightN,'.tif'],ImageBlueRight(:,:,raw,col),16);
                                     case 3
                                         imwrite(ImageBlueRight(:,:,raw,col),BlueImageNameRightN,'Mode','lossless','Bitdepth', 16)
                                 end
                           end
                         end
                     end
                 end
             end
%              clear ImageBlue BlueImageNameDifExposure
        end
        if RedImaging==1
             RedImageNameLeft=[SavedFoldName,date,'_','ImageRedLeft','_',num2str(k)];
             RedImageNameRight=[SavedFoldName,date,'_','ImageRedRight','_',num2str(k)];
             SIze=size(ImageRedRight);
             switch length(SIze)
                 case 2
                     r=1;c=1;e=1;
                 case 3
                     r=SIze(3);c=1;e=1;
                 case 4
                     r=SIze(3);c=SIze(4);e=1;
                 case 5
                     r=SIze(3);c=SIze(4);e=SIze(5);
             end
             
             for ex=1:e
                 for col=1:c
                     for raw=1:r
                          RedImageNameLeftN=[RedImageNameLeft,'_',num2str(ex),'_',num2str(col),'_',num2str(raw)];
                          RedImageNameRightN=[RedImageNameRight,'_',num2str(ex),'_',num2str(col),'_',num2str(raw)];
                          if exist('ImageRedLeft')
                               if c+LeftImaging>Ycycle
                                     switch SaveType
                                         case 1
                                            save(RedImageNameLeftN,'ImageRedLeft');
                                         case 2 
                                            writeTifFast([RedImageNameLeftN,'.tif'],ImageRedLeft(:,:,raw,col),16);
                                         case 3 
                                            imwrite(ImageRedLeft(:,:,raw,col),RedImageNameLeftN,'Mode','lossless','Bitdepth', 16)
                                     end
                               end
                          end
                          if exist('ImageRedRight')
                              if c<=RightImaging
                                     switch SaveType
                                         case 1
                                             save(RedImageNameRightN,'ImageRedRight');
                                         case 2 
                                             writeTifFast([RedImageNameRightN,'.tif'],ImageRedRight(:,:,raw,col),16);
                                         case 3 
                                             imwrite(ImageRedRight(:,:,raw,col),RedImageNameRightN,'Mode','lossless','Bitdepth', 16)
                                     end
                              end
                          end
                     end
                 end
             end
%              clear ImageBlue BlueImageNameDifExposure
        end
        
        if YellowImaging==1
             YellowImageNameLeft=[SavedFoldName,date,'_','ImageYellowLeft','_',num2str(k)];
             YellowImageNameRight=[SavedFoldName,date,'_','ImageYellowRight','_',num2str(k)];
             SIze=size(ImageYellowRight);
             switch length(SIze)
                 case 2
                     r=1;c=1;e=1;
                 case 3
                     r=SIze(3);c=1;e=1;
                 case 4
                     r=SIze(3);c=SIze(4);e=1;
                 case 5
                     r=SIze(3);c=SIze(4);e=SIze(5);
             end
             
             for ex=1:e
                 for col=1:c
                     for raw=1:r
                          YellowImageNameLeftN=[YellowImageNameLeft,'_',num2str(ex),'_',num2str(col),'_',num2str(raw)];
                          YellowImageNameRightN=[YellowImageNameRight,'_',num2str(ex),'_',num2str(col),'_',num2str(raw)];
                          if exist('ImageYellowLeft')
                               if c+LeftImaging>Ycycle
                                     switch SaveType
                                         case 1
                                            save(YellowImageNameLeftN,'ImageYellowLeft');
                                         case 2 
                                            writeTifFast([YellowImageNameLeftN,'.tif'],ImageYellowLeft(:,:,raw,col),16);
                                         case 3 
                                            imwrite(ImageYellowLeft(:,:,raw,col),YellowImageNameLeftN,'Mode','lossless','Bitdepth', 16)
                                     end
                               end
                          end
                          if exist('ImageYellowRight')
                              if c<=RightImaging
                                     switch SaveType
                                         case 1
                                             save(YellowImageNameRightN,'ImageYellowRight');
                                         case 2 
                                             writeTifFast([YellowImageNameRightN,'.tif'],ImageYellowRight(:,:,raw,col),16);
                                         case 3 
                                             imwrite(ImageYellowRight(:,:,raw,col),YellowImageNameRightN,'Mode','lossless','Bitdepth', 16)
                                     end
                              end
                          end
                     end
                 end
             end
%              clear ImageBlue BlueImageNameDifExposure
        end
    end
    


    
end

display(['Finished:']);datetime('now')
end



%%







