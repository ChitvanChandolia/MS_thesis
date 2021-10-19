
%Days = [03 04 04 05 06 07 07]; %red098red026
%Days = [03 04 04 05 06 07]; %red099red027
%Days = [10 11 12 14 14 20]; %black29white45
%Days = [10 10 12 14 20]; %black30white46
%Days = [10 11 11 11 12 14 16]; %black33white49
%Days = [21 21 22 23 25 28]; %yellow43white68
%Days = [21 22 23 25 28]; %yellow44white69
Days = [21 22 22 23 25 28]; %yellow45white70

Trials = [1 1 2 1 1 1];
P2B8 =0; 
P3B8 =0; 
P4B8 =0; 
P5B8 =0; 
P6B8 =0;

for i = 1:length(Days)
    fileID = fopen([num2str(Days(i)) '-Sep-2021_' num2str(Trials(i)) '.txt']);
    C = textscan(fileID,'%s%t%s');
    fclose(fileID);
    Temp = C{1,2}(7:end);
    Temp = cell2mat(Temp);
    Temp = str2num(Temp);
    
    TempP2 = length(find(Temp== 2));
    TempP3 = length(find(Temp== 3));
    TempP4 = length(find(Temp== 4));
    TempP5 = length(find(Temp== 5));
    TempP6 = length(find(Temp== 6));
    
    P2B8 = P2B8 + TempP2
    P3B8 = P3B8 + TempP3
    P4B8 = P4B8 + TempP4
    P5B8 = P5B8 + TempP5
    P6B8 = P6B8 + TempP6
    
end

cd E:\Lab\data2\Perchhop\PerchData

load('P2B1.mat')
load('P2B2.mat')
load('P2B3.mat')
load('P2B4.mat')
load('P2B5.mat')
load('P2B6.mat')
load('P2B7.mat')
load('P2B8.mat')
load('P3B1.mat')
load('P3B2.mat')
load('P3B3.mat')
load('P3B4.mat')
load('P3B5.mat')
load('P3B6.mat')
load('P3B7.mat')
load('P3B8.mat')
load('P4B1.mat')
load('P4B2.mat')
load('P4B3.mat')
load('P4B4.mat')
load('P4B5.mat')
load('P4B6.mat')
load('P4B7.mat')
load('P4B8.mat')
load('P5B1.mat')
load('P5B2.mat')
load('P5B3.mat')
load('P5B4.mat')
load('P5B5.mat')
load('P5B6.mat')
load('P5B7.mat')
load('P5B8.mat')
load('P6B1.mat')
load('P6B2.mat')
load('P6B3.mat')
load('P6B4.mat')
load('P6B5.mat')
load('P6B6.mat')
load('P6B7.mat')
load('P6B8.mat')


Perch2 = [P2B1 P2B2 P2B3 P2B4 P2B5 P2B6 P2B7 P2B8];
Perch3 = [P3B1 P3B2 P3B3 P3B4 P3B5 P3B6 P3B7 P3B8];
Perch4 = [P4B1 P4B2 P4B3 P4B4 P4B5 P4B6 P4B7 P4B8];
Perch5 = [P5B1 P5B2 P5B3 P5B4 P5B5 P5B6 P5B7 P5B8];
Perch6 = [P6B1 P6B2 P6B3 P6B4 P6B5 P6B6 P6B7 P6B8];

Perch2Mean = mean(Perch2);
Perch3Mean = mean(Perch3);
Perch4Mean = mean(Perch4);
Perch5Mean = mean(Perch5);
Perch6Mean = mean(Perch6);

Perch2Std = std(Perch2);
Perch3Std = std(Perch3);
Perch4Std = std(Perch4);
Perch5Std = std(Perch5);
Perch6Std = std(Perch6);

Perch2SE = (Perch2Std)/sqrt(8);
Perch3SE = (Perch3Std)/sqrt(8);
Perch4SE = (Perch4Std)/sqrt(8);
Perch5SE = (Perch5Std)/sqrt(8);
Perch6SE = (Perch6Std)/sqrt(8);

figure
bar([Perch2Mean, Perch3Mean, Perch4Mean, Perch5Mean, Perch6Mean],0.4); hold on
errorbar(1:5, [Perch2Mean, Perch3Mean, Perch4Mean, Perch5Mean, Perch6Mean],[Perch2SE, Perch3SE, Perch4SE, Perch5SE, Perch6SE],'.k'); hold on
for i = 1:8
    plot(1:5,[Perch2(i) Perch3(i) Perch4(i) Perch5(i) Perch6(i)]','-ok','MarkerFaceColor','k','MarkerSize',4.5)
end
set(gca,'fontsize',11.5)
xlabel('Category','fontsize',11.5);
set(gca,'Xticklabels',{'Perch1','Perch2','Perch3','Perch4','Perch5'},'XTickLabelRotation',45,'fontsize',10)
ylabel('Mean number of hops','fontsize',11.5)
box off