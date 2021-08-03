% This function was used to stitch a stack of images. 



% Folder='\\DISKSATION\Data\LightSheetRelated\Image A Brain\20170711_DiI_Coronal\2x\Denoise\StitchedTiff_Yellow\mask\';
% ImagePrefix='11-Jul-2017_ImageBlue_';
% ImageSuffix='_1_Stitched_masked.tif';
% StartImage=1;
% Zoverlap=600;
% ZStep=60;
% Zcut=2400;
% Threshhold=0;
% FindSimilar=0;
% RemoveLink=0;
function StitchingStacks(Folder,ImagePrefix,ImageSuffix,StartImage,Zoverlap,ZStep,Zcut,Threshhold,FindSimilar,RemoveLink)

 SaveFolder=[Folder,'\StitchedStack\'];
 OtherImages=[SaveFolder,'OtherImages'];
 mkdir(SaveFolder);
 mkdir(OtherImages);
 
 Around=4;
 SlicesPerStack=Zcut/ZStep;
 FileLength=length(dir([Folder,'\*',ImageSuffix]));
 
 % copy the first stack to the SaveFolder
 EndImage=(fix((StartImage-1)/(SlicesPerStack+1))+1)*SlicesPerStack+1;
 for i=StartImage:EndImage
     Source=[Folder,'\',ImagePrefix,num2str(i),ImageSuffix];
     Target=[SaveFolder,'\',ImagePrefix,num2str(i),ImageSuffix];
     if ~exist(Source)
         warning(['Could not find source image:',Source]);
         return
     end
     copyfile(Source,Target)
 end
 
 % find the deduced relationship of two adjacent stacks
 StartStack=fix((StartImage-1)/(SlicesPerStack+1))+1;
 SliceGap=Zoverlap/ZStep;
 if floor(SliceGap)~=SliceGap
     warning('The SliceGap is not a integer!');
     return
 end
 SecondImagesIndex=StartStack*SlicesPerStack+2:SlicesPerStack:FileLength+StartImage-1; % The index of first image  
 DeducedFirstImagesIndex=SecondImagesIndex-SliceGap;
 
 if StartImage>DeducedFirstImagesIndex(1)
     SecondImagesIndex(1)=StartImage+10;
     DeducedFirstImagesIndex(1)=StartImage;
 end
 
 SecondImagesIndex=SecondImagesIndex;
 FirstImagesIndex=DeducedFirstImagesIndex;
 % find similar images
 if FindSimilar==1
     
     
     
 end
 
 % do registration
 for i=1:length(SecondImagesIndex)
    MovingImageName=[Folder,ImagePrefix,num2str(SecondImagesIndex(i)),ImageSuffix];
    FixedImageName=[Folder,ImagePrefix,num2str(FirstImagesIndex(i)),ImageSuffix];
    Fixed=loadTifFast(FixedImageName);
    Moving=loadTifFast(MovingImageName);
    
    FixedMasked=Fixed;
    MovingMasked=Moving;
    
    % mask images
    FixedMasked(FixedMasked<Threshhold)=0;
    MovingMasked(MovingMasked<Threshhold)=0;

    % remove larger link area
    if RemoveLink==1
        LB = 10;
        UB = 200;
        FixedMasked= xor(bwareaopen(FixedMasked,LB),  bwareaopen(FixedMasked,UB));
        MovingMasked = xor(bwareaopen(MovingMasked,LB),  bwareaopen(MovingMasked,UB));
        FixedMasked=int8(FixedMasked);
        MovingMasked=int8(MovingMasked);
    end
    
    % registration
    [optimizer, metric] = imregconfig('multimodal');
    optimizer.GrowthFactor=1.01;
    optimizer.InitialRadius=optimizer.InitialRadius/10;
    optimizer.Epsilon=optimizer.Epsilon/10;
    [movingRegistered, R_reg,tForm]= imregister(MovingMasked, FixedMasked, 'translation', optimizer, metric);
    
    % transform all related images
    Rfixed = imref2d(size(FixedMasked));
    EndImagesIndex(i)=SecondImagesIndex(i)+SlicesPerStack-1;
    if EndImagesIndex(i)>FileLength+StartImage-1
        EndImagesIndex(i)=FileLength+StartImage-1;
    end
    for j=SecondImagesIndex(i):EndImagesIndex(i)
        WaitTransform=loadTifFast([Folder,ImagePrefix,num2str(j),ImageSuffix]);
        Rmoving = imref2d(size(WaitTransform));
        [movingReg,Rreg] = imwarp(WaitTransform,Rmoving,tForm,'OutputView',Rfixed);
        writeTifFast([SaveFolder,ImagePrefix,num2str(j),ImageSuffix],movingReg,16)
    end
 end
    

 % move overlapped file to 
 MoveDirection=1; % move the first stack(1) or the second stack(2). 
 if MoveDirection==1
     MoveStartIndex=FirstImagesIndex;
     MoveEndIndex=FirstImagesIndex+SliceGap-1;
 elseif MoveDirection==2
     MoveStartIndex=SecondImagesIndex;
     MoveEndIndex=SecondImagesIndex+SliceGap-1;
     if MoveEndIndex(end)>FileLength+StartImage-1
         MoveEndIndex(end)=FileLength+StartImage-1;
     end  
 end
 for i=1:length(MoveStartIndex)
     for j=MoveStartIndex(i):MoveEndIndex(i)
         movefilename=[SaveFolder, ImagePrefix, num2str(j),ImageSuffix];
         movefile(movefilename,OtherImages);
     end
 end
 

 
end


















































