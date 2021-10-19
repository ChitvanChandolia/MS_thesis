function [] = PlaybackBeamBreak()

clear
Dir = pwd
a = arduino;
TrialNum = input('Enter trial number');
DT = datestr(now);
Fid = fopen([DT(1:11) '_' TrialNum '.txt'],'w')
Sensor1 = 'A0'; % Perch No. 2
Sensor2 = 'A1'; % Perch No. 3
Sensor3 ='A2'; % Perch No. 4
Sensor4 = 'A3'; % Perch No. 5
Sensor5 = 'A4';  % Perch No. 6
% Define digital pin for 5 volts to photo diode
configurePin(a, 'D2', 'DigitalOutput')
configurePin(a, 'D3', 'DigitalOutput')
configurePin(a, 'D4', 'DigitalOutput')
configurePin(a, 'D5', 'DigitalOutput')
configurePin(a, 'D7', 'DigitalOutput')
writeDigitalPin(a, 'D2', 1);
writeDigitalPin(a, 'D3', 1)
writeDigitalPin(a, 'D4', 1)
writeDigitalPin(a, 'D5', 1)
writeDigitalPin(a, 'D7', 1)
SongOrder = 'IN_Motif \n Motif_IN \n IN_Only \n Motif_Only \n Noise \n'
fprintf(SongOrder)
PerchNo = input('Perch No')
fprintf(Fid,'%s  %s\n',['Perch no.','Song played'])
fprintf(Fid,'\n%d  %s\n',[ PerchNo(1) 'IN_Motif']);
fprintf(Fid,'%d  %s\n', [PerchNo(2) 'Motif_IN']);
fprintf(Fid,'%d  %s\n',[ PerchNo(3) 'IN_Only']);
fprintf(Fid,'%d  %s\n', [PerchNo(4) 'Motif_Only']);
fprintf(Fid,'%d  %s\n', [PerchNo(5) 'Noise']);
[file path] = uigetfile('*.txt');
cd(path)
fid = fopen(file);
FileNames = textscan(fid,'%s','Delimiter','\n');
Temp =  FileNames{1};
AudioToPlay ={};
for i = 1:length(Temp)
    AudioToPlay{i} = audioread(Temp{i});
end
cd(Dir)
Counter2 =1;
Counter3 =1;
Counter4 =1;
Counter5 =1;
Counter6 =1;
for k = 1:inf
    Fid = fopen([DT(1:11) '_' TrialNum '.txt'],'a')
    VoltVal1 = readVoltage(a, Sensor1) % Voltage for perch no. 2
    VoltVal2 = readVoltage (a, Sensor2) % Voltage for perch no. 3
    VoltVal3 = readVoltage(a, Sensor3) % Voltage for perch no. 4
    VoltVal4 = readVoltage(a, Sensor4) % Voltage for perch no. 5
    VoltVal5 = readVoltage(a, Sensor5) % Voltage for perch no. 6
    % ----- check voltage for perch no. 2 -------------------------
    if VoltVal1 >= 2
        Counter2 = Counter2 +1;
        if Counter2 == 2
            DT = datestr(now);
            sound(AudioToPlay{find(PerchNo == 2)}, 44100)
            pause((length(AudioToPlay{find(PerchNo == 2)})/44100)+1) %
            Counter2 = Counter2 +1;
            fprintf(Fid,'%s  %d\n', DT(13:end), 2)
        end
    else
        Counter2 = 1;
    end
    % ---------- Check voltage for perch no. 3 -----------------
    if VoltVal2 >= 2
        Counter3 =Counter3 +1;
        if Counter3 == 2
            DT = datestr(now);
            sound(AudioToPlay{find(PerchNo == 3)}, 44100)
            pause((length(AudioToPlay{find(PerchNo == 3)})/44100)+1)
            Counter3 =Counter3 +1;
            fprintf(Fid,'%s  %d\n', DT(13:end), 3)
        end
    else
        Counter3 =1;
    end
    % ----------- Check voltage for perch no. 4 ----------------------
    if VoltVal3 >= 2
        Counter4 =Counter4 +1;
        if Counter4 ==2
            DT = datestr(now);
            sound(AudioToPlay{find(PerchNo == 4)}, 44100)
            pause((length(AudioToPlay{find(PerchNo == 4)})/44100)+1)
            Counter4 =Counter4 +1;
            fprintf(Fid,'%s  %d\n', DT(13:end), 4)
        end
    else
       Counter4 = 1; 
    end
    % -------- Check voltage for perch no. 5 ---------------------
    if VoltVal4 >= 2
        Counter5 = Counter5 +1;
        if Counter5 == 2
            DT = datestr(now);
            sound(AudioToPlay{find(PerchNo == 5)}, 44100)
            pause((length(AudioToPlay{find(PerchNo == 5)})/44100)+1)
            Counter5 =Counter5 +1;
            fprintf(Fid,'%s  %d\n', DT(13:end), 5)
        end
    else
        Counter5 = 1;
    end
    % -------- Check voltage for perch no. 6 ----------------------
    if VoltVal5 >= 2
        Counter6 =Counter6 +1;
        if Counter6 == 2
            DT = datestr(now);
            sound(AudioToPlay{find(PerchNo == 6)}, 44100)
            pause((length(AudioToPlay{find(PerchNo == 6)})/44100)+1)
            Counter6 =Counter6 +1;
            fprintf(Fid,'%s  %d\n', DT(13:end), 6)
        end
    else
       Counter6 = 1;
    end
fclose(Fid)
end
