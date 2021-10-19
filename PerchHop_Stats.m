%%
%-----------Stats for perch hop - stimuli-------------------
clear
cd E:\Lab\data2\Perchhop
IN_MotifNum =[]; Motif_INNum =[]; INNum =[]; MotifNum =[]; NoiseNum=[];
Groups =[];
for i=2:9
[TempIN_MotifNum y z] = xlsread('PerchHop_data.xlsx',i,'B2:F2'); 
[TempMotif_INNum y z] = xlsread('PerchHop_data.xlsx',i,'B3:F3');
[TempINNum y z] = xlsread('PerchHop_data.xlsx',i,'B4:F4');
[TempMotifNum y z] = xlsread('PerchHop_data.xlsx',i,'B5:F5');
[TempNoiseNum y z] = xlsread('PerchHop_data.xlsx',i,'B6:F6');

TempIN_MotifNum(isnan(TempIN_MotifNum)) =[];
TempMotif_INNum(isnan(TempMotif_INNum))=[];
TempINNum(isnan(TempINNum)) =[];
TempMotifNum(isnan(TempMotifNum)) =[];
TempNoiseNum(isnan(TempNoiseNum)) =[];

IN_MotifNum = [IN_MotifNum TempIN_MotifNum]    
Motif_INNum = [Motif_INNum TempMotif_INNum]
INNum = [INNum TempINNum]
MotifNum = [MotifNum TempMotifNum]
NoiseNum = [NoiseNum TempNoiseNum]

Groups = [Groups; ones(length(TempIN_MotifNum),1)*i]

clear Temp*

end

t = table(Groups,IN_MotifNum',Motif_INNum',INNum',MotifNum',NoiseNum','VariableNames',{'Birdno','w','r','i','m','n'})
MeanHops = table([1 2 3 4 5]','VariableNames',{'Stimuli'});
rm = fitrm(t,'w-n~Birdno','WithinDesign',MeanHops)
rm.Coefficients
rm.Covariance
rm.DFE %The error degrees of freedom is the number of observations minus the number of estimated coefficients in the between-subjects model, e.g. 150 – 3 = 147.

ranova1= ranova(rm)
tbl = multcompare(rm,'Stimuli')
multcompare(rm,'Stimuli')
%%
%%----------------stats for perch hop - perches---------------------
clear
cd E:\Lab\data2\Perchhop
FolderNames ={'red098red026','red099red027','black29white45','black30white46','black33white49','yellow43white68','yellow44white69','yellow45white70'}
BirdNames ={'r098r026','r099r027','b29w45', 'b30w46', 'b33w49', 'y43w68', 'y44w69','y45w70'}
r098r026Days = [03 04 04 05 06 07 07]; %red098red026
r099r027Days = [03 04 04 05 06 07]; %red099red027
b29w45Days = [10 11 12 14 14 20]; %black29white45
b30w46Days = [10 10 12 14 20]; %black30white46
b33w49Days = [10 11 11 11 12 14 16]; %black33white49
y43w68Days = [21 21 22 23 25 28]; %yellow43white68
y44w69Days = [21 22 23 25 28]; %yellow44white69
y45w70Days = [21 22 22 23 25 28]; %yellow45white70

r098r026Trials = [2 1 2 1 1 1 2];
r099r027Trials = [1 1 2 1 1 1];
b29w45Trials = [1 1 1 1 2 1];
b30w46Trials = [1 2 1 1 1];
b33w49Trials = [1 1 2 3 1 1 1];
y43w68Trials = [1 2 1 1 1 1];
y44w69Trials = [1 1  1 1 1];
y45w70Trials = [1 1 2 1 1 1];

perch2 = []; perch3=[]; perch4=[]; perch5=[]; perch6=[];
groups=[];
for j = 1:length(BirdNames)
    TempDays = eval([BirdNames{j} 'Days']);
    TempTrials = eval([BirdNames{j} 'Trials']);
    P2 =[]; P3 =[]; P4 =[]; P5 =[]; P6 =[];
    for i = 1:length(TempDays)
        cd(FolderNames{j});
        fileID = fopen([num2str(TempDays(i)) '-Sep-2021_' num2str(TempTrials(i)) '.txt']);
        C = textscan(fileID,'%s%t%s');
        fclose(fileID);
        cd ..
        Temp = C{1,2}(7:end);
        Temp = cell2mat(Temp);
        Temp = str2num(Temp);
        
        TempP2 = length(find(Temp== 2));
        TempP3 = length(find(Temp== 3));
        TempP4 = length(find(Temp== 4));
        TempP5 = length(find(Temp== 5));
        TempP6 = length(find(Temp== 6));
        
        P2 = [P2  TempP2];
        P3 = [P3  TempP3];
        P4 = [P4  TempP4];
        P5 = [P5  TempP5];
        P6 = [P6  TempP6];
        
    end
    perch2 = [perch2 P2]
    perch3 = [perch3 P3]
    perch4 = [perch4 P4]
    perch5 = [perch5 P5]
    perch6 = [perch6 P6]
    groups = [groups; ones(length(P2),1)*j]
    
    clear Temp*
end

t = table(groups,perch2',perch3',perch4',perch5',perch6','VariableNames',{'Birdno','p1','p2','p3','p4','p5'})
MeanHops = table([1 2 3 4 5]','VariableNames',{'Perches'});
rm = fitrm(t,'p1-p5~Birdno','WithinDesign',MeanHops)
rm.Coefficients
rm.Covariance
rm.DFE %The error degrees of freedom is the number of observations minus the number of estimated coefficients in the between-subjects model, e.g. 150 – 3 = 147.

ranova1= ranova(rm)
tbl = multcompare(rm,'Perches')
multcompare(rm,'Perches')

%% -------- Stats for Day wise data -------------------------
[day1Num y z] = xlsread('PerchHop_data.xlsx',1,'B13:I13');
[day2Num y z] = xlsread('PerchHop_data.xlsx',1,'B14:I14');
[day3Num y z] = xlsread('PerchHop_data.xlsx',1,'B15:I15');
[day4Num y z] = xlsread('PerchHop_data.xlsx',1,'B16:I16');
[day5Num y z] = xlsread('PerchHop_data.xlsx',1,'B17:I17');
Groups =[1 2 3 4 5 6 7 8];

t = table([1 2 3 4 5 6 7 8]',day1Num',day2Num',day3Num',day4Num',day5Num','VariableNames',{'Birdno','d1','d2','d3','d4','d5'})

MeanHops = table([1 2 3 4 5]','VariableNames',{'Days'});
rm = fitrm(t,'d1-d5~Birdno','WithinDesign',MeanHops)
rm.Coefficients
rm.Covariance
rm.DFE %The error degrees of freedom is the number of observations minus the number of estimated coefficients in the between-subjects model, e.g. 150 – 3 = 147.

ranova1= ranova(rm)

tbl = multcompare(rm,'Days')
multcompare(rm,'Days')

