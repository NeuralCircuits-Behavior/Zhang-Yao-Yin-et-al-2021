if ~exist('i') |  exist('i')==5
    i=1;
end
handles.my.EndImStack=s;
handles.my.EndImI=i;
handles.my.EndImJ=j;

handles.my.Xdirection=Xdirection;
handles.my.Ydirection=Ydirection;
handles.my.Zdirection=Zdirection;
handles.my.Xlocation=Xlocation;
handles.my.Ylocation=Ylocation;

pause(0.1)   
while 1
   if handles.StartImaging.Value==1 | handles.Break.Value==1
       break;
   else
       pause(0.1);
       guidata(hObject,handles);
   end
end

if handles.Update.Value==1
    Update;
    SaveConfigure(handles);
    guidata(hObject,handles);
    handles.Update.Value=0;
    pause(0.01);
end