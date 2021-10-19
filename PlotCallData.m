function [] = PlotCallData(SectionNo)
% Section No. 1:Bar plots of mean number of calls for each stimuli across
% birds
% Section No. 2: Bar plots of mean latency for each stimuli
%Section No. 3:Calculates and plots the difference between baseline calls and response to stimuli 
%Section No. 4: Bird specific rastor plots of all calls (with duration representation) for
%each stimulus
cd E:\Lab\data2\MatFiles_ASSLData\AllBirdsInfo\
load ('AllBirdsInfo.mat') %Output from CallResponseAnalysis
BirdNames = fieldnames(AllBirdInfo);
AllStimuli = {'w','i','r','m','n'};
if SectionNo == 1
    MeanBirdCalls =[];
    for i = 1:length(BirdNames) %calling each bird
        Days = fieldnames(AllBirdInfo.(BirdNames{i}));
        NumCall =[];
        for j = 1:length(Days) %calling each day
            TempCall = AllBirdInfo.(BirdNames{i}).(Days{j}).NumberOfCalls; %calling calls for the day
            for k = 1:length(AllStimuli) 
                NumCallTemp = TempCall(:,k); %calls for each stimulus
                NumCall(j,k) = mean(NumCallTemp); %mean of calls of each day for a stimulus 
                clear *Temp
            end
            clear Temp*
        end
        MeanBirdCalls = [MeanBirdCalls; mean(NumCall,1)]; %concatenating mean calls of each bird for a stimulus
        clear NumCall
    end
    figure;
    bar(mean(MeanBirdCalls),0.4); hold on
    errorbar(1:length(AllStimuli),mean(MeanBirdCalls),(std(MeanBirdCalls)/sqrt(length(MeanBirdCalls))),'.k'); hold on
    for i = 1:length(BirdNames)
        plot([1:length(AllStimuli)]+0.1,MeanBirdCalls(i,:),'-ok','MarkerFaceColor','k','MarkerSize',3.5)
    end
    set(gca,'fontsize',11.5)
    xlabel('Category','fontsize',11.5);
    set(gca,'Xticklabels',{'IN+Motif','IN','Motif+IN','Motif','Noise'},'XTickLabelRotation',45,'fontsize',10) 
    ylabel('Mean number of calls','fontsize',11.5)   
    box off
    
    
    
    
elseif SectionNo == 2
    AllBirdsLatency =[];
    for i=1:length(BirdNames) %calling each bird
        Days = fieldnames(AllBirdInfo.(BirdNames{i}))
        MeanLatency = zeros(length(Days),length(AllStimuli));
        for j = 1:length(Days) %calling each day
            TempLatency = AllBirdInfo.(BirdNames{i}).(Days{j}).Latency; %Latency for each day of each bird
            TempLatency(TempLatency == 0) = 2.5; %not considering latency where no calls were produced
            MeanLatency(j,1:size(TempLatency,2)) = mean(TempLatency); %mean of latencies of each day
            clear Temp*
        end
        MeanLatency(MeanLatency == 0) =2.5; %arbitary high value nearly equal to highest response window
        AllBirdsLatency = [AllBirdsLatency; mean(MeanLatency,1)]; %mean of latencies of each bird for all stimuli
        clear MeanLatency
    end
    figure;
    bar(nanmean(AllBirdsLatency),0.4); hold on
    errorbar(1:length(AllStimuli),nanmean(AllBirdsLatency),nanstd(AllBirdsLatency)/sqrt(length(find(~isnan(AllBirdsLatency)))),'.k'); hold on
    for i = 1:length(BirdNames)
        plot([1:length(AllStimuli)]+0.1,AllBirdsLatency(i,:),'-ok','MarkerFaceColor','k','MarkerSize',3.5)
    end
    set(gca,'fontsize',11.5)
    xlabel('Category','fontsize',11.5);
    set(gca,'Xticklabels',{'IN+Motif','IN','Motif+IN','Motif','Noise'},'XTickLabelRotation',45,'fontsize',10) %3INs cat present for black58pink65
    ylabel('Latency (secs)','fontsize',11.5)
    box off
    
    
    
    
