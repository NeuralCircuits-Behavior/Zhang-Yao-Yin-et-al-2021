

function PlotGrids(StartRowA,EndRowA,StartColumnA,EndColumnA,ImagingMatrix)
   
   Size=size(ImagingMatrix);
   n=0;
   for i=1:Size(1)
       for j=1:Size(2)
           n=n+1;
           if ImagingMatrix(i,j)==1
               Color='r:';
           else
               continue;
               Color='r:';
           end
               StartRowANow=StartRowA(n);
               EndRowANow=EndRowA(n);
               StartColumnANow=StartColumnA(n);
               EndColumnANow=EndColumnA(n);
               hold on;
               
               plot([StartColumnANow StartColumnANow],[StartRowANow,EndRowANow],Color,'LineWidth',2);
               hold on;
               plot([EndColumnANow EndColumnANow],[StartRowANow,EndRowANow],Color,'LineWidth',2);
               hold on;
               plot([StartColumnANow EndColumnANow],[StartRowANow,StartRowANow],Color,'LineWidth',2);
               hold on;
               plot([StartColumnANow EndColumnANow],[EndRowANow,EndRowANow],Color,'LineWidth',2);
               
               

       end
   end
   








end