



MagLow=0.63; % Planning Magnification
MagImaging=2; % Imaging Magnification
OverlapLowImaging=20; % Overlap of the low magnification imaging 
OverlapHighImaging=10; % Overlap of the high magnifiation imaging


% The Grid Size is 2x2
SizeLowImaging=fix(2048*2-2048*OverlapLowImaging/100);
InputVolume=ones(SizeLowImaging,SizeLowImaging);
DownfactorXY=1;
DownfactorZ=1;
CutoffSignal=0;
CutoffImaging=0.01;
[ImagingMatrix,StepStage,StartRowA,EndRowA,StartColumnA,EndColumnA]=FindImagingMatrix(InputVolume,DownfactorXY,DownfactorZ,MagLow,MagImaging,OverlapHighImaging,CutoffSignal,CutoffImaging);
figure
imshow(InputVolume)
hold on
PlotGrids(StartRowA,EndRowA,StartColumnA,EndColumnA,ImagingMatrix);







