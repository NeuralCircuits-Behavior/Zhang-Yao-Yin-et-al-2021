%% It is used to change the direction of the normal view to the nii direction
% Usage 3DChanged=ChangeDirectionToNii(3D);
% yinxin 2016/11/17

function ReferenceT=ChangeDirectionToNii(Reference)

Reference=permute(Reference,[2 3 1]);
Reference=fliplr(Reference);
j=size(Reference,3);
for i=1:size(Reference,3)
    ReferenceT(:,:,j)=Reference(:,:,i);
    j=j-1;
end

end