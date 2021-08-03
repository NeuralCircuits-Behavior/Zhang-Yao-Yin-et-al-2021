function  CurrentMagnification=ChangeMagfication(hObject,handles,CurrentMagnification,ExpectedMagnification)

MagList=[0.63 0.8 1 1.25 1.6 2 2.5 3.2 4 5 6.3];

Moter=handles.my.Moter;
ValueCurrent=find(MagList==CurrentMagnification);
ValueExpecte=find(MagList==ExpectedMagnification);
Delta=ValueExpecte-ValueCurrent;
if Delta~=0
    if Delta>0
        for i=1:Delta
            fwrite(Moter,'z');
            pause(1.2);
        end
    else
        for i=1:abs(Delta)
            fwrite(Moter,'a');
            pause(1.2);
        end
    end
end
handles.my.Value=ValueExpecte;
guidata(hObject,handles)
CurrentMagnification=MagList(ValueExpecte);
handles.Magnification.Value=ValueExpecte;

end