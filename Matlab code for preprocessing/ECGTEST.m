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

%Reading all file names with format "Main Data\[Subject number]\[filename]"
%that are in adicht format

%% fds = fileDatastore('*.adicht', 'ReadFcn', @importdata); 
%%
fds = fileDatastore('*.adicht', 'ReadFcn', @importdata);
fullFileNames = fds.Files;
numFiles = length(fullFileNames);


%quality = load("Quality_logical.mat").ans;
ExcelSheet = readmatrix('Data ECG Quality.xlsx');

quality = ExcelSheet(:,4);

%Variables for use if loop must be restarted
currentfile = 1;
quality_iter = 1;
BT_iter = 1;

%iterating from current file name through array of file names
for k = currentfile:numFiles
    %creating filename variable for saving and cmc printing
    %change erasing directory as needed
    filename = erase(fullFileNames{k}, ["C:\Users\callu\Documents\2023 UNI\FYP\FYP MATLAB\", ".adicht"]);
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
                
                %loading ECG data, sample date, and
                %downsample amount(unused)
                ECG_chan = f.getChannelByName('ECG');
                raw_ECG_data = ECG_chan.getData(i);
                fs = ECG_chan.fs(i);
                ds = ECG_chan.downsample_amount(i);

                duration = length(raw_ECG_data);
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
    
                 
                         if contains(filename, 'Baseline')
                          
                          Num_Segments = 4;
                          ECG_Segments = zeros(400*15,Num_Segments);
                          for J = 1:Num_Segments
                              for I = 1:400*15
                                  ECG_Segments(I,J) = raw_ECG_data(I+(J-1)*400*15);
                              end
                                [qrs_pos] = pantompkins_qrs(ECG_Segments(:,J),fs, false);
                              
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
                     

                               
                               new_filename = append(filename," Segment ")   ;  
                               new_filename = append(new_filename,num2str(J));

                                %creating quality struct
                                ss = struct("File", new_filename,'Heart_rate', heart_rate, "Average_RR_interval", avg_rr_interval, "SDNN", sdnn,'RMSSD',rmssd,'NN50',nn50,'pNN50',pnn50);
                                Bigtable(BT_iter) = ss;
                                BT_iter = BT_iter + 1;
                          end
                
                       
                %% CAN BE UNCOMMENTED ONCE UCO CAN BE FOUND
                       
                         else
                %             % Issue of not knowing when the Occlusion Occurs precisely 
                             Fraction = array(find(array == str2num(erase(filename,"_UCO"))),2);
                             UCO = round(Fraction*length(raw_ECG_data)); 
                             if Fraction > 0.98
                                Num_Segments = 1;   
                             elseif Fraction > 0.93
                                Num_Segments = 3;       
                             else
                                Num_Segments = 4;
                             end
                    
                             ECG_Segments = zeros(400*15,Num_Segments);   
                             for J = 1:Num_Segments
                                  for I = UCO: UCO + 400*15
                                      ECG_Segments(I,J) = raw_ECG_data(I+(J-1)*400*15);
                                  end
                                  [qrs_pos] = pantompkins_qrs(ECG_Segments(:,J),fs, false);
                                   %Calculate heart rate
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
                            

                               
                                    new_filename = append(filename," Segment ");     
                                    new_filename = append(new_filename,num2str(J));

                                %creating quality struct
                                    ss = struct("File", new_filename,'Heart_rate', heart_rate, "Average_RR_interval", avg_rr_interval, "SDNN", sdnn,'RMSSD',rmssd,'NN50',nn50,'pNN50',pnn50);
                                    Bigtable(BT_iter) = ss;
                                    BT_iter = BT_iter + 1;
                            end 
                            
                         end 

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

writetable(struct2table(Bigtable), 'Data ECG Features (V4).xlsx')

       

%       