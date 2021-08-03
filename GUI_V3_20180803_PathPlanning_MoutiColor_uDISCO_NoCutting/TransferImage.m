function img=TransferImage(img)
%         width = mmc.getImageWidth();
%         height = mmc.getImageHeight();
        width =2048;
        height=2048;
        pixelType = 'uint16';
        img = typecast(img, pixelType);      % pixels must be interpreted as unsigned integers
        img = reshape(img, [width, height]); % image should be interpreted as a 2D array
        img = transpose(img);
end