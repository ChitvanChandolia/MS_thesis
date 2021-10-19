%Repeated Measures ANOVA
cd E:\Lab\data2\MatFiles_ASSLData\AllBirdsInfo
load('AllBirdsInfo.mat')
BirdNames = fieldnames(AllBirdInfo);
AllStimuli = {'w','i','r','m','n'};
AllCalls =[]; Groups =[];
    for i = 1:length(BirdNames) %calling each bird
        Days = fieldnames(AllBirdInfo.(BirdNames{i}));
        NumCall =[];
        for j = 1:length(Days) %calling each day
            TempCall = AllBirdInfo.(BirdNames{i}).(Days{j}).NumberOfCalls; %calling calls for the day
            AllCalls = [AllCalls; TempCall]; %concatenating calls from all days and the birds
            Groups = [Groups; ones(length(TempCall),1)*i] %concatenating all birds' numbers to a column matrix  
            clear Temp*
        end
%         MeanBirdCalls = [MeanBirdCalls; mean(NumCall,1)]; %concatenating mean calls of each bird for a stimulus
       % clear NumCall
    end
    
    
    %------------Repeated Measures ANOVA----------------------------
    %For Calls
     t = table(Groups,AllCalls(:,1),AllCalls(:,2),AllCalls(:,3),AllCalls(:,4),AllCalls(:,5),'VariableNames',{'Birdno','w','i','r','m','n'})
    MeanCalls = table([1 2 3 4 5]','VariableNames',{'Stimuli'}); %for headings
     rm = fitrm(t,'w-n~Birdno','WithinDesign',MeanCalls)
     rm.Coefficients
     rm.Covariance
     rm.DFE %The error degrees of freedom is the number of observations minus the number of estimated coefficients in the between-subjects model, e.g. 150 – 3 = 147. 
     
     ranova1= ranova(rm)
     tbl = multcompare(rm,'Stimuli')
     multcompare(rm,'Stimuli')
%---------------Kruskal wallis---------------------------
%        NewAllCalls =[]; NewGroups =[];
%      for i = 1:5
%          NewAllCalls = [NewAllCalls; AllCalls(:,i)];
%          NewGroups =[NewGroups; ones(length(AllCalls(:,i)),1)*i];
%      end
%      
%      kw1 = kruskalwallis(NewAllCalls,NewGroups)
%      [x p stat] = kruskalwallis(NewAllCalls,NewGroups)
%      multcompare(stat)



%Latency


AllLatencies = []; GroupL = [];
for i=1:length(BirdNames) %calling each bird
    Days = fieldnames(AllBirdInfo.(BirdNames{i}))
    for j = 1:length(Days) %calling each day
        TempLatency = AllBirdInfo.(BirdNames{i}).(Days{j}).Latency; %Latency for each day of each bird
        TempLatency (TempLatency ==0) = 2.5;
        AllLatencies = [AllLatencies; TempLatency]; %concatenating calls from all days and the birds
        GroupL = [GroupL; ones(length(TempLatency),1)*i];
        
        clear Temp*
    end
end

t = table(GroupL,AllLatencies(:,1),AllLatencies(:,2),AllLatencies(:,3),AllLatencies(:,4),AllLatencies(:,5),'VariableNames',{'Birdno','w','i','r','m','n'});
MeanLatencies = table([1 2 3 4 5]','VariableNames',{'Stimuli'}); %for headings
rm = fitrm(t,'w-n~Birdno','WithinDesign',MeanLatencies);
rm.Coefficients
rm.Covariance
rm.DFE %The error degrees of freedom is the number of observations minus the number of estimated coefficients in the between-subjects model, e.g. 150 – 3 = 147.

ranova1= ranova(rm)
tbl = multcompare(rm,'Stimuli')
multcompare(rm,'Stimuli')




      %Difference      
Diff = []; GroupD = [];
 for i = 1:length(BirdNames) % each bird
        Days = fieldnames(AllBirdInfo.(BirdNames{i}));
        for j = 1:length(Days) % each day
            TempDiffAll =[];
            TempCall = AllBirdInfo.(BirdNames{i}).(Days{j}).NumberOfCalls; % no. of response calls per day per bird
            TempBasecall = AllBirdInfo.(BirdNames{i}).(Days{j}).Numberofbasecalls; %no. of baseline calls  per day per bird
            for k = 1:length(AllStimuli)
                NumCallTemp = TempCall(:,k); %no. of stimulus specific response calls
                NumBasecallTemp = TempBasecall (:,k); % no. of stimulus specific baseline calls
                DiffTemp = (NumCallTemp-NumBasecallTemp)
                TempDiffAll = [TempDiffAll DiffTemp]; %mean of difference of response no. and baseline no. for each stimulus
                clear *Temp
            end
            Diff = [Diff; TempDiffAll];
            GroupD = [GroupD ;ones(length(TempDiffAll),1)*i]
            clear Temp*
        end
 end
 
  t = table(GroupD,Diff(:,1),Diff(:,2),Diff(:,3),Diff(:,4),Diff(:,5),'VariableNames',{'Birdno','w','i','r','m','n'})
    MeanDiff = table([1 2 3 4 5]','VariableNames',{'Stimuli'}); %meas
     rm = fitrm(t,'w-n~Birdno','WithinDesign',MeanDiff)
     rm.Coefficients
     rm.Covariance
     rm.DFE %The error degrees of freedom is the number of observations minus the number of estimated coefficients in the between-subjects model, e.g. 150 – 3 = 147. 
     
     ranova1= ranova(rm)
     tbl = multcompare(rm,'Stimuli')