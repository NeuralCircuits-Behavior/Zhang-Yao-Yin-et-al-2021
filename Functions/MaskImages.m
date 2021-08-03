% It was used to delete noises occured in the lightsheet related images. 
% Usage:
%       MaskImages(folder,'denoised.tif')
%           folder: folder that stitched brain slices were stored
%           Cutoff: border of signal and noisy. Usually, you should choose a cutoff bigger than the noise. Default, 2000.      
%           suffix: file suffix. default, 'tif'. 
%      fudgeFactor: sensitivity to detect border. Smaller, more sensitive. Default, 0.1.
%      DilateThick: line thickness to delineate the outline of the brain.
%  RemovePixelSize: remove area with pixel less than RemovePixelSize. Default,100000
%      Clearborder: clear detected border. 1, clear. 0, does not clear. Default, 0      
% Yinxin 20170414

% folder=' \\DISKSATION\Data\LightSheetRelated\Image A Brain\20170711_DiI_Coronal\2x\Denoise\StitchedTiff_Yellow\';
% Cutoff=2000;
% suffix='tif';
% fudgeFactor=0.2;
% DilateThick=20;
% RemovePixelSize=100000;
% Clearborder=0;
% MaskImages(folder,Cutoff,suffix,fudgeFactor,DilateThick,RemovePixelSize,Clearborder)
function MaskImages(folder,Cutoff,suffix,fudgeFactor,DilateThick,RemovePixelSize,Clearborder)
     

    % initialization
    if ~exist('Cutoff') | length(Cutoff)==0
        Cutoff=2000;
    end
    if ~exist('suffix') | length(suffix)==0
        suffix='tif';
    end
    if ~exist('fudgeFactor') | length(fudgeFactor)==0
        fudgeFactor=0.1;
    end
    if ~exist('DilateThick') | length(DilateThick)==0
        DilateThick=20;
    end
    if ~exist('RemovePixelSize') | length(RemovePixelSize)==0
        RemovePixelSize=100000;
    end    
    if ~exist('Clearborder') | length(Clearborder)==0
        Clearborder=0;
    end
    
    SaveFolder=[folder,'\mask\'];
    mkdir(SaveFolder);
    List=dir([folder,'*',suffix]); % 'denoised.tif'
    Files=sort_nat({List.name});
    
    for i=1:length(Files)
        ImName=[folder,'\',Files{i}];
        SaveName=strrep(Files{i},'.tif','');
        SaveName=[SaveFolder,SaveName,'_masked.tif'];
        Im=loadTifFast(ImName);
        if i<100
            DilateThick=100;
        end
        Mask=EdgeDetection(Im,fudgeFactor,DilateThick,RemovePixelSize,Clearborder,Cutoff);
        Im=double(Im).*double(Mask);
        writeTifFast(SaveName,Im,16);
    end

end








