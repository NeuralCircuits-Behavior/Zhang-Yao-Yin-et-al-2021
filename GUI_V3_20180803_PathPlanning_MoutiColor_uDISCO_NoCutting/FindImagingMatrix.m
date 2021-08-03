%%% The procedure is used to find a reasonable pathway from the start point
%%% to the end point, which only captures pictures contaning the brain. The
%%% strategy is to image a whole brain with the smallest magnification. The
%%% imaged low resolution whole brain is used to programme the pathway. 
%%%
%%% Usage: 
%%% [ImagingMatrix,StepStage]=FindImagingMatrix(InputVolume,1,1,0.63,2,10,4000,0.005)
%%% [ImagingMatrix,StepStage]=FindImagingMatrix(InputVolume,DownfactorXY,DownfactorZ,MagLow,MagImaging,Overlap,CutoffSignal,CutoffImaging)
%%% DownfactorXY: downsample factor for X and Y. 1
%%% DownfactorZ: downsample factor for Z. 1
%%% MagLow:  is the low imaging magnification which is used to find the imaging matrix. 
%%% MagImaging:  is the Imaging magnification.
%%% Overlap: the imaging overlap between X , and between Y
%%% CutoffSignal: cutoff which is used to discriminate signal from noise.
%%% It is related to the exposure time. 
%%% CutoffImaging: cutoff which is used to ensure imaging or not. 0.01
%%%
%%% Yinxin, 2016/12/18

function [ImagingMatrix,StepStage,StartRowA,EndRowA,StartColumnA,EndColumnA,ResolutionProgramme,ResolutionImaging,EndRowAV,EndColumnAV]=FindImagingMatrix(InputVolume,DownfactorXY,DownfactorZ,MagLow,MagImaging,Overlap,CutoffSignal,CutoffImaging)

%% Partition the brain to even grids
%read data and downsample
% InputVolume=loadTifFast('D:\Project\Light Sheet\Image A Brain\15-DEC-2016_Tag258YFP\TWOSIDE\Blue0.63\Stack\15-Dec-2016_ImageRed_AllOrigin_50_500.tif');
warning off
Size=size(InputVolume);
% DownfactorXY=1;
% DownfactorZ=1;
if ~DownfactorXY==1
InputVolume=imresize3d(InputVolume,[],[Size(1)/DownfactorXY Size(2)/DownfactorXY Size(3)/DownfactorZ],'nearest');
end
SizeDownSampled=size(InputVolume);
if length(SizeDownSampled)==2
    SizeDownSampled(3)=1;
end

%partition
% MagLow=0.63; %Magnification that is used to programme pathway default Mag=0.63;
% MagImaging=6.3; % Magnification that is used to image
% StepSize=0.32; % the translation resolution. 0.32um/unit.
StepSize=1; % for current stage 2018/7/17
% Overlap=0; % the overlap of the move 
% Step=3000; 


ResolutionProgramme=GetResolution(MagLow);
ResolutionImaging=GetResolution(MagImaging);



FOVImaging=ResolutionImaging*2048; % Field of view in the imaging magnification. um
FOVProgrammeRow=ResolutionProgramme*SizeDownSampled(1); % Field of view in the programme magnification. um 
FOVProgrammeColumn=ResolutionProgramme*SizeDownSampled(2);
Step=FOVImaging - FOVImaging*Overlap/100; % Step real size, um
Step=fix(Step/StepSize)*StepSize;    
display(['Step==',num2str(Step),'um']);
StepStage=fix(Step/StepSize);
display(['StepNumberStage==',num2str(StepStage)]);


GridSizeX= floor(FOVProgrammeColumn/Step)+1; % The last FOV can not exceed the FOVProgramme
GridSizeY= floor(FOVProgrammeRow/Step)+1;  
    
PixelNumberPerStep=Step/(ResolutionProgramme*DownfactorXY);
PixelNumberPerStep=PixelNumberPerStep; % note 
% PixelNumberPerStep=fix(PixelNumberPerStep); % note 
PixelNumberPerImagingFOV=FOVImaging/(ResolutionProgramme*DownfactorXY);
PixelNumberPerImagingFOV=PixelNumberPerImagingFOV; % note 
% PixelNumberPerImagingFOV=fix(PixelNumberPerImagingFOV); % not    
    


%% Find the imaging grids according to previour partition
% mask the brain according to a cutoff 
ImagingMatrix=[];
% CutoffSignal=10000; % cutoff which is used discriminate signal and noise
% CutoffImaging=0.01; %  will capture images in FOV with more than CutoffImaging signal pixels. 
InputVolume(InputVolume<CutoffSignal)=0;
InputVolume(InputVolume>=CutoffSignal)=1;
StartRowA=[];
EndRowA=[];
StartColumnA=[];
EndColumnA=[];

EndRowAV=[];
EndColumnAV=[];
for slice=1:SizeDownSampled(3)
    for row=1:GridSizeY
        for column=1:GridSizeX
            StartRow=1+(row-1)*PixelNumberPerStep;
            EndRow=StartRow+PixelNumberPerImagingFOV-1;
            StartColumn=1+(column-1)*PixelNumberPerStep;
            EndColumn=StartColumn+PixelNumberPerImagingFOV-1;
            EndRowAV(end+1)=EndRow;
            EndColumnAV(end+1)=EndColumn;
            if EndRow>SizeDownSampled(1)
                EndRow=SizeDownSampled(1);
            end
            if EndColumn>SizeDownSampled(2)
                EndColumn=SizeDownSampled(2);
            end
            
            StartRowA(end+1)=StartRow;
            EndRowA(end+1)=EndRow;
            StartColumnA(end+1)=StartColumn;
            EndColumnA(end+1)=EndColumn;
            
            FOVNow=InputVolume(StartRow:EndRow,StartColumn:EndColumn,slice);    
            SignalPixelNumber=sum(FOVNow(:));
            ProportionSignalPixelNumber=SignalPixelNumber/PixelNumberPerImagingFOV.^2;
            if ProportionSignalPixelNumber>=CutoffImaging
                ImagingMatrix(row,column,slice)=1;
            else
                ImagingMatrix(row,column,slice)=0;
            end
        end
    end
end

end


%%

















