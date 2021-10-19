function [AllBirdInfo] = CallResponseAnalysis
AllStimuli = {'w','i','r','m','n'}; % w = IN+Motif; i = IN only; r = Motif+IN; m = Motif only n = Nois
cd E:\Lab\data2\MatFiles_ASSLData\StimulusDur\
load('StimulusDur.mat')
%StimuliDuration = [1.770,1.043,1.770,0.685,1.770 ]; % Durations of all stimuli
ResponseWindow =[];
for i = 1:length(AllStimuli) %loop to add response window to each stimulus
    Temp = eval([AllStimuli{i} '_StimulusDur']);
    ResponseWindow(end+1) = Temp+0.75;
    clear Temp
end
cd ../..
%ResponseWindow = [ ] % Duration including stimuli duration and 0.75 seconds after that
[NUM,BirdNames,RAW]=xlsread('LabelledBirds.xlsx',1,'D2:D10'); %reading all birds' data from excel sheet
[RecDays,x,y] = xlsread('LabelledBirds.xlsx',1,'K2:K10'); %reading days of experiments
%[NUM,BirdNames,RAW]=xlsread('LabelledBirds.xlsx',1,'D15:D18'); %Nest 12: reading all birds' data from excel sheet
%[RecDays,x,y] = xlsread('LabelledBirds.xlsx',1,'K15:K18'); %Nest12; reading days of experiments
cd E:\Lab\data2\MatFiles_ASSLData\ %location of all birds' assl files
for t = 1:length(BirdNames)
    load(BirdNames{t}) %loading first bird
    Days = 1:RecDays(t); %loading data of each day of experiment
    for k = 1:length(Days) %calling each day of experiment
        handles = eval(['Day' num2str(Days(k))]); %calling handles from kth day
        AllLabels = handles.ASSL.SyllLabels; % pulls out all the syllable labels from handles
        AllOnsets = handles.ASSL.SyllOnsets; % pulls out all syllable onsets from handles
        AllOffsets = handles.ASSL.SyllOffsets; % pulls out all offsets from handles
        AllFilesDuration = handles.ASSL.FileDur; % pulls out all files' duration from handles
        CumulatedFileDur = cumsum(cell2mat(AllFilesDuration)); % converts cell into matrix and returns a cumulative sum i.e. 30,60 etc
        CombinedOnsets =[]; CombinedOffsets =[]; CombinedSyllLabels =[]; %defining variables
        for i =1:length(AllLabels)
            if i ~= 1 % logical array: if i is not 1 = true (logical 1); if i is 1 = false (logical 0)
                SyllableOnset = (AllOnsets{i}/1000)+ CumulatedFileDur(i-1); % conversion of onset time from msec to sec and adding cumulative time of previous files
                SyllableOffset = (AllOffsets{i}/1000)+ CumulatedFileDur(i-1); % conversion of offset time from msec to sec and adding cumulative time of previous files
                TempLabels = AllLabels{i}; %temporary variable
            else
                SyllableOnset = AllOnsets{i}/1000; % divide by 1000 to Convert from msec to sec (for first file only)
                SyllableOffset =  AllOffsets{i}/1000; % divide by 1000 to Convert from msec to sec (for first file only)
                TempLabels = AllLabels{i};
            end
            CombinedOnsets = [CombinedOnsets; SyllableOnset(:)]; %combines the two vectors into a matrix
            CombinedOffsets = [CombinedOffsets; SyllableOffset(:)];
            CombinedSyllLabels = [CombinedSyllLabels; TempLabels(:)];
            clear Temp*
        end
        NumberOfCalls =[]; Numberofbasecalls =[]; Latency =[]; CallDuration =[]; ResponseOnset =[]; ResponseOffset = [];StimulusOnsets =[];
        BaselineOnset = []; BaselineOffset = [];StimOnsets =[];
        Count =0;
        for i = 1:length(AllStimuli)
            RowNum =0;
            stimulus = AllStimuli{i};
            Indices = find(CombinedSyllLabels == stimulus);
            Onset = CombinedOnsets(Indices);
            responseoffset = Onset + ResponseWindow(i);
            for j = 1:length(Indices)
                response = find(CombinedOnsets > Onset(j) &  CombinedOnsets <= responseoffset(j));
                NumberOfCalls(RowNum+1,i) = length(response);
                baseline = Onset(j) - 0.75; % duration before stilus onset used to calculate baseline calls = 0.75 seconds
                baselineindices = find(CombinedOnsets > baseline &  CombinedOnsets < Onset(j));
                Numberofbasecalls(RowNum+1,i) = length(baselineindices);
                callonset = CombinedOnsets(response);
                calloffset = CombinedOffsets(response);
                baseonset = CombinedOnsets(baselineindices);
                baseoffset  = CombinedOffsets(baselineindices);                
                if ~isempty(callonset)
                    Latency(RowNum+1,i) =  callonset(1) - Onset(j);
                    CallDuration{i,j} = (calloffset - callonset);
                    ResponseOnset{i,j} = callonset;
                    ResponseOffset{i,j} = calloffset;
                     StimulusOnsets{i,j} =  repmat(Onset(j),length(callonset),1);
                else
                    Latency(RowNum+1,i) = 0;
                    ResponseOnset{i,j} = 0;
                    ResponseOffset{i,j} = 0;
                     StimulusOnsets{i,j} =  repmat(Onset(j),length(callonset),1);
                end 
                StimOnsets(i,j) = Onset(j);
                if ~isempty(baseonset)
                     BaselineOnset{i,j} = baseonset;
                     BaselineOffset{i,j} = baseoffset;
                else
                    BaselineOnset{i,j} =0;
                    BaselineOffset{i,j} =0;
                end
%                 Count = length(CallDuration);     
                 RowNum = RowNum +1;
            end
        end
        clear CombinedOnsets CombinedOffsets CombinedSyllLabels
        AllInfo.(['Day' num2str(Days(k))]).NumberOfCalls = NumberOfCalls;
        AllInfo.(['Day' num2str(Days(k))]).Numberofbasecalls = Numberofbasecalls;
        AllInfo.(['Day' num2str(Days(k))]).Latency = Latency;
        AllInfo.(['Day' num2str(Days(k))]).CallDuration = CallDuration;
        AllInfo.(['Day' num2str(Days(k))]).ResponseOnset = ResponseOnset;
        AllInfo.(['Day' num2str(Days(k))]).ResponseOffset = ResponseOffset;
        AllInfo.(['Day' num2str(Days(k))]).StimulusOnsets = StimulusOnsets;
        AllInfo.(['Day' num2str(Days(k))]).BaselineOnset = BaselineOnset;
        AllInfo.(['Day' num2str(Days(k))]).BaselineOffset = BaselineOffset;
        AllInfo.(['Day' num2str(Days(k))]).StimOnsets = StimOnsets;
        clear NumberOfCalls Numberofbasecalls Latency CallDuration BaselineOnset BaselineOffset ResponseOnset ResponseOffset
    end
    AllBirdInfo.(BirdNames{t}) = AllInfo;
    clear AllInfo
end