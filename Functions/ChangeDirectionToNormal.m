%% It is used to change the direction of the normal view to the nii direction
% Usage 3DChanged=ChangeDirectionToNormal(3D);
% yinxin 2016/11/17

function ReferenceT=ChangeDirectionToNormal(Reference)

j=size(Reference,3);
for i=1:size(Reference,3)
    ReferenceT(:,:,j)=Reference(:,:,i);
    j=j-1;
end
ReferenceT=fliplr(ReferenceT);

ReferenceT=permute(ReferenceT,[3 1 2]);


end