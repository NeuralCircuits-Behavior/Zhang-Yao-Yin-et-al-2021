function im = loadTifFast(FileTif)
disp(['Loading ' FileTif '...']);
info=imfinfo(FileTif);
xpix=info(1).Width;
ypix=info(1).Height;
frames=numel(info);

bitdepth = info(1).BitsPerSample;
if bitdepth == 32
    im=zeros(ypix,xpix,frames,'uint32');
elseif bitdepth ==16
    im=zeros(ypix,xpix,frames,'uint16');
elseif bitdepth ==8;
    im=zeros(ypix,xpix,frames,'uint8');
elseif bitdepth == 'double';
end
warning off;

TifLink = Tiff(FileTif, 'r');
for i=1:frames
   TifLink.setDirectory(i);
   im(:,:,i)=TifLink.read();
end
TifLink.close();

warning on;
disp('Done loading Tif');


