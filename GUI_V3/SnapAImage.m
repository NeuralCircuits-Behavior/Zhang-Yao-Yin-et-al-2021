% Start Imaging Blue
if BlueImaging==1 
    if FilterState~=FilterBlue
       mmc.setProperty('Wheel-A', 'State', num2str(FilterBlue)); 
%        gui.sleep(SleepTime9);
       FilterState=FilterBlue;
    end
    % left imaging  
    if Ycycle-LeftImaging<j
          SetPulsePalVoltage(2,VoltageSampledLeft(1));
          mmc.setSerialPortCommand(portlightLeft, ChangeToBlueOpenLeft, commandTerminator);
          gui.sleep(SleepTime7);
          ExposureNumber=0;
          for ExposureTime=ExposureBlueLeft
              ExposureNumber=ExposureNumber+1;
              if ExposureDefault~=1
                  mmc.setExposure(ExposureTime);
              end
              if Synchronization==1
                SetPulsePalVoltage(2,StartVoltageLeft);
                gui.sleep(SleepInitialVoltage)
              end
              if Snapcombine==1                     
%                   ImageBlueLeft(:,:,namei,j,ExposureNumber)=SnapCombine(VoltageSampledLeft,2,mmc,gui);
%                   SnapCombine_V2(VoltageSampledLeft,2,IJ,gui,SavedFoldName,'BlueLeft',ExposureNumber,namei,j,k);
                    TriggerPulsePal([4]);
              else
                  mmc.snapImage();
                  img = mmc.getImage();
                  ImageBlueLeft(:,:,namei,j,ExposureNumber)=TransferImage(img); 
              end
          end
          
          gui.sleep(SleepTime8);  
          SetPulsePalVoltage(1,VoltageSampledRight(1))
          mmc.setSerialPortCommand(portlightLeft, ChangeToBlueCloseLeft, commandTerminator);      
                
    end
    %right imaging
    if RightImaging>=j
          SetPulsePalVoltage(1,VoltageSampledRight(1));
          mmc.setSerialPortCommand(portlightRight, ChangeToBlueOpenRight, commandTerminator);
          gui.sleep(SleepTime7);
          ExposureNumber=0;
          for ExposureTime=ExposureBlueRight
              ExposureNumber=ExposureNumber+1;
              if ExposureDefault~=1
                  mmc.setExposure(ExposureTime);
              end
              if Synchronization==1
                SetPulsePalVoltage(1,StartVoltageRight);
                gui.sleep(SleepInitialVoltage)
              end
              if Snapcombine==1
%                   ImageBlueRight(:,:,namei,j,ExposureNumber)=SnapCombine(VoltageSampledRight,1,mmc,gui);
%                     SnapCombine_V2(VoltageSampledRight,1,IJ,gui,SavedFoldName,'BlueRight',ExposureNumber,namei,j,k);
                    TriggerPulsePal([4])
              else
                  mmc.snapImage();
                  img = mmc.getImage(); 
                  ImageBlueRight(:,:,namei,j,ExposureNumber)=TransferImage(img);
              end
          end
          gui.sleep(SleepTime8);
          SetPulsePalVoltage(2,VoltageSampledLeft(1));
          mmc.setSerialPortCommand(portlightRight, ChangeToBlueCloseRight, commandTerminator);
         
     end
end

% Start Imaging Red
if RedImaging==1
    % change filter
    if FilterState~=FilterRed
       mmc.setProperty('Wheel-A', 'State', num2str(FilterRed)); 
%        gui.sleep(SleepTime9);
       FilterState=FilterRed;
    end
    % left imaging  
    if Ycycle-LeftImaging<j       
          mmc.setSerialPortCommand(portlightLeft, ChangeToRedOpenLeft, commandTerminator);
          gui.sleep(SleepTime7); 
          ExposureNumber=0;
          for ExposureTime=ExposureRedLeft
              ExposureNumber=ExposureNumber+1;
              if ExposureDefault~=1
                  mmc.setExposure(ExposureTime);
              end
              if Synchronization==1
                SetPulsePalVoltage(2,StartVoltageLeft);
                gui.sleep(SleepInitialVoltage)
              end
              if Snapcombine==1