elseif SectionNo == 3
    % This part calculate the difference between baseline calls and respose
    % to stimuli for each trial and takes its mean
    MeanBirdDiff =[];
    for i = 1:length(BirdNames) % each bird
        Days = fieldnames(AllBirdInfo.(BirdNames{i}));
        MeanDiff =[];
        for j = 1:length(Days) % each day
            TempCall = AllBirdInfo.(BirdNames{i}).(Days{j}).NumberOfCalls; % no. of response calls per day per bird
            TempBasecall = AllBirdInfo.(BirdNames{i}).(Days{j}).Numberofbasecalls; %no. of baseline calls  per day per bird
            for k = 1:length(AllStimuli)
                NumCallTemp = TempCall(:,k); %no. of stimulus specific response calls
                NumBasecallTemp = TempBasecall (:,k); % no. of stimulus specific baseline calls
                MeanDiff(j,k) = mean(NumCallTemp-NumBasecallTemp); %mean of difference of response no. and baseline no. for each stimulus
                clear *Temp
            end
            clear Temp*
        end
        MeanBirdDiff = [MeanBirdDiff; mean(MeanDiff,1)]; %mean of difference in number of calls for each bird
        clear MeanDiff
    end
    figure;
    bar(mean(MeanBirdDiff),0.4); hold on
    errorbar(1:length(AllStimuli),mean(MeanBirdDiff),std(MeanBirdDiff)/sqrt(length(MeanBirdDiff)),'.k'); hold on
    for i = 1:length(BirdNames)
        plot([1:length(AllStimuli)]+0.1,MeanBirdDiff(i,:),'-ok','MarkerFaceColor','k','MarkerSize',3.5)
    end
    set(gca,'fontsize',11.5)
    xlabel('Category','fontsize',11.5);
    set(gca,'Xticklabels',{'IN+Motif','IN','Motif+IN','Motif','Noise'},'XTickLabelRotation',45,'fontsize',10) %3INs cat present for black58pink65
    ylabel('Response - Baseline','fontsize',11.5)
    box off
    
    
    
    
    
