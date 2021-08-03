% This function was used to downsample slices into a specific
% resolution in order to construct a 3D volumn. The output is a 3D volumn
% with corresponding resolution.
% Usage: 
%   DownsampleSclicesData(Folder,Suffix,Magnification,TargetPixelResolution,Cut)
%                 Folder: The folder contained all of the slices. 
%                 Suffix: Suffix of the file. '.tif'.
%          Magnification: The imaging magnification. (1:0.63) (2:0.8) (3:1) (4:1.25) (5:1.6) (6:2) (7:2.5)  (8:3.2) (9:4) (10:5) (11:6.3)   
%  TargetPixelResolution: The resolution you want to transfer.
%                  ZStep: The translation step of Z. (30)
%                    Cut: You may hope to cut part of the slice. It is a 2D vector. 
% 
% For example
% Folder='\\DISKSATION\Data\LightSheetRelated\Image A Brain\20170711_DiI_Coronal\2x\Denoise\StitchedTiff_Yellow';
% Suffix='tif';
% Magnification=6;
% TargetPixelResolution=10;
% ZStep=60;
% DownsampleSclicesData(Folder,Suffix,Magnification,TargetPixelResolution,ZStep)
% YX, 20170715
function DownsampleSclicesData(Folder,Suffix,Magnification,TargetPixelResolution,ZStep,Cut)
    List=dir([Folder,'/*',Suffix]);
    Files=sort_nat({List.name});
    PixelResolution=[10.3520,8.1433,6.5274,5.2083,4.0800,3.2744,2.6164,2.0400,1.6228,1.2870,1.0401]/2;
    PixelResolution=PixelResolution(Magnification);
    ScaleXY=TargetPixelResolution/PixelResolution;
    ScaleZ=TargetPixelResolution/(ZStep*0.3125);
    OutputFolder=[Folder,'\','Downsampled',num2str(TargetPixelResolution),'um'];
    mkdir(OutputFolder);
    OutputFileName=[OutputFolder,'\','Downsampled',num2str(TargetPixelResolution),'um.tif'];
    n=1;
    for i=1:length(Files)
       FullName=[Folder,'/',Files{i}];
       Im=loadTifFast(FullName);
       if exist('Cut')
           if length(Cut)==4
               Im=Im(Cut(1):Cut(2),Cut(3):Cut(4));
           elseif length(Cut)>1
               display('Wrong Cut')
           end
       end
       Size=size(Im);
       TargetSize=fix(Size/ScaleXY);
       Im=imresize(Im,TargetSize,'bilinear');
       ImStack(:,:,n)=Im;
       n=n+1;
    end
    SizeS=size(ImStack);
    SizeS=[SizeS(1) SizeS(2) fix(SizeS(3)/ScaleZ)];
    ImStack=imresize3d(ImStack,[],SizeS,'linear');
    writeTifFast(OutputFileName,ImStack,16);
end
























