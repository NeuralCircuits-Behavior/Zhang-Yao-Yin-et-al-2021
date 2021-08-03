% Light sheet microscopy image processing workflow

% denoise
Destripe(Folder)

% stitching
Stitching(Folder,StitchingColor,StitchingSide,Overlap,ComputeOverlap)

% clean the image
MaskImages(folder,Cutoff,suffix,fudgeFactor,DilateThick,RemovePixelSize,Clearborder)

% stack stiching
StitchingStacks(Folder,ImagePrefix,ImageSuffix,StartImage,Zoverlap,ZStep,Zcut,Threshhold,FindSimilar,RemoveLink)

% change brightness
ChangeBrightness(Folder,Suffix,ReferenceImageName)

% downsample & prepare a stack for registration
DownsampleSclicesData(Folder,Suffix,Magnification,TargetPixelResolution,ZStep,Cut)
PrepareStack(Folder,Suffix,TargetVolumn,SaveFormat,Cut)