% Section 4: Creates a Rastor Plot of calls for each stimulus with a
% representation of call duration (For each bird)
elseif SectionNo == 4 
    cd E:\Lab\data2\PyCBS\SongFiles\ASSLNoteFiles\
    load('brwn47org66_7INwithMotif.wav.ASSLData.mat') %loading WithIN Songfile
    SyllLabels = handles.ASSL.SyllLabels; %calling all Labels
    SyllOnsets = handles.ASSL.SyllOnsets; %calling all onsets
    SyllOffsets = handles.ASSL.SyllOffsets; %calling all offsets
    WithINOnsets = (SyllOnsets{1,1}(11:20))/1000; % selecting Onsets of each stimulus and converting to seconds
    MotifOnsets = (SyllOnsets{1,1}(18:20))/1000;
    OnlyINsOnsets = (SyllOnsets{1,1}(11:17))/1000;
    WithINOffsets = (SyllOffsets{1,1}(11:20))/1000;
    MotifOffsets = (SyllOffsets{1,1}(18:20))/1000;
    OnlyINsOffsets = (SyllOffsets{1,1}(11:17))/1000;
    %     Colors = {'r','k','b','g','m'};
    for i = 1:length(BirdNames)
        Days = fieldnames(AllBirdInfo.(BirdNames{i}));
        WResOn ={}; IResOn ={}; RResOn ={}; MResOn ={}; NResOn ={}; TNo =0;
        WResOff ={}; IResOff ={}; RResOff ={}; MResOff ={}; NResOff ={};
         WBasOn={}; IBasOn ={}; RBasOn ={}; MBasOn ={}; NBassOn ={};
        WBasOff ={}; IBasOff ={}; RBasOff ={}; MBasOff ={}; NBasOff ={};
        for j = 1:length(Days)
            ResponseOnset = AllBirdInfo.(BirdNames{i}).(Days{j}).ResponseOnset;
            ResponseOffset = AllBirdInfo.(BirdNames{i}).(Days{j}).ResponseOffset;
            StimulusOnsets = AllBirdInfo.(BirdNames{i}).(Days{j}).StimulusOnsets;
            BaselineOnset = AllBirdInfo.(BirdNames{i}).(Days{j}).BaselineOnset;
            BaselineOffset = AllBirdInfo.(BirdNames{i}).(Days{j}).BaselineOffset;
            StimOnsets = AllBirdInfo.(BirdNames{i}).(Days{j}).StimOnsets;
            TNo(j) = length(AllBirdInfo.(BirdNames{i}).(Days{j}).NumberOfCalls);
            for k = 1:size(ResponseOnset,2)
                TempResOn = ResponseOnset(:,k);
                TempResOff = ResponseOffset(:,k);
                TempStimOn = StimulusOnsets(:,k);
                TempBaseOff = BaselineOffset(:,k);
                TempBaseOn = BaselineOnset(:,k);
                for y = 1:length(TempResOn)
                       ResOnTemp = TempResOn{y};
                       ResOnTemp(ResOnTemp == 0) = nan;
                       ResOffTemp = TempResOff{y};
                       ResOffTemp(ResOffTemp == 0) = nan;
                       StimOnTemp = TempStimOn{y};
                       StimOnTemp(StimOnTemp == 0) = nan;
                       BaseOnTemp = TempBaseOn{y};
                       BaseOnTemp(BaseOnTemp == 0) = nan;
                       BaseOffTemp = TempBaseOff{y};
                       BaseOffTemp(BaseOffTemp == 0) = nan;
                       if y == 1
                           WResOn{k,j} = ResOnTemp - StimOnTemp;
                           WResOff{k,j} = ResOffTemp - StimOnTemp;
                            WBasOn{k,j} = BaseOnTemp - StimOnsets(y,k);
                           WBasOff{k,j} = BaseOffTemp - StimOnsets(y,k);
                       elseif y == 2
                           IResOn{k,j} = ResOnTemp - StimOnTemp;
                           IResOff{k,j} = ResOffTemp - StimOnTemp;
                           IBasOn{k,j} = BaseOnTemp - StimOnsets(y,k);
                           IBasOff{k,j} = BaseOffTemp - StimOnsets(y,k);
                       elseif y ==3
                           RResOn{k,j} = ResOnTemp - StimOnTemp;
                           RResOff{k,j} = ResOffTemp - StimOnTemp;
                           RBasOn{k,j} = BaseOnTemp - StimOnsets(y,k);
                           RBasOff{k,j} = BaseOffTemp - StimOnsets(y,k);
                       elseif y ==4 
                           MResOn{k,j} = ResOnTemp - StimOnTemp;
                           MResOff{k,j} = ResOffTemp - StimOnTemp;
                           MBasOn{k,j} = BaseOnTemp - StimOnsets(y,k);
                           MBasOff{k,j} = BaseOffTemp - StimOnsets(y,k);                           
                       elseif y ==5
                           NResOn{k,j} = ResOnTemp - StimOnTemp;
                           NResOff{k,j} = ResOffTemp - StimOnTemp;
                           NBasOn{k,j} = BaseOnTemp - StimOnsets(y,k);
                           NBasOff{k,j} = BaseOffTemp - StimOnsets(y,k);
                       end
                       clear *Temp
                end
               clear Temp* 
            end
        end
        subplot(2,2,i)
        
        % ------- Make patch for played back motif -------------------------------
        Temp = cellfun(@(x) length(x),WResOn,'UniformOutput',true);
%         Ypos2 = length(find(Temp >=1));
        Ypos2 = sum(TNo);
        for h = 1:length(WithINOnsets)
            if h == 1
                patch([0 (WithINOffsets(1) - WithINOnsets(1)) (WithINOffsets(1) - WithINOnsets(1)) 0],[0 0 Ypos2 Ypos2 ],'r','FaceAlpha',0.3,'EdgeColor','none');hold on
            else
                patch([(WithINOnsets(h)-WithINOnsets(1)) (WithINOffsets(h)-WithINOnsets(1)) (WithINOffsets(h)-WithINOnsets(1)) (WithINOnsets(h)-WithINOnsets(1))],[0 0 Ypos2 Ypos2 ],'r','FaceAlpha',0.3,'EdgeColor','none');hold on
                legend('IN+Motif') 
            end
        end
        YPos1 = Ypos2;
        Temp = cellfun(@(x)  length(x),IResOn,'UniformOutput',true);
