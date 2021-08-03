%%% This function was used to count the intensity of a brain volumn that
%%% has been registered to the reference brain. The brightness of the
%%% volumn should be adjusted to the same level before the counting. 
%%% Finally, the data will be exported to a xls file.
%%%
%%% Usage: Annotated=CountIntensity(Volumn,ReferenceAnno,CutOff,OutputFolder,Animal)
%%%        Volumn: Input volumn that is waited to be aligned to the reference.
%%%        CutOff: The cutoff between signal and noise
%%%  OutputFolder: Data output
%%%        Animal: Animal Tag
%%%            fn: The CSV file that contains the relationship between the tag and the name. 
%%% ReferenceAnno: The reference volumn.
%%%     Annotated: The annotated results. It will return a struct containing data separately for left and right hemispheres. The last layer is a matrix whose row represents different percent and column represents different structures.  
%%% 20170705

function  Annotated=CountIntensity(Volumn,ReferenceAnno,CutOff,OutputFolder,Animal,fn)

Size=size(ReferenceAnno);
ReferenceAnnoLeft=ReferenceAnno;
ReferenceAnnoRight=ReferenceAnno;

ReferenceAnnoLeft(:,fix(Size(2)/2)+1:end,:)=0;
ReferenceAnnoRight(:,1:fix(Size(2)/2),:)=0;

StructuresLeft=unique(ReferenceAnnoLeft(:));
StructuresRight=unique(ReferenceAnnoRight(:));
% CutOff=5; % Cutoff between signal and noise.
Annotated={};
Annotated.Left.Structures=StructuresLeft;
Annotated.Right.Structures=StructuresRight;
Annotated.CutOff=CutOff;

% for left hemisphere
for i=1:length(StructuresLeft)
   structure=StructuresLeft(i);
   GrayValue=Volumn(ReferenceAnnoLeft==structure);
   GrayValue=sort(GrayValue,'descend');
   %stat different percent of data
   n=0;
   for p=0.1:0.1:1
       n=n+1;
       ThisPercent = GrayValue(1:ceil(length(GrayValue)*p));  
       Annotated.Left.Mean(n,i)=mean(ThisPercent);
       Annotated.Left.Median(n,i)=median(ThisPercent);
       Annotated.Left.Portion(n,i)=double(sum(ThisPercent>CutOff))/double(length(ThisPercent));
   end
end


% for right hemisphere
for i=1:length(StructuresRight)
   structure=StructuresRight(i);
   GrayValue=Volumn(ReferenceAnnoRight==structure);
   GrayValue=sort(GrayValue,'descend');
   %stat different percent of data
   n=0;
   for p=0.1:0.1:1
       n=n+1;
       ThisPercent = GrayValue(1:ceil(length(GrayValue)*p));  
       Annotated.Right.Mean(n,i)=mean(ThisPercent);
       Annotated.Right.Median(n,i)=median(ThisPercent);
       Annotated.Right.Portion(n,i)=double(sum(ThisPercent>CutOff))/double(length(ThisPercent));
   end
end


% fn='G:\Alignment\MikeRegistrationfiles\mousebrainontology_name.csv';
ont = importOntology(fn);


% write right
A='';
for s=1:size(Annotated.Right.Mean,1)
    sheet = s;
%     A = '{''Structure'',''Mean'',''Median'',''Portion''';
    A = '{''Mean'',''Median'',''Portion''';
    for i=1:length(ont.id)
         ID=ont.id(i);
         Name=ont.name(i);
         Name=strrep(Name{1},',',' ');
         Index=find(StructuresRight==ID);
         if Index
            Mean=Annotated.Right.Mean(s,Index);
            Median=Annotated.Right.Median(s,Index);
            Portion=Annotated.Right.Portion(s,Index);
%             A=[A,';','''',Name,'''',',','''',num2str(Mean),'''',',','''',num2str(Median),'''',',','''',num2str(Portion),''''];
            A=[A,';','''',num2str(Mean),'''',',','''',num2str(Median),'''',',','''',num2str(Portion),''''];
         else
%             A=[A,';','''','''',',','''','''',',','''','''',',','''',''''];
            A=[A,';','''','''',',','''','''',',','''',''''];
         end
    end
    A=[A,'}'];
    A=eval(A);
    xlRange = 'A1';
     xlswrite([OutputFolder,'/_',Animal,'_AnnotatedRight.xls'],A,sheet,xlRange)
end


% write left
A='';
for s=1:size(Annotated.Left.Mean,1)
    sheet = s;
%     A = '{''Structure'',''Mean'',''Median'',''Portion''';
    A = '{''Mean'',''Median'',''Portion''';
    for i=1:length(ont.id)
         ID=ont.id(i);
         Name=ont.name(i);
         Name=strrep(Name{1},',',' ');
         Index=find(StructuresLeft==ID);
         if Index
            Mean=Annotated.Left.Mean(s,Index);
            Median=Annotated.Left.Median(s,Index);
            Portion=Annotated.Left.Portion(s,Index);
%             A=[A,';','''',Name,'''',',','''',num2str(Mean),'''',',','''',num2str(Median),'''',',','''',num2str(Portion),''''];
            A=[A,';','''',num2str(Mean),'''',',','''',num2str(Median),'''',',','''',num2str(Portion),''''];
         else
%             A=[A,';','''','''',',','''','''',',','''','''',',','''',''''];
            A=[A,';','''','''',',','''','''',',','''',''''];
         end
    end
    A=[A,'}'];
    A=eval(A);
    xlRange = 'A1';
    xlswrite([OutputFolder,'/_',Animal,'_AnnotatedLeft.xls'],A,sheet,xlRange)
end



end












































