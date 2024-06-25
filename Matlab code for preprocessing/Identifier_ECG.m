close all
clear all
clc

folder_path = 'C:\Users\callu\Documents\2023 UNI\FYP\FYP MATLAB';  % Replace with the path to your folder
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
% Create a file datastore to read files that start with "Clean Data2"
fds = fileDatastore(fullfile(folder_path, 'Clean Data ECG*.mat'), 'ReadFcn', @importdata);

% Get the full file names
fullFileNames = fds.Files;

% Get the number of files
numFiles = length(fullFileNames);

%Variables for use if loop must be restarted
currentfile = 1;
BT_iter = 1;

%iterating from current file name through array of file names
for k = currentfile:numFiles

    filename = erase(fullFileNames{k}, "C:\Users\Matlab Space\");

    % CLEAN UP FILE NAME
    ECG = load(filename);
    filename = erase(filename, 'C:\Users\callu\Documents\2023 UNI\FYP\FYP MATLAB\Clean Data ECG');
    filename = erase(filename, '.mat');
    filename = erase(filename, 'Channel 1');
    filename = erase(filename, 'Channel 2');
    filename = erase(filename, 'Channel 3');

    %SIGNAL DURATION TEST
    fprintf('\nNow reading file number %d %s\n', k, filename);
    duration = length(ECG.save_data);
    seconds = duration/400;
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

    %BASELINE OR UCO CHECK

    if contains(filename, 'Baseline')


        %SEGMENTING THE ECG
        Num_Segments = 4;
        ECG_Segments = zeros(400*15*60,Num_Segments);
        for J = 1:Num_Segments
            for I = 1:400*15*60
                ECG_Segments(I,J) = ECG.save_data(I+(J-1)*400*15*60)/1000;
            end
            
            if J == 2 && all(filename == '20252_Baseline ')
                for I = 1:400*15*60
                    ECG_Segments(I,J) = ECG.save_data(I+(J+2)*400*15*60)/1000;
                end
            elseif  J == 3 && all(filename == '21044_Baseline ')
                for I = 1:400*15*60
                    ECG_Segments(I,J) = ECG.save_data(I+(J+2)*400*15*60)/1000;
                end
            else
            end

            new_filename = append(filename,"Segment ")   ;
            new_filename = append(new_filename,num2str(J));


            % QRS POS DETECTION
            % (NOTE JQRS w PARAMETERS GAVE MOST ACCURATE DETECTION)

            %[qrs_pos] = pantompkins_qrs(ECG_Segments(:,J),fs, true);
            [qrs_pos,~,~] = jqrs_mod(ECG_Segments(:,J),0.2,0.05,400);
            

      
%             if all(filename == '20244_Baseline ') && J==4
%                 figure(1)
%                 plot(ECG_Segments(:,J))
%                 hold on
%                 plot(qrs_pos,ECG_Segments(qrs_pos,J),"*")
%                 hold off
% 
%                 figure(2)
%                 plot(diff(qrs_pos),"*-")
%                 hold off
% 
%                 P1 = linspace(0.05,.95,10);
%                 P2 = linspace(0.05,0.6,10);
%                 outputtest = zeros(10,10);
%                 for K = 1:10
%                     for L = 1: 10
%                         [qrs_pos,~,~] = jqrs_mod(ECG_Segments(:,J),P1(L),P2(K),400);
%                         outputtest(K,L) =length(qrs_pos);
%                     end
%                 end
%             end

            %% HRV CODE
%             HRVparams = InitializeHRVparams(char(new_filename));
%             [HRVout, ResultsFileName] = Main_HRV_Analysis(ECG_Segments(:,J),'','ECGWaveform',HRVparams);
%             [HRVout2, ResultsFileName2] = Main_HRV_Analysis((diff(qrs_pos) / fs),t,'RRIntervals',HRVparams);

            % Calculate Heart Rate
            heart_rate = length(qrs_pos) / (length(ECG_Segments(:,J)) / fs) * 60; % Heart rate in BPM

            % Calculate RR intervals
            rr_intervals = diff(qrs_pos) / fs; % RR intervals in seconds

            % Calculate average RR interval
            avg_rr_interval = mean(rr_intervals); % Average RR interval in seconds

            % Calculate heart rate variability (HRV) features
            sdnn = std(rr_intervals); % Standard deviation of RR intervals
            rmssd = sqrt(mean(diff(rr_intervals).^2)); % Root mean square of successive differences of RR intervals
            nn50 = sum(abs(diff(rr_intervals)) > 0.05); % Number of successive RR interval differences greater than 0.05 seconds
            pnn50 = nn50 / (length(rr_intervals) - 1) * 100; % Percentage of successive RR interval differences greater than 0.05 seconds
            
            [Pxx,f] = plomb(rr_intervals-mean(rr_intervals),[0:length(rr_intervals)-1]/fs);
            if f(2)<0.15
                lf_power = trapz(f(f<0.15),Pxx(f<0.15));
                hf_power = trapz(f(f>=0.15 & f<=0.4),Pxx(f>=0.15 & f<=0.4));
                lf_hf_ratio = lf_power/hf_power;
            else
                lf_power = 0;
                hf_power = 0;
                lf_hf_ratio=0;
            end



            %creating quality struct
            ss = struct("File", new_filename,'Heart_rate', heart_rate, "Average_RR_interval", avg_rr_interval, "SDNN", sdnn,'RMSSD',rmssd,'NN50',nn50,'pNN50',pnn50,'LF_Power',lf_power,'HF_Power',hf_power,'Power_Ratio',lf_hf_ratio);
            Bigtable(BT_iter) = ss;
            BT_iter = BT_iter + 1;
        end

    %BASELINE OR UCO CHECK
    else
        
        % SOME UCO FILES NOT LONG ENOUGH -> EXTRACTS MAX SEGMENTS POSSIBLE
        Fraction = array(find(array == str2num(erase(filename,"_UCO"))),2);
        UCO = round(Fraction*length(ECG.save_data));
        
        if Fraction > 0.98
            Num_Segments = 1;
        elseif Fraction > 0.93
            Num_Segments = 2;
        else
            Num_Segments = 4;
        end

        %SEGMENTING THE ECG
        ECG_Segments = zeros(fs*15*60,Num_Segments);
        for J = 1:Num_Segments

            for i = 1:400*15*60
                ECG_Segments(i,J) = ECG.save_data(UCO+i+(J-1)*400*15*60)/1000;
            end

            new_filename = append(filename,"Segment ")   ;
            new_filename = append(new_filename,num2str(J));


            % QRS POS DETECTION
            % (NOTE JQRS w PARAMETERS GAVE MOST ACCURATE DETECTION)

            %[qrs_pos] = pantompkins_qrs(ECG_Segments(:,J),fs, true);
            [qrs_pos,~,~] = jqrs_mod(ECG_Segments(:,J),0.2,0.05,400);

            %% HRV CODE
%             HRVparams = InitializeHRVparams(char(new_filename));
%             [HRVout, ResultsFileName] = Main_HRV_Analysis(ECG_Segments(:,J),'','ECGWaveform',HRVparams);
%             [HRVout2, ResultsFileName2] = Main_HRV_Analysis((diff(qrs_pos) / fs),t,'RRIntervals',HRVparams);
            
            % Calculate Heart Rate
            heart_rate = length(qrs_pos) / (length(ECG_Segments(:,J)) / fs) * 60; % Heart rate in BPM


            % Calculate RR intervals
            rr_intervals = diff(qrs_pos) / fs; % RR intervals in seconds

            % Calculate average RR interval
            avg_rr_interval = mean(rr_intervals); % Average RR interval in seconds

            % Calculate heart rate variability (HRV) features
            sdnn = std(rr_intervals); % Standard deviation of RR intervals
            rmssd = sqrt(mean(diff(rr_intervals).^2)); % Root mean square of successive differences of RR intervals
            nn50 = sum(abs(diff(rr_intervals)) > 0.05); % Number of successive RR interval differences greater than 0.05 seconds
            pnn50 = nn50 / (length(rr_intervals) - 1) * 100; % Percentage of successive RR interval differences greater than 0.05 seconds
            
            % Compute frequency-domain HRV features using the Lomb-Scargle periodogram
            [Pxx,f] = plomb(rr_intervals-mean(rr_intervals),[0:length(rr_intervals)-1]/fs);
            if f(2)<0.15
                lf_power = trapz(f(f<0.15),Pxx(f<0.15));
                hf_power = trapz(f(f>=0.15 & f<=0.4),Pxx(f>=0.15 & f<=0.4));
                lf_hf_ratio = lf_power/hf_power;

            else
                lf_power = 0;
                hf_power = 0;
                lf_hf_ratio=0;
            end

            %creating quality struct
            ss = struct("File", new_filename,'Heart_rate', heart_rate, "Average_RR_interval", avg_rr_interval, "SDNN", sdnn,'RMSSD',rmssd,'NN50',nn50,'pNN50',pnn50,'LF_Power',lf_power,'HF_Power',hf_power,'Power_Ratio',lf_hf_ratio);
            Bigtable(BT_iter) = ss;
            BT_iter = BT_iter + 1;
        end

    end



end


writetable(struct2table(Bigtable), 'Data ECG Features (V4).xlsx')




%  figure(1)
%             plot(ECG_Segments(:,J))
%             hold on
%             plot(qrs_pos,ECG_Segments(qrs_pos,J),"*")
%             hold off
%
%             figure(2)
%             plot(diff(qrs_pos),"*-")
%             hold off

%             P1 = linspace(0.05,.95,10);
%             P2 = linspace(0.05,0.6,10);
%             outputtest = zeros(10,10);
%             for K = 1:10
%                 for L = 1: 10
%                      [qrs_pos,~,~] = jqrs_mod(ECG_Segments(:,J),P1(L),P2(K),400);
%                     outputtest(K,L) =length(qrs_pos);
%                 end
%             end
