
function MakeAStackEndTag(SaveFolder)


SaveFile=[SaveFolder,'ImagingVStackTag.tif'];
SaveFileOri=subsFileExt(SaveFile,'');
n=0;
while 1
    n=n+1;
    if exist(SaveFile,'file')
        SaveFile=[SaveFileOri,'_',num2str(n),'.tif'];
    else
        break;
    end
end

writeTifFast(SaveFile, [6 6 6;8 8 8;9 9 9], 8);
end