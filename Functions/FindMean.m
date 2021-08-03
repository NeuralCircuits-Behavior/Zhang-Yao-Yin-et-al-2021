%%% This function was used to find mean intensity of a image(3D or 2D) in
%%% the area of signal. 
%%% Yinxin 20170415

function Mean=FindMean(Im)
   Thr=10;
   Im(Im<=Thr)=0;
   Sum=sum(Im(:));
   Im(Im>Thr)=1;
   SumNum=sum(Im(:));
   Mean=Sum/SumNum;
end