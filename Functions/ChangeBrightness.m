%%% This function was used to change brightness. Both 2D and 3D images are
%%% supported. Both single image or a folder containing a stack of images
%%% are supported
%%% Usage:
%%%        ChangeBrightness(Folder,'.tif',ReferenceImageName)
%%%        ChangeBrightness(Folder,[],ReferenceImageName)
%%%        ChangeBrightness('\\DISKSATION\Data\LightSheetRelated\Image A Brain\20170309_YFP\StitchedTiff_RightAndLeft\RegistrationResults\mask\yin.tif';,[],ReferenceImageName)
%%% Yinxin, 20170415


% Folder='\\DISKSATION\Data\LightSheetRelated\Image A Brain\20170711_DiI_Coronal\2x\Denoise\StitchedTiff_Yellow\mask\StitchedStack\';
% Suffix='tif'
% ReferenceImageName=[Folder,'11-Jul-2017_ImageBlue_190_1_Stitched_masked.tif'];
% ChangeBrightness(Folder,Suffix,ReferenceImageName)
function ChangeBrightness(Folder,Suffix,ReferenceImageName)

[FolderBase,filename]=fileparts(Folder);
if isempty(filename)
   if isempty(Suffix)
       Suffix='.tif'; % default tif files.
   end
end
SaveFolder=[Folder,'\ChangeBrightness\'];
mkdir(SaveFolder);
List=dir([Folder,'*',Suffix]);
Files=sort_nat({List.name});
ReferenceImage=loadTifFast(ReferenceImageName);
ReferenceMean=FindMean(ReferenceImage);


for i=1:length(Files)
    CurrentImageName=[Folder,Files{i}];
    CurrentImage=loadTifFast(CurrentImageName);
    SIze=size(CurrentImage);
    if length(SIze)>=3
        for k=1:SIze(3)
           CurrentSection=CurrentImage(:,:,k);
           MeanNow=FindMean(CurrentSection);
           CurrentSection=double(CurrentSection)*double(ReferenceMean/MeanNow); 
           CurrentImage(:,:,k)=CurrentSection;
        end
    else
        MeanNow=FindMean(CurrentImage);
        CurrentImage=double(CurrentImage)*double(ReferenceMean/MeanNow);
    end
    writeTifFast([SaveFolder,List(i).name],CurrentImage,16);
end

end

















