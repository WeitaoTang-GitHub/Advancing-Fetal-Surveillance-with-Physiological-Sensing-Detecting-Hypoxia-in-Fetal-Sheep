
close all
clc

%Reading all file names with format "Main Data\[Subject number]\[filename]"
%that are in adicht format

%% fds = fileDatastore('*.adicht', 'ReadFcn', @importdata); 
%%
fds = fileDatastore('Fake data\21203\*.adicht', 'ReadFcn', @importdata);
fullFileNames = fds.Files;
numFiles = length(fullFileNames);


%quality = load("Quality_logical.mat").ans;
ExcelSheet = readmatrix('New Data EMG Quality.xlsx');

quality = ExcelSheet(:,4);

%Variables for use if loop must be restarted
currentfile = 1;
quality_iter = 1;

%iterating from current file name through array of file names
for k = currentfile:numFiles
    %creating filename variable for saving and cmc printing
    %change erasing directory as needed
    filename = erase(fullFileNames{k}, ["D:\Cleaned_EMG\", ".adicht"]);
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
                EMG_chan = f.getChannelByName('nuchal EMG');
                raw_EMG_data = EMG_chan.getData(i)*10^3;
                fs = EMG_chan.fs(i);
                ds = EMG_chan.downsample_amount(i);
                
               %% MIGHT BE DIFFERENT FOR FETUS
               %% SEND BEFORE AND AFTER IN TIME & FREQUENCY DOMAIN
                        f_low = 20; % Low cutoff frequency in Hz
                        f_high = 500; % High cutoff frequency in Hz
                        
                        % Design the lowpass Butterworth filter
                        N_lowpass = 4; % Filter order for lowpass filter
                        Wn_lowpass = f_high / (fs/2); % Normalized cutoff frequency for lowpass filter
                        [b_lowpass, a_lowpass] = butter(N_lowpass, Wn_lowpass, 'low');
                        
                        % Design the highpass Butterworth filter
                        N_highpass = 4; % Filter order for highpass filter
                        Wn_highpass = f_low / (fs/2); % Normalized cutoff frequency for highpass filter
                        [b_highpass, a_highpass] = butter(N_highpass, Wn_highpass, 'high');
                        
                        % Load your EMG signal (assuming it's stored in a variable called 'emg_signal')
                        % Replace this with the actual code to load your EMG signal
                        
                        % Apply the lowpass filter to the EMG signal
                        filtered_emg_signal_lowpass = filtfilt(b_lowpass, a_lowpass, raw_EMG_data);
                        
                        % Apply the highpass filter to the lowpass-filtered EMG signal
                        filtered_emg_signal = filtfilt(b_highpass, a_highpass, filtered_emg_signal_lowpass);

                       % Plot the original and filtered EMG signals for comparison
                        t = (0:length(raw_EMG_data)-1) / fs; % Time vector
                        figure;
                        subplot(2,1,1);
                        plot(t, raw_EMG_data);
                        xlabel('Time (s)');
                        ylabel('EMG Signal');
                        title('Original EMG Signal');
                        subplot(2,1,2);
                        plot(t, filtered_emg_signal);
                        xlabel('Time (s)');
                        ylabel('Filtered EMG Signal');
                        title('Filtered EMG Signal');
            
                %saving data for later use
                save_data = filtered_emg_signal;
                savefile = append(erase(filename, "Main Data"), " Channel "+i+"_EMG",".mat");
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















