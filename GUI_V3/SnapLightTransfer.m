
%% Start Imaging Blue
if BlueImaging==1 
    if FilterState~=FilterBlue
       query(Wheel, FilterStr(FilterBlue), '%c\n');; 
%        pause(SleepTime9);
       FilterState=FilterBlue;
    end
    % left imaging  
    if Ycycle-LeftImaging<j
          SetPulsePalVoltage(2,VoltageSampledLeft(1));
          pause(SleepTime8);
          SetPulsePalVoltageNew(1,10); 
          pause(SleepTime7);   
          TriggerPulsePal([4]);
          pause(SleepTime8);  
          SetPulsePalVoltageNew(1,0); 
    end
    %right imaging
    if RightImaging>=j
          SetPulsePalVoltage(1,VoltageSampledRight(1));
          pause(SleepTime8);
          SetPulsePalVoltageNew(2,10); 
          pause(SleepTime7);
          TriggerPulsePal([4])
          pause(SleepTime8);
          SetPulsePalVoltageNew(2,0); 
     end
end

%% Start Imaging Red
if RedImaging==1
    % change filter
    if FilterState~=FilterRed
       query(Wheel, FilterStr(FilterRed), '%c\n');
%        pause(SleepTime9);
       FilterState=FilterRed;
    end
    % left imaging  
    if Ycycle-LeftImaging<j
          SetPulsePalVoltage(2,VoltageSampledLeft(1));
          pause(SleepTime8);
          SetPulsePalVoltageNew(3,10); 
          pause(SleepTime7); 
          TriggerPulsePal([4])
          pause(SleepTime8); 
          SetPulsePalVoltageNew(3,0); 
    end
    %right imaging
    if RightImaging>=j
          SetPulsePalVoltage(1,VoltageSampledRight(1));
          pause(SleepTime8);
          SetPulsePalVoltageNew(4,10); 
          pause(SleepTime7);          
          TriggerPulsePal([4])
          pause(SleepTime8); 
          SetPulsePalVoltageNew(4,0); 
     end
end


%% Start Imaging Yellow
if YellowImaging==1
    % change filter
    if FilterState~=FilterYellow;
       query(Wheel, FilterStr(FilterYellow), '%c\n');
%        pause(SleepTime9);
       FilterState=FilterYellow;
    end
    % left imaging  
    if Ycycle-LeftImaging<j 
          SetPulsePalVoltage(2,VoltageSampledLeft(1));
          pause(SleepTime8);
          SetPulsePalVoltageNew(3,10); 
          pause(SleepTime7); 
          TriggerPulsePal([4])
          pause(SleepTime8); 
          SetPulsePalVoltageNew(3,0); 
    end
    %right imaging
    if RightImaging>=j
          SetPulsePalVoltage(1,VoltageSampledRight(1));
          pause(SleepTime8);
          SetPulsePalVoltageNew(4,10); 
          pause(SleepTime7);          
          TriggerPulsePal([4])
          pause(SleepTime8);  
          SetPulsePalVoltageNew(4,0); 
     end
end