%         YPosIN = Ypos2 + length(find(Temp>=1));
        YPosIN = Ypos2 + sum(TNo);
        for h = 1:length(OnlyINsOnsets)
            if h == 1
                patch([0 (OnlyINsOffsets(1) - OnlyINsOnsets(1)) (OnlyINsOffsets(1) - OnlyINsOnsets(1)) 0],[YPos1 YPos1 YPosIN YPosIN],'g','FaceAlpha',0.3,'EdgeColor','none');hold on
            else
                patch([(OnlyINsOnsets(h)-OnlyINsOnsets(1)) (OnlyINsOffsets(h)-OnlyINsOnsets(1)) (OnlyINsOffsets(h)-OnlyINsOnsets(1)) (OnlyINsOnsets(h)-OnlyINsOnsets(1))],[YPos1 YPos1 YPosIN YPosIN],'g','FaceAlpha',0.3,'EdgeColor','none');hold on
            end
        end
        YPosStart = YPosIN;
        Temp =  cellfun(@(x)  length(x),RResOn,'UniformOutput',true)
%         YPosEnd = length(find(Temp>=1)) + YPosIN
        YPosEnd = sum(TNo) + YPosIN;
        Count =9;
        for h = 1:length(WithINOnsets)
            if h == 1
                patch([0 (WithINOffsets(8) - WithINOnsets(8)) (WithINOffsets(8) - WithINOnsets(8)) 0],[YPosStart YPosStart YPosEnd YPosEnd],'b','FaceAlpha',0.3,'EdgeColor','none');hold on  
            elseif h <= 3
                patch([(WithINOnsets(Count)-WithINOnsets(8)) (WithINOffsets(Count)-WithINOnsets(8)) (WithINOffsets(Count)-WithINOnsets(8)) (WithINOnsets(Count)-WithINOnsets(8))],[YPosStart YPosStart YPosEnd YPosEnd],'b','FaceAlpha',0.3,'EdgeColor','none');hold on
                Count = Count +1;
            elseif h == 4
                LastSyllCor= WithINOffsets(10)-WithINOnsets(8);
                patch([LastSyllCor+0.052 (LastSyllCor+0.052+(WithINOffsets(1)-WithINOnsets(1))) (LastSyllCor+0.052+(WithINOffsets(1)-WithINOnsets(1))) LastSyllCor+0.052],[YPosStart YPosStart YPosEnd YPosEnd],'b','FaceAlpha',0.3,'EdgeColor','none');hold on
                Count =2;
            else
                x1= LastSyllCor+0.052+(WithINOnsets(Count)-WithINOnsets(1));
                x2 = x1 + (WithINOffsets(Count)-WithINOnsets(Count));
                patch([x1 x2 x2 x1],[YPosStart YPosStart YPosEnd YPosEnd],'b','FaceAlpha',0.3,'EdgeColor','none');hold on
                Count = Count +1;
            end
        end
        YPosStartM = YPosEnd;
        Temp = cellfun(@(x)  length(x),MResOn,'UniformOutput',true);
%         YPosEndM = YPosEnd + length(find(Temp>=1));
        YPosEndM = YPosEnd + sum(TNo);
        for h = 1:length(MotifOnsets)
            if h == 1
                patch([0 (MotifOffsets(1) - MotifOnsets(1)) (MotifOffsets(1) - MotifOnsets(1)) 0],[YPosStartM YPosStartM YPosEndM YPosEndM],[0.7 0.7 0.7],'FaceAlpha',0.3,'EdgeColor','none');hold on
                
            else
                patch([(MotifOnsets(h)-MotifOnsets(1)) (MotifOffsets(h)-MotifOnsets(1)) (MotifOffsets(h)-MotifOnsets(1)) (MotifOnsets(h)- MotifOnsets(1))],[YPosStartM YPosStartM YPosEndM YPosEndM],[0.7 0.7 0.7],'FaceAlpha',0.3,'EdgeColor','none');hold on
            end
        end
        YPosStartN = YPosEndM;
        Temp =cellfun(@(x)  length(x),NResOn,'UniformOutput',true);
