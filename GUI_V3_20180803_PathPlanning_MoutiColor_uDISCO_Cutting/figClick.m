

 function  figClick(~,handles,fig,StartRowA,EndRowA,StartColumnA,EndColumnA,ImagingMatrix,InputVolume)
    try 
    h = guidata(fig);
    ImagingMatrix=h.ImagingMatrix;
    stype=h.fig.SelectionType;
    [col, row] = gpos(h.ax(1));
    Ind=find(row>StartRowA & row<EndRowA & col>StartColumnA & col <EndColumnA);
    CurrentLocation(1)=floor(Ind/size(ImagingMatrix,1))+1;
    CurrentLocation(2)=Ind-(CurrentLocation(1)-1)*size(ImagingMatrix,1);
    if CurrentLocation(2)==0
        CurrentLocation=[CurrentLocation(1)-1 size(ImagingMatrix,1) ];
    end
    
    if strcmp(stype,'normal') % add
         ImagingMatrix(CurrentLocation(1),CurrentLocation(2))=1;
    elseif strcmp(stype,'alt') % delete
         ImagingMatrix(CurrentLocation(1),CurrentLocation(2))=0;
    end
    h.ImagingMatrix=ImagingMatrix;
    h.axim(1) = imshow(InputVolume,[1 1000]); hold on;
    PlotGrids(StartRowA,EndRowA,StartColumnA,EndColumnA,ImagingMatrix);
    disp(['You clicked Row:',num2str(CurrentLocation(1)),',  Col:',num2str(CurrentLocation(2))]);
    guidata(h.fig, h);
    catch
    end
