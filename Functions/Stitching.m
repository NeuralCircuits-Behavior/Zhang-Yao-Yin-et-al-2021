%%% This function is used to stitch images. It supports stitching multi
%%% colors, and stitching left images, right images or combine of the two
%%% sides. It also supports ComputeOverlap or not.
%%% Parameters: 
%%%          StitchingColor: 1 Blue, 2 Red, 3 Yellow
%%%          StitchingSide:  1 Left, 2 Right, 3 combine two sides
%%%          Overlap: Overlap between adjacent images. 
%%%          ComputeOverlap: 1 computeOverlap, 2 did not compute overlap
%%% Usage:
%%%          Stitching(Folder,[1 2 3],[1 2 3],0.31,0,0)
%%% Yinxin, 20170415


% Folder='\\DISKSATION\Data\LightSheetRelated\Image A Brain\20170412_YFP_2x\Coronal1_258\'
% Overlap=34.58 %for 2x
% StitchingColor=[1]
% StitchingSide=[3];
% ComputeOverlap=0;
% Stitching(Folder,StitchingColor,StitchingSide,Overlap,ComputeOverlap)

function Stitching(Folder,StitchingColor,StitchingSide,Overlap,ComputeOverlap)

if ~exist('MIJ')
    Miji;
end

[FolderBase,fileName]=fileparts(Folder);
if fileName
    Folder=[Folder,'\'];
end

% find image prefix and image pattern
ListBlue=dir([Folder,'*Blue*tif']);
ListRed=dir([Folder,'*Red*tif']);
ListYellow=dir([Folder,'*Yellow*tif']);

if ~isempty(ListBlue)
    for i=1:length(ListBlue)
      pat='_';
      PatIndex=regexpi(ListBlue(i).name,pat);
      if ~isempty(str2num(ListBlue(i).name(PatIndex(5)+2)))
          PatIndex(6)=PatIndex(5)+3;
      else
          PatIndex(6)=PatIndex(5)+2;
      end
      ImagePrefix{i}=ListBlue(i).name(1:PatIndex(1)-1);
      ImageColor{i}=ListBlue(i).name(PatIndex(1)+1:PatIndex(2)-1);
      ImageSection{i}=ListBlue(i).name(PatIndex(2)+1:PatIndex(3)-1);
      ImageExposure{i}=ListBlue(i).name(PatIndex(3)+1:PatIndex(4)-1);
      ImageRaw{i}=ListBlue(i).name(PatIndex(4)+1:PatIndex(5)-1);
      ImageColumn{i}=ListBlue(i).name(PatIndex(5)+1:PatIndex(6)-1);
      ImageSuffix{i}=ListBlue(i).name(PatIndex(6):end);
    end
    PrefixBlue=unique(ImagePrefix);
    ColorBlue=unique(ImageColor);
    SectionBlue=unique(ImageSection);
    ExposureBlue=length(unique(ImageExposure));
    RawBlue=length(unique(ImageRaw));
    ColumnBlue=length(unique(ImageColumn));
    SuffixBlue=unique(ImageSuffix);
elseif StitchingColor==1
    display(['No blue images found! good luck!']);
    return;
end
clear Image*
if ~isempty(ListRed)
    for i=1:length(ListRed)
      pat='_';
      PatIndex=regexpi(ListRed(i).name,pat);
      if ~isempty(str2num(ListRed(i).name(PatIndex(5)+2)))
          PatIndex(6)=PatIndex(5)+3;
      else
          PatIndex(6)=PatIndex(5)+2;
      end
      ImagePrefix{i}=ListRed(i).name(1:PatIndex(1)-1);
      ImageColor{i}=ListRed(i).name(PatIndex(1)+1:PatIndex(2)-1);
      ImageSection{i}=ListRed(i).name(PatIndex(2)+1:PatIndex(3)-1);
      ImageExposure{i}=ListRed(i).name(PatIndex(3)+1:PatIndex(4)-1);
      ImageRaw{i}=ListRed(i).name(PatIndex(4)+1:PatIndex(5)-1);
      ImageColumn{i}=ListRed(i).name(PatIndex(5)+1:PatIndex(6)-1);
      ImageSuffix{i}=ListRed(i).name(PatIndex(6):end);
    end
    PrefixRed=unique(ImagePrefix);
    ColorRed=unique(ImageColor);
    SectionRed=unique(ImageSection);
    ExposureRed=length(unique(ImageExposure));
    RawRed=length(unique(ImageRaw));
    ColumnRed=length(unique(ImageColumn));
    SuffixRed=unique(ImageSuffix);
elseif StitchingColor==2
    display(['No red images found! good luck!']);
    return;
end

clear Image*
if ~isempty(ListYellow)
    for i=1:length(ListYellow)
      pat='_';
      PatIndex=regexpi(ListYellow(i).name,pat);
      if ~isempty(str2num(ListBlue(i).name(PatIndex(5)+2)))
          PatIndex(6)=PatIndex(5)+3;
      else
          PatIndex(6)=PatIndex(5)+2;
      end
      ImagePrefix{i}=ListYellow(i).name(1:PatIndex(1)-1);
      ImageColor{i}=ListYellow(i).name(PatIndex(1)+1:PatIndex(2)-1);
      ImageSection{i}=ListYellow(i).name(PatIndex(2)+1:PatIndex(3)-1);
      ImageExposure{i}=ListYellow(i).name(PatIndex(3)+1:PatIndex(4)-1);
      ImageRaw{i}=ListYellow(i).name(PatIndex(4)+1:PatIndex(5)-1);
      ImageColumn{i}=ListYellow(i).name(PatIndex(5)+1:PatIndex(6)-1);
      ImageSuffix{i}=ListYellow(i).name(PatIndex(6):end);
    end
    PrefixYellow=unique(ImagePrefix);
    ColorYellow=unique(ImageColor);
    SectionYellow=unique(ImageSection);
    ExposureYellow=length(unique(ImageExposure));
    RawYellow=length(unique(ImageRaw));
    ColumnYellow=length(unique(ImageColumn));
    SuffixYellow=unique(ImageSuffix);
elseif StitchingColor==3
    display(['No yellow images found! good luck!']);
    return;
end
clear Image*



if  ComputeOverlap==1
    compute_overlap='compute_overlap';
else 
    compute_overlap='';
end


StitchedTiff=[Folder,'\StitchedTiff\'];
mkdir(StitchedTiff);
for Color=StitchingColor
    if Color==1
        Exposures=1:ExposureBlue;
        Sections=SectionBlue;
        ImagePrefix=[PrefixBlue{1},'_ImageBlue'];
        Raw=RawBlue;
        Column=ColumnBlue;
        Suffix=SuffixBlue;
    elseif Color==2
        Exposures=1:ExposureRed;
        Sections=SectionRed;
        ImagePrefix=[PrefixRed{1},'_ImageRed'];
        Raw=RawRed;
        Column=ColumnRed;
        Suffix=SuffixRed;
    elseif Color==3
        Exposures=1:ExposureYellow;
        Sections=SectionYellow;
        ImagePrefix=[PrefixYellow{1},'_ImageYellow'];
        Raw=RawYellow;
        Column=ColumnYellow;
        Suffix=SuffixYellow;
    end
    for Side=StitchingSide
        if Side==1
            ImagePrefix=[ImagePrefix,'Left_'];
        elseif Side==2
            ImagePrefix=[ImagePrefix,'Right_'];
        elseif Side==3
            ImagePrefixLeft=[ImagePrefix,'Left_']; 
            ImagePrefixRight=[ImagePrefix,'Right_'];
            ImagePrefix=[ImagePrefix,'_']; 
        end
        % Start stitching images one by one
        for i=1%:length(Sections)
            SectionNow=str2num(Sections{i});
            for e=Exposures
                % change name
                if Side==3
                    for j=1:Column
                        for k=1:Raw/2
                            FullNameRight=[Folder, ImagePrefixRight, num2str(SectionNow),'_',num2str(e),'_',num2str(k),'_',num2str(j),Suffix{1}];
                            FullNameLeft=[Folder,ImagePrefixLeft,num2str(SectionNow),'_',num2str(e),'_',num2str(k+Raw/2),'_',num2str(j),Suffix{1}];
                            ChangedNameRight=[Folder,ImagePrefix,num2str(SectionNow),'_',num2str(e),'_',num2str(k),'_',num2str(j),Suffix{1}];
                            ChangedNameLeft=[Folder,ImagePrefix,num2str(SectionNow),'_',num2str(e),'_',num2str(k+Raw/2),'_',num2str(j),Suffix{1}];
                            if exist(ChangedNameLeft,'file')
                               movefile(ChangedNameLeft,FullNameLeft);
                            end
                            movefile(FullNameLeft,ChangedNameLeft);
                            if exist(ChangedNameRight,'file')
                               movefile(ChangedNameRight,FullNameRight);
                            end
                            movefile(FullNameRight,ChangedNameRight);
                        end
                    end
                end
                ImagePatternNow=[ImagePrefix,num2str(SectionNow),'_',num2str(e),'_','{y}','_','{x}',Suffix{1}];
                disp(['Processing Image...    ', ImagePatternNow]);
                Commander=['Grid/Collection stitching '...
                           'type=[Filename defined position] order=[Defined by filename         ] '...
                           'grid_size_x='...
                           num2str(Column)...
                           ' grid_size_y='...
                           num2str(Raw)...
                           ' tile_overlap='...
                           num2str(Overlap)...
                           ' first_file_index_x=1 first_file_index_y=1 '...
                           'directory=['...
                           Folder...
                           '] '...
                           'file_names='...
                           ImagePatternNow ...
                           ' output_textfile_name=TileConfiguration.txt '...
                           'fusion_method=[Linear Blending] '...
                           'regression_threshold=0.3 max/avg_displacement_threshold=2.50 absolute_displacement_threshold=3.50 '...
                           compute_overlap...
                           ' computation_parameters=[Save computation time (but use more RAM)] image_output=[Fuse and display]'];
                 %'fusion_method=[Linear Blending] '... compute_overlap
                 SaveName=[StitchedTiff,'\',ImagePrefix,num2str(SectionNow),'_',num2str(e),'_Stitched.tif'];
                 MIJ.run('Grid/Collection stitching', Commander)
                 SaveCommander=['save=','[',SaveName,']'];
                 SaveCommander=strrep(SaveCommander,'\','\\');
                 MIJ.run('Save', SaveCommander);
                 MIJ.run('Close')
                 % rename    
                 if Side==3
                    for j=1:Column
                        %ImagePatternNow=[ImagePrefix,num2str(i),'_',num2str(e),'_','{y}','_','{x}','.tif','_denoised.tif'];        
                        for k=1:Raw/2
                            FullNameRight=[Folder,ImagePrefixRight,num2str(SectionNow),'_',num2str(e),'_',num2str(k),'_',num2str(j),Suffix{1}];
                            FullNameLeft=[Folder,ImagePrefixLeft,num2str(SectionNow),'_',num2str(e),'_',num2str(k+Raw/2),'_',num2str(j),Suffix{1}];
                            ChangedNameRight=[Folder,ImagePrefix,num2str(SectionNow),'_',num2str(e),'_',num2str(k),'_',num2str(j),Suffix{1}];
                            ChangedNameLeft=[Folder,ImagePrefix,num2str(SectionNow),'_',num2str(e),'_',num2str(k+Raw/2),'_',num2str(j),Suffix{1}];
                            movefile(ChangedNameLeft,FullNameLeft);
                            movefile(ChangedNameRight,FullNameRight);
                        end
                    end
                 end
            end

        end
        
    end
end

end

