%Written by Charles Byron, 20/02/2023
close all
clc

%Reading all file names with format "Main Data\[Subject number]\[filename]"
%that are in adicht format

%% change line below
fds = fileDatastore('Clean Data\Focus\*.mat', 'ReadFcn', @importdata);
fullFileNames = fds.Files;
numFiles = length(fullFileNames);

%Variables for use if loop must be restarted
currentfile = 1;
BT_iter = 1;

%iterating from current file name through array of file names
for k = currentfile:numFiles
    %creating filename variable for saving and cmc printing
    %change erasing directory as needed

    %% change line below
    filename = erase(fullFileNames{k}, "C:\Users\Matlab Space\");
    fprintf('\nNow reading file number %d %s\n', k, filename);
    
    %loading clean EEG from file
    EEG = load(filename);
    
    %processing EEG and detecting HIpeaks
    [duration, peaknum, gamma1, gamma2, pph] = EEGProcess(EEG.save_data);
    
    %creating struct of same stats potentially relevant
    s = struct("File", filename, "Duration", duration, "HI_Peaks", peaknum, 'Gamma1', gamma1, 'Gamma2', gamma2, "Peaks_per_halfhour", pph);
    Bigtable(BT_iter) = s;
    BT_iter = BT_iter + 1;
    
    %plotting final graph showing peaks per half hour
    figure(1)
    hold on
    title("HI Peaks per half hour")
    bar(linspace(-length(pph)/4, length(pph)/4, length(pph)), pph)
    xlabel("Half hour Increments")
    ylabel("Number of Peaks")
    hold off
end

%saving struct of relevant stats
%writetable(struct2table(Bigtable), '2_02_2023 Processed Data.xlsx')