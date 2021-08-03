

function [Planning  XDirectionALl]=FoundPlannedPath(ImagingMatrix,OverallDirection)

if sum(ImagingMatrix)==0
    Planning=[];
    return;
end

Size=size(ImagingMatrix);
[Cols,Rows]=find(ImagingMatrix');
ChangeYPoint=find(diff(Rows));
% in case the ChangYPoint is empty
if length(ChangeYPoint)==0
    Planning=[Rows Cols];
    if OverallDirection==1
        XDirectionALl(1:size(Planning,1))=1;
    else
        XDirectionALl(1:size(Planning,1))=-1;
    end
    return;
end

ChangeYPoint=[0 ;ChangeYPoint; size(Cols,1)];
XDirectionALl(1:size(Cols,1))=1;

for i=2:length(ChangeYPoint)
    if mod((i-1),2)==0
        Cols(ChangeYPoint(i-1)+1:ChangeYPoint(i))=Cols(ChangeYPoint(i):-1:ChangeYPoint(i-1)+1);
        XDirectionALl(ChangeYPoint(i-1)+1:ChangeYPoint(i))=-1;
    end
end
Planning=[Rows Cols];

if OverallDirection==-1
    Planning=flipud(Planning);
    XDirectionALl=fliplr(XDirectionALl*-1);
end
    
    
end