function [peak_index, peaknum] = MarkHIPeaks2(EEG1, filtered_EEG1, gamma1, gamma2)
%MARKHIPEAKS does final processing before identifying and labelling HIPeaks
%   Takes in the 1 by n EEG1 eeg signal, transformed signal and the sample 
%   frequency fs as well as the 2 threshold values.
%   Then uses transformed and original signals to identify HI peaks. 
%   Then outputs the indexes of these peaks, the nuber of them
%   Utilised mostly in EEGProcess.m
%Written by Charles Byron, 20/02/2023

%% Peak identification

%Finding peaks in both signals
[peaksEEG1, PEindex] = findpeaks(abs(EEG1));
[peaksFFT, FFTindex] = findpeaks(abs(filtered_EEG1));

%iterating through each signal and finding peaks at the same time point
%that both exceed threshold values
i=1;
j=1;
k=1;
HIindex = [1];
while (i < length(PEindex))&&(j < length(FFTindex))
    if PEindex(i)==FFTindex(j)
        if (abs(peaksEEG1(i))>=gamma1)&&(abs(peaksFFT(j))>=gamma2)
            HIindex(k) = PEindex(i);
            k = k + 1;
        end
        i = i + 1;
        j = j + 1;
    elseif PEindex(i)>FFTindex(j)
        j = j + 1;
    elseif PEindex(i)<FFTindex(j)
        i = i + 1;
    end
end

%only occurs if there are peaks
if HIindex ~= [1]

    %Ensuring peaks are not too close togteher as to be part of the same spike
    new_index = 1:length(EEG1);
    for i = 1:length(HIindex)-1
        dist = HIindex(i+1)-HIindex(i);
        if dist<23
            new_index = [new_index(1:find(new_index==HIindex(i))), new_index(find(new_index==HIindex(i+1)):end)];
        end
    end
    
    %Using positive and negative parts to allow for negative peak detection
    pos_HIpeaks = zeros(size(new_index));
    neg_HIpeaks = zeros(size(new_index));
    for i = 1:length(HIindex)
        j = find(new_index==HIindex(i));
        if EEG1(HIindex(i))>0
            pos_HIpeaks(j) = EEG1(HIindex(i));
        else
            neg_HIpeaks(j) = EEG1(HIindex(i));
        end
    end
    
    %finding true final peaks
    [truepos_HIpeaks, truepos_index] = findpeaks(pos_HIpeaks);
    [trueneg_HIpeaks, trueneg_index] = findpeaks(abs(neg_HIpeaks));

    %true peak indexes
    peak_index = [(new_index(trueneg_index)), new_index(truepos_index)];
    
    peaknum = length(peak_index);

    fprintf("Total of %5.5d peaks detected\n", peaknum)
else
    %if there are no peaks
    peak_index = [];
    peaknum = 0;
    fprintf("No peaks detected\n")
end

end