%                   ImageRedLeft(:,:,namei,j,ExposureNumber)=SnapCombine(VoltageSampledLeft,2,mmc,gui);
%                     SnapCombine_V2(VoltageSampledLeft,2,IJ,gui,SavedFoldName,'RedLeft',ExposureNumber,namei,j,k);
                    TriggerPulsePal([4])
              else
                  mmc.snapImage();
                  img = mmc.getImage(); 
                  ImageRedLeft(:,:,namei,j,ExposureNumber)=TransferImage(img); 
              end
          end
          gui.sleep(SleepTime8); 
          mmc.setSerialPortCommand(portlightLeft, ChangeToRedCloseLeft, commandTerminator);      
      
    end
    %right imaging
    if RightImaging>=j
          mmc.setSerialPortCommand(portlightRight, ChangeToRedOpenRight, commandTerminator);
          gui.sleep(SleepTime7);          
          ExposureNumber=0;
          for ExposureTime=ExposureRedRight
              ExposureNumber=ExposureNumber+1;
              if ExposureDefault~=1
                  mmc.setExposure(ExposureTime);
              end
              if Synchronization==1
                SetPulsePalVoltage(1,StartVoltageRight);
                gui.sleep(SleepInitialVoltage)
              end
              if Snapcombine==1
%                   ImageRedRight(:,:,namei,j,ExposureNumber)=SnapCombine(VoltageSampledRight,1,mmc,gui);
%                     SnapCombine_V2(VoltageSampledRight,1,IJ,gui,SavedFoldName,'RedRight',ExposureNumber,namei,j,k);
                    TriggerPulsePal([4])
              else
                  mmc.snapImage();
                  img = mmc.getImage(); 
                  ImageRedRight(:,:,namei,j,ExposureNumber)=TransferImage(img);
              end
          end
          gui.sleep(SleepTime8); 
          mmc.setSerialPortCommand(portlightRight, ChangeToRedCloseRight, commandTerminator);
            
     end
end


% Start Imaging Yellow
if YellowImaging==1
    % change filter
    if FilterState~=FilterYellow;
       mmc.setProperty('Wheel-A', 'State', num2str(FilterYellow)); 
%        gui.sleep(SleepTime9);
       FilterState=FilterYellow;
    end
    % left imaging  
    if Ycycle-LeftImaging<j       
          mmc.setSerialPortCommand(portlightLeft, ChangeToYellowOpenLeft, commandTerminator);
          gui.sleep(SleepTime7); 
          ExposureNumber=0;
          for ExposureTime=ExposureYellowLeft
              ExposureNumber=ExposureNumber+1;
              if ExposureDefault~=1
                  mmc.setExposure(ExposureTime);
              end
              if Synchronization==1
                SetPulsePalVoltage(2,StartVoltageLeft);
                gui.sleep(SleepInitialVoltage)
              end
              if Snapcombine==1
%                   ImageYellowLeft(:,:,namei,j,ExposureNumber)=SnapCombine(VoltageSampledLeft,2,mmc,gui);
%                     SnapCombine_V2(VoltageSampledLeft,2,IJ,gui,SavedFoldName,'YellowLeft',ExposureNumber,namei,j,k);
                    TriggerPulsePal([4])
              else
                  mmc.snapImage();
                  img = mmc.getImage(); 
                  ImageYellowLeft(:,:,namei,j,ExposureNumber)=TransferImage(img); 
              end
          end
          gui.sleep(SleepTime8); 
          mmc.setSerialPortCommand(portlightLeft, ChangeToYellowCloseLeft, commandTerminator);      
          
    end
    %right imaging
    if RightImaging>=j
          mmc.setSerialPortCommand(portlightRight, ChangeToYellowOpenRight, commandTerminator);
          gui.sleep(SleepTime7);          
          ExposureNumber=0;
          for ExposureTime=ExposureYellowRight
              ExposureNumber=ExposureNumber+1;
              if ExposureDefault~=1
                  mmc.setExposure(ExposureTime);
              end
              if Synchronization==1
                SetPulsePalVoltage(1,StartVoltageRight);
                gui.sleep(SleepInitialVoltage)
              end
              if Snapcombine==1
%                   ImageYellowRight(:,:,namei,j,ExposureNumber)=SnapCombine(VoltageSampledRight,1,mmc,gui);
%                     SnapCombine_V2(VoltageSampledRight,1,IJ,gui,SavedFoldName,'YellowRight',ExposureNumber,namei,j,k);
                    TriggerPulsePal([4])
              else
                  mmc.snapImage();
                  img = mmc.getImage(); 
                  ImageYellowRight(:,:,namei,j,ExposureNumber)=TransferImage(img);
              end
          end
          gui.sleep(SleepTime8);  
          mmc.setSerialPortCommand(portlightRight, ChangeToYellowCloseRight, commandTerminator);
            
     end
end
