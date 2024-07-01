%Written by Weitao Tang, 25/06/2024
close all
clc

%Reading all file names with format "Main Data\[Subject number]\[filename]"
%that are in adicht format

%% fds = fileDatastore('*.adicht', 'ReadFcn', @importdata); 
%%
fds = fileDatastore('Fake data\21203\*.adicht', 'ReadFcn', @importdata);
fullFileNames = fds.Files;
numFiles = length(fullFileNames);

%%
%loading quality excel from Quality Check.m
% changed from big table or the excel to a logical 1 or 0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%quality = load("Quality_logical.mat").ans;
ExcelSheet = readmatrix('Data Quality.xlsx');

quality = ExcelSheet(:,4);

%Variables for use if loop must be restarted
currentfile = 1;
quality_iter = 1;

%iterating from current file name through array of file names
for k = currentfile:numFiles
    %creating filename variable for saving and cmc printing
    %change erasing directory as needed
    filename = erase(fullFileNames{k}, ["E:\Raw Data", ".adicht"]);
    fprintf('\nNow reading file number %d %s\n', k, filename);

    %reading file of relevant file name
    readfile = append(filename, ".adicht");

    %checking for empty data, this array must be filled manually
    if ~ismember(k, [])

        %loading relevant file, this fails if file is empty
        f = adi.readFile(readfile);

        %iterating through multiple records, referred to here as channel
        channel = f.n_records;

        for i = 1:channel
            %% Comment out below for 
            if quality(quality_iter)==1
              
                fprintf('Channel Number %d\n', i);
                
                %loading left eeg data, sample date, and
                %downsample amount(unused)
                LEEG_chan = f.getChannelByName('L EEG');
                raw_LEEG_data = LEEG_chan.getData(i)*10^3;
                fs = LEEG_chan.fs(i);
                ds = LEEG_chan.downsample_amount(i);
                
                %loading right eeg data
                REEG_chan = f.getChannelByName('R EEG');
                raw_REEG_data = REEG_chan.getData(i)*10^3;

                %creating matrix for WICA comparison
                EEG_matrix = [raw_LEEG_data, raw_REEG_data];
                
                %WICA
                partial_clean_EEG = clean(EEG_matrix);

                %Frequency band filtering
                clean_EEG = newclean(partial_clean_EEG(1,:), fs);

                %saving data for later use
                save_data = clean_EEG;
                savefile = append(erase(filename, "Main Data"), " Channel "+i+"_EEG",".mat");
                save(savefile, 'save_data')
            else
                %for if file is a 0 in quality array
                fprintf('File is of poor quality\n');
            end
            %iterating up the quality array
            quality_iter = quality_iter + 1;
        end
    else
        %for if file is empty
        fprintf('File contains no Data\n');
        %iterating up the quality array
        quality_iter = quality_iter + 1;
    end
end
