%Days = [10 11 12 14 14 20]; 
%Days = [21 21 22 23 25 28]; %yellow43white68
%Days = [03 04 04 05 06 07 07]; %red098red026
%Days = [03 04 04 05 06 07]; %red099red027
%Days = [10 11 12 14 14 20]; %black29white45
%Days = [10 10 12 14 20]; %black30white46
%Days = [10 11 11 11 12 14 16]; %black33white49
%Days = [21 21 22 23 25 28]; %yellow43white68
Days = [21 22 23 25 28]; %yellow44white69
%Days = [21 22 22 23 25 28]; %yellow45white70

Trials = [1 1 1 1 1];
Colors = {'g','b','k','r','m'}
TrialDay = {'Day1','Day2','Day3','Day4','Day5'}

P2 =[]; P3 =[]; P4 =[]; P5=[]; P6 =[];
FixedOrder  = {'IN_Motif', 'Motif_IN','IN','Motif','Noise'}
IN_Motif =[]; Motif_IN =[]; IN =[]; Motif =[]; Noise =[];
for i = 1:length(Days)
    fileID = fopen([num2str(Days(i)) '-Sep-2021_' num2str(Trials(i)) '.txt']);
    C = textscan(fileID,'%s%t%s');
    fclose(fileID);
    Temp = C{1,2}(7:end);
    Temp = cell2mat(Temp);
    Temp = str2num(Temp);
   
    subplot(3,1,1)
    plot(Temp,'-','Color',Colors{i}); hold on
    %title('YELLOW45WHITE70', 'fontsize',18);
    xlabel('Hops','fontsize',11.5);
    ylabel('Perch No.','fontsize',11.5);
    %set(gca,'YTick',[2 3 4 5 6])
    set(gca,'Yticklabels',{'0','1','2','3','4','5'},'fontsize',8);
    ylim([1 6]);
    legend(TrialDay);
    
    box off
    
   
    TempP2 = length(find(Temp== 2));
    TempP3 = length(find(Temp== 3));
    TempP4 = length(find(Temp== 4));
    TempP5 = length(find(Temp== 5));
    TempP6 = length(find(Temp== 6));
    
    P2 = P2 + TempP2
    P3 = P3 + TempP3
    P4 = P4 + TempP4
    P5 = P5 + TempP5
    P6 = P6 + TempP6
    
    PerchNum = str2num(cell2mat(C{1,1}(2:6)));
    IN_Motif(end+1) = PerchNum(1)
    Motif_IN(end+1) = PerchNum(2)
    IN(end+1) = PerchNum(3)
    Motif(end+1) = PerchNum(4)
    Noise(end+1) = PerchNum(5)
    clear Temp
end

MeanP2 = P2/5;
MeanP3 = P3/5;
MeanP4 = P4/5;
MeanP5 = P5/5;
MeanP6 = P6/5;

subplot(3,1,2)
bar([MeanP2 MeanP3 MeanP4 MeanP5 MeanP6],0.55)
xlabel('Perch Number','fontsize',11.5);
ylabel('Mean number of hops','fontsize',11.5)
box off


NP2 =[]; NP3 =[]; NP4 =[]; NP5 =[]; NP6=[];
for i = 1:length(FixedOrder)
    Temp = eval(FixedOrder{i})
    NP2(end+1) = length(find(Temp == 2))
    NP3(end+1) = length(find(Temp == 3))
    NP4(end+1) = length(find(Temp == 4))
    NP5(end+1) = length(find(Temp == 5))
    NP6(end+1) = length(find(Temp == 6))
end
NP2 = NP2/sum(NP2);
NP3 = NP3/sum(NP3);
NP4 = NP4/sum(NP4);
NP5 = NP5/sum(NP5);
NP6 = NP6/sum(NP6);
subplot(3,1,3)
bar([NP2;NP3;NP4;NP5;NP6],'stacked','BarWidth',0.55)
legend({'IN+Motif','Motif+IN','IN','Motif','Noise'})
box off
set(gcf, 'Color', 'w');
set(gca,'fontsize',9,'fontname','Arial');
set(gcf, 'Color', 'w');
set(gcf, 'Units', 'inches');
set(gcf, 'Position', [5 1 5.5 5.5]);
set(gcf, 'PaperPositionMode', 'auto');
xlabel('Perches','fontsize',11.5);
ylabel('Stimulus Proportion','fontsize',11.5)
