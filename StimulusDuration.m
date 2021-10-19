cd E:\Lab\data2\PyCBS\SongFiles\ASSLNoteFiles\
load('brwn47org66_7INwithMotif.wav.ASSLData.mat')
SyllLabels = handles.ASSL.SyllLabels;
SyllOnsets = handles.ASSL.SyllOnsets;
SyllOffsets = handles.ASSL.SyllOffsets;
SyllDuration = handles.ASSL.Duration;
I_Index = find(SyllLabels{1} == 'i');
i_StimulusDur = SyllOffsets{1}(17)/1000 - SyllOnsets{1}(11)/1000 
m_StimulusDur = SyllOffsets{1}(20)/1000 - SyllOnsets{1}(18)/1000 
w_StimulusDur = SyllOffsets{1}(20)/1000 - SyllOnsets{1}(11)/1000 
r_StimulusDur = w_StimulusDur
n_StimulusDur = w_StimulusDur