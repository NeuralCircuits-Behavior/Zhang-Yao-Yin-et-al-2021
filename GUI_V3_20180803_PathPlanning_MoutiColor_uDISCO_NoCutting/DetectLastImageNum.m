function LastImageNum=DetectLastImageNum(SaveFolder)
  Files=dir([SaveFolder,'Image*_*.tif']);
  
  if isempty(Files)
      LastImageNum=0;
      return;
  end
  for i=1:length(Files)
      FileName=Files(i).name;
      FileName=strsplit(FileName,'_');
      FileName=FileName{2};
      FileNameNum(i)=str2num(strrep(FileName,'.tif',''));
  end
  LastImageNum=max(FileNameNum);
end