%         YPosEndN =  YPosEndM + length(find(Temp >=1));
        YPosEndN =  YPosEndM + sum(TNo);
        for h = 1:length(WithINOnsets)
            if h == 1
                patch([0 (WithINOffsets(1) - WithINOnsets(1)) (WithINOffsets(1) - WithINOnsets(1)) 0],[YPosStartN YPosStartN YPosEndN YPosEndN ],'m','FaceAlpha',0.3,'EdgeColor','none');hold on
            else
                patch([(WithINOnsets(h)-WithINOnsets(1)) (WithINOffsets(h)-WithINOnsets(1)) (WithINOffsets(h)-WithINOnsets(1)) (WithINOnsets(h)-WithINOnsets(1))],[YPosStartN YPosStartN YPosEndN YPosEndN ],'m','FaceAlpha',0.3,'EdgeColor','none');hold on
            end
        end
        

        % ----------------------------------------------------------------------
        % ----------- Make raster plot for all responses -----------------------
        Count =1;
        for y = 1:length(Days)
            TempResOn = WResOn(:,y);
            TempResOff = WResOff(:,y);
            TempBaseOn = WBasOn(:,y);
            TempBaseOff = WBasOff(:,y);
            for t = 1:TNo(y)
              plot([TempResOn{t} TempResOff{t}]',repmat(Count,length(TempResOn{t}),2)' ,'-k'); hold on
              plot([TempBaseOn{t} TempBaseOff{t}]',repmat(Count,length(TempBaseOn{t}),2)' ,'-k'); hold on
              Count = Count+1;
            end    
            clear Temp*
        end
        
        for y = 1:length(Days)
            TempResOn = IResOn(:,y);
            TempResOff = IResOff(:,y);
            TempBaseOn = IBasOn(:,y);
            TempBaseOff = IBasOff(:,y);
            for t = 1:TNo(y)
              plot([TempResOn{t} TempResOff{t}]',repmat(Count,length(TempResOn{t}),2)' ,'-k'); hold on
              plot([TempBaseOn{t} TempBaseOff{t}]',repmat(Count,length(TempBaseOn{t}),2)' ,'-k'); hold on
              Count = Count+1;
            end  
            clear Temp*
        end
        for y = 1:length(Days)
            TempResOn = RResOn(:,y);
            TempResOff = RResOff(:,y);
            TempBaseOn = RBasOn(:,y);
            TempBaseOff = RBasOff(:,y);
            for t = 1:TNo(y)
              plot([TempResOn{t} TempResOff{t}]',repmat(Count,length(TempResOn{t}),2)' ,'-k'); hold on
              plot([TempBaseOn{t} TempBaseOff{t}]',repmat(Count,length(TempBaseOn{t}),2)' ,'-k'); hold on
              Count = Count+1;
            end
            clear Temp*
        end
        for y = 1:length(Days)
            TempResOn = MResOn(:,y);
            TempResOff = MResOff(:,y);
            TempBaseOn = MBasOn(:,y);
            TempBaseOff = MBasOff(:,y);
            for t = 1:TNo(y)
              plot([TempResOn{t} TempResOff{t}]',repmat(Count,length(TempResOn{t}),2)' ,'-k'); hold on
              plot([TempBaseOn{t} TempBaseOff{t}]',repmat(Count,length(TempBaseOn{t}),2)' ,'-k'); hold on
              Count = Count+1;
            end
            clear Temp*
        end
        for y = 1:length(Days)
            TempResOn = NResOn(:,y);
            TempResOff = NResOff(:,y);
            TempBaseOn = NBasOn(:,y);
            TempBaseOff = NBasOff(:,y);
            for t = 1:TNo(y)
              plot([TempResOn{t} TempResOff{t}]',repmat(Count,length(TempResOn{t}),2)' ,'-k'); hold on
              plot([TempBaseOn{t} TempBaseOff{t}]',repmat(Count,length(TempBaseOn{t}),2)' ,'-k'); hold on
              Count = Count+1;
            end
            clear Temp*
        end
        title(BirdNames{i}, 'fontweight', 'normal', 'fontsize',8.5);
        xlabel('Time relative to Stimulus Onsets','fontsize',8.5);
        ylabel('Trial Number','fontsize',8.5);
        xlim([-1 2.6]);
        
        % ---------------------------------------------------------------------
    end
    set(gcf, 'ReSize', 'on');
    set(gcf, 'Color', 'w');
    set(gcf, 'Units', 'inches');
    set(gcf, 'Position', [1 0 7 8]);
    set(gcf, 'PaperPositionMode', 'auto');
end