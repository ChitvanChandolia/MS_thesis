cd E:\Lab\data2\Perchhop
%---------------StimuliHops-------------------------------
[day1Num y z] = xlsread('PerchHop_data.xlsx',1,'B3:I3'); %
[day2Num y z] = xlsread('PerchHop_data.xlsx',1,'B4:I4');
[day3Num y z] = xlsread('PerchHop_data.xlsx',1,'B5:I5');
[day4Num y z] = xlsread('PerchHop_data.xlsx',1,'B6:I6');
[day5Num y z] = xlsread('PerchHop_data.xlsx',1,'B7:I7');

day1Mean = mean(day1Num);
day2Mean = mean(day2Num);
day3Mean = mean(day3Num);
day4Mean = mean(day4Num);
day5Mean = mean(day5Num);

day1Std = std(day1Num);
day2Std = std(day2Num);
day3Std = std(day3Num);
day4Std = std(day4Num);
day5Std = std(day5Num);

day1SE = (day1Std)/sqrt(8);
day2SE = (day2Std)/sqrt(8);
day3SE = (day3Std)/sqrt(8);
day4SE = (day4Std)/sqrt(8);
day5SE = (day5Std)/sqrt(8);


figure
bar([day1Mean, day2Mean, day3Mean, day4Mean, day5Mean],0.4); hold on
errorbar(1:5, [day1Mean, day2Mean, day3Mean, day4Mean, day5Mean],[day1SE, day2SE, day3SE, day4SE, day5SE],'.k'); hold on
for i = 1:8
    plot(1:5,[day1Num(i) day2Num(i) day3Num(i) day4Num(i) day5Num(i)]','-ok','MarkerFaceColor','k','MarkerSize',4.5)
end
set(gca,'fontsize',11.5)
xlabel('Category','fontsize',11.5);
set(gca,'Xticklabels',{'IN+Motif','Motif+IN','IN','Motif','Noise'},'XTickLabelRotation',45,'fontsize',10)
ylabel('Mean number of hops','fontsize',11.5)
box off





%---------------------DayHops----------------------------

[day1Num y z] = xlsread('PerchHop_data.xlsx',1,'B13:I13');
[day2Num y z] = xlsread('PerchHop_data.xlsx',1,'B14:I14');
[day3Num y z] = xlsread('PerchHop_data.xlsx',1,'B15:I15');
[day4Num y z] = xlsread('PerchHop_data.xlsx',1,'B16:I16');
[day5Num y z] = xlsread('PerchHop_data.xlsx',1,'B17:I17');

day1Mean = mean(day1Num);
day2Mean = mean(day2Num);
day3Mean = mean(day3Num);
day4Mean = mean(day4Num);
day5Mean = mean(day5Num);

day1Std = std(day1Num);
day2Std = std(day2Num);
day3Std = std(day3Num);
day4Std = std(day4Num);
day5Std = std(day5Num);

day1SE = (day1Std)/sqrt(8);
day2SE = (day2Std)/sqrt(8);
day3SE = (day3Std)/sqrt(8);
day4SE = (day4Std)/sqrt(8);
day5SE = (day5Std)/sqrt(8);


figure
bar([day1Mean, day2Mean, day3Mean, day4Mean, day5Mean],0.4); hold on
errorbar(1:5, [day1Mean, day2Mean, day3Mean, day4Mean, day5Mean],[day1SE, day2SE, day3SE, day4SE, day5SE],'.k'); hold on
for i = 1:8
    plot(1:5,[day1Num(i) day2Num(i) day3Num(i) day4Num(i) day5Num(i)]','-ok','MarkerFaceColor','k','MarkerSize',4.5)
end
set(gca,'fontsize',11.5)
xlabel('Category','fontsize',11.5);
set(gca,'Xticklabels',{'Day1','Day2','Day3','Day4','Day5'},'XTickLabelRotation',45,'fontsize',10)
ylabel('Mean number of hops','fontsize',11.5)
box off



%-----------Birdwise_Plots-------------------


for i = 1:8
    [TempIN_MotifNum y z] = xlsread('PerchHop_data.xlsx',i+1,'B2:F2');
    [TempMotif_INNum y z] = xlsread('PerchHop_data.xlsx',i+1,'B3:F3');
    [TempINNum y z] = xlsread('PerchHop_data.xlsx',i+1,'B4:F4');
    [TempMotifNum y z] = xlsread('PerchHop_data.xlsx',i+1,'B5:F5');
    [TempNoiseNum y z] = xlsread('PerchHop_data.xlsx',i+1,'B6:F6');
    
    TempIN_MotifMean = mean(TempIN_MotifNum);
    TempMotif_INMean = mean(TempMotif_INNum);
    TempINMean = mean(TempINNum);
    TempMotifMean = mean(TempMotifNum);
    TempNoiseMean = mean(TempNoiseNum);
    
    TempIN_MotifStd = std(TempIN_MotifNum);
    TempMotif_INStd = std(TempMotif_INNum);
    TempINStd = std(TempINNum);
    TempMotifStd = std(TempMotifNum);
    TempNoiseStd = std(TempNoiseNum);
    
    TempIN_MotifSE = (TempIN_MotifStd)/sqrt(8);
    TempMotif_INSE = (TempMotif_INStd)/sqrt(8);
    TempINSE = (TempINStd)/sqrt(8);
    TempMotifSE = (TempMotifStd)/sqrt(8);
    TempNoiseSE = (TempNoiseStd)/sqrt(8);
    figure
    bar([TempIN_MotifMean, TempMotif_INMean, TempINMean, TempMotifMean, TempNoiseMean],0.4); hold on
    errorbar(1:5, [TempIN_MotifMean, TempMotif_INMean, TempINMean, TempMotifMean, TempNoiseMean],[TempIN_MotifSE, TempMotif_INSE, TempINSE, TempMotifSE, TempNoiseSE],'.k'); hold on
    for i = 1:5
        plot(1:5,[TempIN_MotifNum(i) TempMotif_INNum(i) TempINNum(i) TempMotifNum(i) TempNoiseNum(i)]','-ok','MarkerFaceColor','k','MarkerSize',4.5)
    end
    set(gca,'fontsize',11.5)
    xlabel('Category','fontsize',11.5);
    set(gca,'Xticklabels',{'IN+Motif','Motif+IN','IN','Motif','Noise'},'XTickLabelRotation',45,'fontsize',10)
    ylabel('Mean number of hops','fontsize',11.5)
    box off
    clear temp*
end
%%
%----------------Experience Grouping in batches of birds-------

cd E:\Lab\data2\Perchhop

[batch1stim1Num y z] = xlsread('PerchHop_data.xlsx',1,'E3:F3'); 
[batch1stim2Num y z] = xlsread('PerchHop_data.xlsx',1,'E4:F4');
[batch1stim3Num y z] = xlsread('PerchHop_data.xlsx',1,'E5:F5');
[batch1stim4Num y z] = xlsread('PerchHop_data.xlsx',1,'E6:F6');
[batch1stim5Num y z] = xlsread('PerchHop_data.xlsx',1,'E7:F7');

[batch2stim1Num y z] = xlsread('PerchHop_data.xlsx',1,'B3:D3'); 
[batch2stim2Num y z] = xlsread('PerchHop_data.xlsx',1,'B4:D4');
[batch2stim3Num y z] = xlsread('PerchHop_data.xlsx',1,'B5:D5');
[batch2stim4Num y z] = xlsread('PerchHop_data.xlsx',1,'B6:D6');
[batch2stim5Num y z] = xlsread('PerchHop_data.xlsx',1,'B7:D7');

[batch3stim1Num y z] = xlsread('PerchHop_data.xlsx',1,'G3:I3'); 
[batch3stim2Num y z] = xlsread('PerchHop_data.xlsx',1,'G4:I4');
[batch3stim3Num y z] = xlsread('PerchHop_data.xlsx',1,'G5:I5');
[batch3stim4Num y z] = xlsread('PerchHop_data.xlsx',1,'G6:I6');
[batch3stim5Num y z] = xlsread('PerchHop_data.xlsx',1,'G7:I7');

batch1stim1Mean = mean(batch1stim1Num);
batch1stim2Mean = mean(batch1stim2Num);
batch1stim3Mean = mean(batch1stim3Num);
batch1stim4Mean = mean(batch1stim4Num);
batch1stim5Mean = mean(batch1stim5Num);

batch2stim1Mean = mean(batch2stim1Num);
batch2stim2Mean = mean(batch2stim2Num);
batch2stim3Mean = mean(batch2stim3Num);
batch2stim4Mean = mean(batch2stim4Num);
batch2stim5Mean = mean(batch2stim5Num);

batch3stim1Mean = mean(batch3stim1Num);
batch3stim2Mean = mean(batch3stim2Num);
batch3stim3Mean = mean(batch3stim3Num);
batch3stim4Mean = mean(batch3stim4Num);
batch3stim5Mean = mean(batch3stim5Num);

y = [batch1stim1Mean batch2stim1Mean batch3stim1Mean; batch1stim2Mean batch2stim2Mean batch3stim2Mean; batch1stim3Mean batch2stim3Mean batch3stim3Mean; batch1stim4Mean batch2stim4Mean batch3stim4Mean; batch1stim5Mean batch2stim5Mean batch3stim5Mean]
    
figure
subplot(1,2,1)
bar(y)
set(gca,'fontsize',11.5)
xlabel('Stimuli','fontsize',11.5);
set(gca,'Xticklabels',{'IN+Motif','Motif+IN','IN','Motif','Noise'},'XTickLabelRotation',45,'fontsize',10)
ylabel('Mean number of hops','fontsize',11.5)
legend({'Batch1','Batch2','Batch3'})
box off


subplot(1,2,2)
bar(mean(y,1))
set(gca,'fontsize',11.5)
xlabel('Batch Number','fontsize',11.5);
set(gca,'Xticklabels',{'Batch 1','Batch 2','Batch 3'},'XTickLabelRotation',45,'fontsize',10)
ylabel('Mean of total hops','fontsize',11.5)
box off

bar(mean(y,1), y, 'stacked','BarWidth',0.55)
set(gca,'fontsize',11.5)
xlabel('Batch Number','fontsize',11.5);
set(gca,'Xticklabels',{'Batch 1','Batch 2','Batch 3'},'XTickLabelRotation',45,'fontsize',10)
ylabel('Mean of total hops','fontsize',11.5)
legend({'IN+Motif','Motif+IN','IN','Motif','Noise'})
box off