function seg=Axon_Segmentation(im)

% % im=imread('C:\Users\Public\Documents\TEMP\axon_0.8x_100ms\Denoise\MAX_axon_0.8x_100ms_8bit.tif');
% im=imread('D:\WholeBrainImagingData\20180918_VJ_HTY_CUBIC-X_0.63_0.8\0.63x_100ms\Denoise\Newfolder\MAX_axon_0.63x_100ms.tif');
% 
% % im=imread('C:\Users\Public\Documents\TEMP\0.8x_100ms\MAX_axon_0.8x_100ms_8bit.tif');

% im=fftDenoiseImage(im);
% Sensitivity1=5;
% Sensitivity2=3;
Sensitivity1=3;
Sensitivity2=2;
%% smooth the image
im_sm=wiener2(im, [5 5]);
% figure(1); imshow(im_sm)
% figure(1); imshow(im_sm,[1600 2400])


%% segment brain region using intensity
level=multithresh(im_sm);
seg_I = imquantize(im_sm,level);

%%%% find bright spots
level=mean(im_sm(seg_I==2))+Sensitivity1*std(double(im_sm(seg_I==2)));
seg_high=imquantize(im_sm,level);

level=mean(im_sm(seg_I==2 & seg_high==1))+Sensitivity2*std(double(im_sm(seg_I==2 & seg_high==1)));
seg1 = imquantize(im_sm,level);
% figure(2); imshow(seg1, []);

%% segment image gradient
[Gmag, Gdir] = imgradient(im_sm,'prewitt');
level=mean(Gmag(:))+Sensitivity1*std(Gmag(:));
seg2 = imquantize(Gmag,level);
% figure(3); imshow(seg2, []);

%% segment using the combination of intensity and gradient
seg=zeros(size(seg1)); seg(seg1==2 & seg2==2)=1;
% figure(4); imshow(seg, [])

%% setup regions at 6.3x zoom
% zoom_small=0.8; zoom_big=6.3;   overlapratio=0.1;
% im_size=size(im);
% im_size_zoom=floor(im_size*zoom_small/zoom_big);
% xgrid=0:floor(im_size_zoom*0.9):im_size(1); ygrid=xgrid;
% [x y]=meshgrid(xgrid, ygrid);
% 
% 
% stat = regionprops('table', logical(seg-1),'centroid');
% rectangleID=[floor(stat.Centroid(:,1)/(im_size_zoom(1)*0.9))+1 floor(stat.Centroid(:,2)/(im_size_zoom(2)*0.9))+1 ];
% C = unique(table(rectangleID));
% rectangleID=C.rectangleID;
% 
% hold on; 
% for i=1:size(C,1)
%     rectangle('Position',[xgrid(rectangleID(i,1)) ygrid(rectangleID(i,2)) im_size_zoom(1) im_size_zoom(2)], ...
%         'EdgeColor', 'w')
% end

end
function M=fftDenoiseImage(Image)

        K=fft2(Image);
        K=fftshift(K);
%         K(1022:1026,1:1022)=0;
%         K(1022:1026,1026:2048)=0;
        K(1737:1743,1:1737)=0;
        K(1737:1743,1743:3481)=0;
        K=ifftshift(K);
        M=uint16(real(ifft2(K)));

end