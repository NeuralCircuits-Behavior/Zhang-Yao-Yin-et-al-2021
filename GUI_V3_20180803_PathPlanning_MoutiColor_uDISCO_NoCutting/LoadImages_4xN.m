% Suppose imaging matrix was 2x2 with a order from the topleft, topright,
% downright, downleft

function InputVolumn =LoadImages_4xN(SaveFolder,OverLapLowMag,ImagesPerStackPlanning,ReferenceName,Overlap)
%    LastImageNum=DetectLastImageNum(SaveFolder);
   
   
   Overlap=Overlap*100;
   
   load([SaveFolder,'ImageLastNumPlanning.mat']);
   load([SaveFolder,'DirectionAllPlanning.mat']);
   load([SaveFolder,'RightOrWrongPlanning.mat']);
   
   RightIndex=find(RightOrWrongPlanning);
%    if length(RightIndex)~=4
%       error('Snap wrong images with low Mag! in LoadImages_4xN')
%    end
   
   for i=1:4 %length(RightIndex)
       CurrentIndex=RightIndex(end-(4-i));
       ImageStartN=ImageNumAfterAStackPlanning(CurrentIndex)+1;
       ImageEndN=ImageNumAfterAStackPlanning(CurrentIndex)+ImagesPerStackPlanning;
       
       OriginalImage=loadTifFast([SaveFolder 'Image1_' num2str(ImageStartN) '.tif']);
       for j=ImageStartN+1:ImageEndN
           ImageName=[SaveFolder 'Image1_' num2str(j) '.tif'];
           CurrentImage=loadTifFast(ImageName);
           IndexB=CurrentImage>OriginalImage;
           OriginalImage(IndexB)=CurrentImage(IndexB);
       end
       Im(:,:,5-i)=OriginalImage;
   end
   
   % temp
%    TopLeft=loadTifFast(ReferenceName.TopLeft);
%    TopRight=loadTifFast(ReferenceName.TopRight);
%    DownRight=loadTifFast(ReferenceName.DownRight);
%    DownLeft=loadTifFast(ReferenceName.DownLeft);
%    
%    Mean=(mean(TopLeft(:))+mean(TopRight(:))+mean(DownRight(:))+mean(DownLeft(:)))/(4);
%    TopLeft=TopLeft/Mean;
%    TopRight=TopRight/Mean;
%    DownRight=DownRight/Mean;
%    DownLeft=DownLeft/Mean;
%    
%    Im(:,:,1)=(Im(:,:,1)-100)./DownLeft;
%    Im(:,:,2)=(Im(:,:,2)-100)./DownRight;
%    Im(:,:,3)=(Im(:,:,3)-100)./TopRight;
%    Im(:,:,4)=(Im(:,:,4)-100)./TopLeft;
   
   % writeTifFast
   SaveNameDownLeft=[SaveFolder '\ImageLowPlanning_2_1.tif'];
   SaveNameDownRight=[SaveFolder '\ImageLowPlanning_2_2.tif'];
   SaveNameTopRight=[SaveFolder '\ImageLowPlanning_1_2.tif'];
   SaveNameTopLeft=[SaveFolder '\ImageLowPlanning_1_1.tif'];
   
   writeTifFast(SaveNameDownLeft,Im(:,:,1),16);
   writeTifFast(SaveNameDownRight,Im(:,:,2),16);
   writeTifFast(SaveNameTopRight,Im(:,:,3),16);
   writeTifFast(SaveNameTopLeft,Im(:,:,4),16);
   
   % stitch
   StitchedTiff=[SaveFolder,'\StichPlanning\'];
   mkdir(StitchedTiff);
   ImagePrefix='ImageLowPlanning';
   Suffix='.tif';
   ImagePatternNow=[ImagePrefix,'_','{y}','_','{x}',Suffix];
   disp(['Processing Image...    ', ImagePatternNow]);
   compute_overlap=0;
   
   Commander=['Grid/Collection stitching '...
               'type=[Filename defined position] order=[Defined by filename         ] '...
               'grid_size_x='...
               num2str(2)...
               ' grid_size_y='...
               num2str(2)...
               ' tile_overlap='...
               num2str(Overlap)...
               ' first_file_index_x=1 first_file_index_y=1 '...
               'directory=['...
               SaveFolder...
               '] '...
               'file_names='...
               ImagePatternNow ...
               ' output_textfile_name=TileConfiguration.txt '...
               'fusion_method=[Linear Blending] '...
               'regression_threshold=0.3 max/avg_displacement_threshold=2.50 absolute_displacement_threshold=3.50 '...
               compute_overlap...
               ' computation_parameters=[Save computation time (but use more RAM)] image_output=[Fuse and display]'];
     %'fusion_method=[Linear Blending] '... compute_overlap
     SaveName=[StitchedTiff,'\',ImagePrefix,'_Stitched.tif'];
     MIJ.run('Grid/Collection stitching', Commander);
     SaveCommander=['save=','[',SaveName,']'];
     SaveCommander=strrep(SaveCommander,'\','\\');
%      MIJ.run('Subtract Background...', 'rolling=100');
     MIJ.run('Save', SaveCommander);
     MIJ.run('Close');
   
     
     % load images
     InputVolumn=loadTifFast(SaveName);
     
   
   
   
   
   
   
   
   
%    OverLapPix=fix(2048*OverLapLowMag);
%    RemainingPix=2048-OverLapPix;
%    InputVolumn=zeros(2048+RemainingPix,2048+RemainingPix);
%    
%    InputVolumn(1:2048,1:2048)=Im(:,:,4);
%    InputVolumn(1:2048,2049:end)=Im(:,OverLapPix+1:end,3);
%    
%    InputVolumn(2049:end,1:2048)=Im(OverLapPix+1:end,:,1);
%    InputVolumn(2049:end,2049:end)=Im(OverLapPix+1:end,OverLapPix+1:end,2);
   
end
