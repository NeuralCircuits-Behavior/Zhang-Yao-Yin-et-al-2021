% This function was used to prepare a stack for registration. 
% Usage: 
%    PrepareStack(Folder,Suffix,TargetVolumn,ChangeDirectionToNii,Cut)
%                 Folder: The folder contained all of the slices. 
%                 Suffix: Suffix of the file. '.tif'.
%           TargetVolumn: The volumn to transfer to. Allen Reference Atlas 25um,[ 320   456   528];  10um. [800        1140        1320]
%             SaveFormat: 1, tif. 2, Nii. i.e. [1 2]
%                    Cut: Cut part of the image. i.e. [ 1000 5000 2000 8000] 
% 
% Example: 
% Folder='\\DISKSATION\Data\LightSheetRelated\Image A Brain\20170711_DiI_Coronal\2x\Denoise\StitchedTiff_Yellow';
% Suffix='tif';
% TargetVolumn=[800        1140        1320];
% SaveFormat=[1 2];
% Cut=[];
% PrepareStack(Folder,Suffix,TargetVolumn,SaveFormat)
function PrepareStack(Folder,Suffix,TargetVolumn,SaveFormat,Cut)

    List=dir([Folder,'\*',Suffix]);
    Files=sort_nat({List.name});
    OutputFolder=[Folder,'\','PreparedStack'];
    mkdir(OutputFolder);
    OutputFileNameTif=[OutputFolder,'\','PreparedStack',num2str(TargetVolumn(1)),'_',num2str(TargetVolumn(2)),'_',num2str(TargetVolumn(3)),'.tif'];     
    OutputFileNameNii=[OutputFolder,'\','PreparedStack',num2str(TargetVolumn(1)),'_',num2str(TargetVolumn(2)),'_',num2str(TargetVolumn(3)),'.nii'];    
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
       Im=imresize(Im,[TargetVolumn(1),TargetVolumn(2)],'bilinear');
       ImStack(:,:,n)=Im;
       n=n+1;
    end
    ImStack=imresize3d(ImStack,[],TargetVolumn,'linear');
    if any(SaveFormat==1)
         writeTifFast(OutputFileNameTif,ImStack,16);
    end

    if any(SaveFormat==2)
         ImStack=ChangeDirectionToNii(ImStack);
         ImStack_Nii=make_nii(ImStack);
         save_nii(ImStack_Nii, OutputFileNameNii); 
    end
end


















