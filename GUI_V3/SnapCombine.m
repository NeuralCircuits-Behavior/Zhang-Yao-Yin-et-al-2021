% This procedure is used to snap many images in different ETL focus and
% combine them together to improve the image quality.
% Usage: 
% SnapCombine(VoltageSampled,Light) Light: 1 right, 2 left

function Image=SnapCombine(VoltageSampled,Light,mmc,gui)
%VoltageSampled=[2.1 2.0 1.7 1.6 1.4 1.2 1.1 1.0];
%Light=1;
% Image=zeros(2048,2048);
Image=[];
n=0;
BlockSize=fix(2048/length(VoltageSampled));

for vol=VoltageSampled
    n=n+1;
    SetPulsePalVoltage(Light,vol);
    gui.sleep(30);
    mmc.snapImage();
    imgT = mmc.getImage(); 
    imgT=TransferImage(imgT);
%     Image((n-1)*BlockSize+1:n*BlockSize,:)=imgT((n-1)*BlockSize+1:n*BlockSize,:);
    if(n==length(VoltageSampled))
        Image=cat(1,Image,imgT((n-1)*BlockSize+1:2048,:));
    else
        Image=cat(1,Image,imgT((n-1)*BlockSize+1:n*BlockSize,:));
    end
end

end


% writeTifFast('F:\Projects\To Build The Light Sheet\AlignTheCMOSWithETL\ImageData\tmp\SnapCombine\Test1.tif',Image,16)
% 




















