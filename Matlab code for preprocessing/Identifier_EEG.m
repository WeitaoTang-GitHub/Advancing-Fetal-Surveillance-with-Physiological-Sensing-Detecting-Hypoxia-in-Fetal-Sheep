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

fs = 400;
folder_path = 'C:\Users\callu\Documents\2023 UNI\FYP\FYP MATLAB';  % Replace with the path to your folder

% Create a file datastore to read files that start with "Clean Data2"
fds = fileDatastore(fullfile(folder_path, 'Clean Data2*.mat'), 'ReadFcn', @importdata);

% Get the full file names
fullFileNames = fds.Files;

% Get the number of files
numFiles = length(fullFileNames);

%Variables for use if loop must be restarted
currentfile = 1;
BT_iter = 1;
fig_iter = 1;

window_len = 2000;
overlap =round(0.75*window_len);


%iterating from current file name through array of file names
for k = currentfile:numFiles

    %% change line below
    filename = erase(fullFileNames{k}, "C:\Users\Matlab Space\");
    EEG = load(filename);
    filename = erase(filename, 'C:\Users\callu\Documents\2023 UNI\FYP\FYP MATLAB\Clean Data');
    filename = erase(filename, '.mat');
    filename = erase(filename, 'Channel 1');
    filename = erase(filename, 'Channel 2');
    filename = erase(filename, 'Channel 3');

    fprintf('\nNow reading file number %d %s\n', k, filename);


    Num_Segments = 4;
    duration = length(EEG.save_data);
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
        EEG_Segments = zeros(fs*15,Num_Segments);
        if duration > 1560000/5

            for J = 1:Num_Segments
                for I = 1:fs*15
                    EEG_Segments(I,J) = EEG.save_data(I+(J-1)*fs*15);
                end

                [powers,rel_powers,power_ratios,total_power] = EEGFeatureExtract(EEG_Segments(:,J), fs, window_len, overlap);
                %% EEG FEATURE EXTRACTION

                % need to work out why some powers are negative
                % then need to transfer it all into a structure


            


            new_filename = append(filename," Segment ")   ;
            new_filename = append(new_filename,num2str(J));

            %creating quality struct
            ss = struct("File", new_filename, "TotalPower",total_power, "DeltaPower", powers(1),"ThetaPower", powers(2), "AlphaPower",powers(3),"BetaPower",powers(4),"DeltaRelative", rel_powers(1),"ThetaRelative", rel_powers(2), "AlphaRelative",rel_powers(3),"BetaRelative",rel_powers(4));

            Bigtable(BT_iter) = ss;
            BT_iter = BT_iter + 1;
            end
        end
    else
        Fraction = array(array == str2double(erase(filename,"_UCO")),2);
        UCO = round(Fraction*length(EEG.save_data));


        if Fraction > 0.93
            Num_Segments = 2;

        else
            Num_Segments = 4;
        end

        EEG_Segments = zeros(fs*15*60,Num_Segments);
        if duration > 1560000/5
            if Fraction < 0.98

                for J = 1:Num_Segments

                    for i = 1:400*15*60
                        EEG_Segments(i,J) = EEG.save_data(UCO+i+(J-1)*400*15*60);
                    end


                    %% EEG FEATURE EXTRACTION GOES HERE

                    [powers,rel_powers,power_ratios,total_power] = EEGFeatureExtract(EEG_Segments(:,J), fs, window_len, overlap);


                    new_filename = append(filename," Segment ")   ;
                    new_filename = append(new_filename,num2str(J));

                    %creating quality struct
                    ss = struct("File", new_filename, "TotalPower",total_power, "DeltaPower", powers(1),"ThetaPower", powers(2), "AlphaPower",powers(3),"BetaPower",powers(4),"DeltaRelative", rel_powers(1),"ThetaRelative", rel_powers(2), "AlphaRelative",rel_powers(3),"BetaRelative",rel_powers(4));

                    Bigtable(BT_iter) = ss;
                    BT_iter = BT_iter + 1;

                end
            end
        end

    end



end

writetable(struct2table(Bigtable), 'Data EEG Features (V4).xlsx')


