close all
clc


%Reading all file names with format "Main Data\[Subject number]\[filename]"
%that are in adicht format
fds = fileDatastore('*.adicht', 'ReadFcn', @importdata);
fullFileNames = fds.Files;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% THIS IS TEMP = 5 TO SAVE TIME TO TEST THE FULL RUNNING OF THE CODE
numFiles = length(fullFileNames);
%numFiles = 5;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Rating scale
z = "Good";
x = "Bad";
c = "Short";
v = "Good but 1 max";
b = "Good but a few max";

%Variables for use if loop must be restarted
fig_iter = 1;
currentfile = 1;
BT_iter = 1;

%iterating from current file name through array of file names

for k = currentfile:numFiles
    %creating filename variable for saving and cmc printing
    %change erasing directory as needed
    filename = erase(fullFileNames{k}, ["C:\Users\callu\Documents\2023 UNI\FYP\FYP MATLAB\", ".adicht"]);
    fprintf('\nNow reading file number %d %s\n', k, filename);

    %reading file of relevant file name
    readfile = append(filename, ".adicht");

    %loading relevant file
    f = adi.readFile(readfile);

    %iterating through multiple records, referred to here as channel
    channel = f.n_records;

    for i = 1:channel
        fprintf('Channel Number %d\n', i);

        %loading only left eeg data
        LEEG_chan = f.getChannelByName('L EEG');
        raw_LEEG_data = LEEG_chan.getData(i)*10^3;
        
        %plotting raw left eeg data
        figure(fig_iter)
        hold on
        plot(raw_LEEG_data)
        title(append(filename, " Channel Number ",num2str(i)))
        hold off
        fig_iter = fig_iter + 1;
        
        %prompt for quality input
        quality = input("What is the file quality ");


        if quality == "Good"
           NumericalQuality = 1;
        else
           NumericalQuality = 0;
        end


        %creating quality struct
        s = struct("File", filename, "Channel", i, "Quality", quality, "NumericalQuality", NumericalQuality);
        Bigtable(BT_iter) = s;
        BT_iter = BT_iter + 1;
    end
end

%saving quality table to excel for referral and later use, alter date
writetable(struct2table(Bigtable), 'Data EEG Quality.xlsx')