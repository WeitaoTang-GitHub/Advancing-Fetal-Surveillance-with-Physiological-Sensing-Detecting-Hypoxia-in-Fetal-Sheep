close all
clear all
clc

array = [20244	0.203703704;
    20252	0.529711336;
    21044	0.000578704;
    21051	0.405259571;
    21071	0.863006088;
    21087	0.906108938;
    21093	0.008514774;
    21122	0.561795412;
    21126	0.05523276;
    21133	0.587652492;
    21165	0.985022801;
    21173	0.94275463;
    21200	0.937521702;
    21203	0.780457881];

fs = 2000;

% 2000
folder_path = 'C:\Users\callu\Documents\2023 UNI\FYP\FYP MATLAB';  % Replace with the path to your folder

% Create a file datastore to read files that start with "Clean Data2"
fds = fileDatastore(fullfile(folder_path, 'Clean Data EMG*.mat'), 'ReadFcn', @importdata);

% Get the full file names
fullFileNames = fds.Files;

% Get the number of files
numFiles = length(fullFileNames);

%Variables for use if loop must be restarted
currentfile = 1;
BT_iter = 1;
fig_iter = 1;

%iterating from current file name through array of file names
for k = currentfile:numFiles

    filename = erase(fullFileNames{k}, "C:\Users\Matlab Space\");
    EMG = load(filename);


    filename = erase(filename, 'C:\Users\callu\Documents\2023 UNI\FYP\FYP MATLAB\Clean Data EMG');
    filename = erase(filename, '.mat');
    filename = erase(filename, 'Channel 1');
    filename = erase(filename, 'Channel 2');

    fprintf('\nNow reading file number %d %s\n', k, filename);


    %loading clean EEG from file


    duration = length(EMG.save_data);
    seconds = duration/fs;
    minutes = 0;
    hours = 0;
    if seconds>60
        minutes = seconds/60;
        seconds = (minutes-floor(minutes))*60;
    end
    if minutes>60
        hours = minutes/60;
        minutes = (hours-floor(hours))*60;
        seconds = (minutes-floor(minutes))*60;
    end

    fprintf("This file contains %.5f hours, %.5f minutes, and %.5f seconds worth of data\n", floor(hours), floor(minutes), seconds)


    if contains(filename, 'Baseline')
        Num_Segments = 4;
        EMG_Segments = zeros(fs*15*60,Num_Segments);
        %         figure(fig_iter + 1)
        if filename == '21126_Baseline '
            Num_Segments=3;
        end 
        for J = 1:Num_Segments
            for I = 1:fs*15*60
                EMG_Segments(I,J) = EMG.save_data(I+(J-1)*fs*15*60)/1000;
            end


            new_filename = append(filename,"Segment ");
            new_filename = append(new_filename,num2str(J));


            s = extract_fetal_emg_features(EMG_Segments(:,J), fs,new_filename);
            Bigtable(BT_iter) = s;
            BT_iter = BT_iter + 1;

        end


    else

        Fraction = array(array == str2double(erase(filename,"_UCO")),2);
        UCO = round(Fraction*length(EMG.save_data));
        if Fraction > 0.98
            Num_Segments = 1;
            window = 10;
        elseif Fraction > 0.93
            Num_Segments = 2;
            window = 15;
        else
            Num_Segments = 4;
            window = 15;
        end
        EMG_Segments = zeros(fs*window*60,Num_Segments);

        if duration > 1560000
        
        for J = 1:Num_Segments
            for i = 1:fs*window*60 
                EMG_Segments(i,J) = EMG.save_data(UCO+i+(J-1)*fs*15*60)/1000;
            end
          

        % EMG CODE RUN ON SEGMENT
        new_filename = append(filename," Segment ");
        new_filename = append(new_filename,num2str(J));

         s = extract_fetal_emg_features(EMG_Segments(:,J), fs,new_filename);
         Bigtable(BT_iter) = s;
        BT_iter = BT_iter + 1;

       
        end
       
        end
    end

end

writetable(struct2table(Bigtable), 'Data EMG Features (V4).xlsx')