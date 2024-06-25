% Written by Charles Byron, 20/02/2023
close all
clc

%Reading all file names with format "Main Data\[Subject number]\[filename]"
%that are in adicht format
fds = fileDatastore('*.adicht', 'ReadFcn', @importdata);
fullFileNames = fds.Files;
numFiles = length(fullFileNames);

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
    filename = erase(fullFileNames{k}, ["C:\Users\*\Matlab Space\", ".adicht"]);
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
        hold off
        fig_iter = fig_iter + 1;
        
        %prompt for wuality input
        quality = input("What is the file quality ");
        
        %creating quality struct
        s = struct("File", filename, "Channel", i, "Quality", quality);
        Bigtable(BT_iter) = s;
        BT_iter = BT_iter + 1;
    end
end

%saving quality table to excel for referral and later use, alter date
writetable(struct2table(Bigtable), '2_02_2023 Data Quality.xlsx')