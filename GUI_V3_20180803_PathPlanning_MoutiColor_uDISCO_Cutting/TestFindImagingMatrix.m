tic
InputVolume=loadTifFast('C:\Users\GuoLab\Desktop\FusedUnshapeMask0.6.tif');
% InputVolume=ones(2048,2048);
% mean(InputVolume(:))
% std(double(InputVolume(:)))
DownfactorXY=1;
DownfactorZ=1;
MagLow=2;
MagImaging=6.3;
Overlap=10;
CutoffSignal=1700;
% CutoffSignal=0;
CutoffImaging=0.01;
[ImagingMatrix,StepStage,StartRowA,EndRowA,StartColumnA,EndColumnA]=FindImagingMatrix(InputVolume,DownfactorXY,DownfactorZ,MagLow,MagImaging,Overlap,CutoffSignal,CutoffImaging);
figure
imshow(InputVolume,[1 7000])
hold on
% imshow(InputVolume)
PlotGrids(StartRowA,EndRowA,StartColumnA,EndColumnA,ImagingMatrix);
toc

% a=regionprops(InputVolume,'Centroid')