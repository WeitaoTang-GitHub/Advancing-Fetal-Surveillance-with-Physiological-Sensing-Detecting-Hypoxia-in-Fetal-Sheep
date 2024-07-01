
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
ExcelSheet = readmatrix('New Data ECG Quality.xlsx');

quality = ExcelSheet(:,4);

%Variables for use if loop must be restarted
currentfile = 1;
quality_iter = 1;

%iterating from current file name through array of file names
for k = currentfile:numFiles
    %creating filename variable for saving and cmc printing
    %change erasing directory as needed
    filename = erase(fullFileNames{k}, ["D:\Cleaned_ECG\", ".adicht"]);
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
                raw_ECG_data = ECG_chan.getData(i)*10^3;
                fs = ECG_chan.fs(i);
                ds = ECG_chan.downsample_amount(i);
                
         
         %% send photo of 10 seconds to see how clean it is (time domain)
         
         
                f_low = 0.1; % Low cutoff frequency in Hz was at 0.5
                f_high = 50; % High cutoff frequency in Hz
                
                % Design the lowpass Butterworth filter
                N_lowpass = 4; % Filter order for lowpass filter
                Wn_lowpass = f_high / (fs/2); % Normalized cutoff frequency for lowpass filter
                [b_lowpass, a_lowpass] = butter(N_lowpass, Wn_lowpass, 'low');
                
                % Design the highpass Butterworth filter
                N_highpass = 4; % Filter order for highpass filter
                Wn_highpass = f_low / (fs/2); % Normalized cutoff frequency for highpass filter
                [b_highpass, a_highpass] = butter(N_highpass, Wn_highpass, 'high');

                % Apply the lowpass filter to the ECG signal
                filtered_ecg_signal_lowpass = filtfilt(b_lowpass, a_lowpass, raw_ECG_data);

                % Apply the highpass filter to the lowpass-filtered ECG signal
                filtered_ecg_signal = filtfilt(b_highpass, a_highpass, filtered_ecg_signal_lowpass);

                % Plot the original and filtered ECG signals for comparison
                t = (0:length(raw_ECG_data)-1) / fs; % Time vector
                figure;
                subplot(2,1,1);
                plot(t, raw_ECG_data, 'b');
                xlabel('Time (s)');
                ylabel('ECG Signal');
                title('Original ECG Signal');
                subplot(2,1,2);
                plot(t, filtered_ecg_signal, 'k');
                xlabel('Time (s)');
                ylabel('Filtered ECG Signal');
                title('Filtered ECG Signal');
            

                % Plotting Frequency Domain
%                 N= length(filtered_ecg_signal);
%                 Fs = 256; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                 C1 = fft(filtered_ecg_signal);
%                 Comega = (-floor(N/2):(N-1-floor(N/2)))*(Fs/N);
%                 plot(Comega, fftshift(abs(C1)),'k','LineWidth',0.8);
%                 hold on
%                 xlabel("Frequency in(Hz)")
%                 ylabel('Magnitude')
%                 title('Filtered Frequency Domain')
                




%                 saving data for later use
                save_data = filtered_ecg_signal;
                savefile = append(erase(filename, "Main Data"), " Channel "+i+"_ECG",".mat");
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



%    % Cleaning
%         % getting rid of high frequency
%         f=[0 0.35 0.45 1];
%         a=[1 1 0 0];
%         b=firpm(19,f,a);
%         conv1=conv(raw_ECG_data,b);
% 
%  
%         % getting rid of low frequency
%         f=[0 0.0040 0.008 1];
%         a=[0 0 1 1];
%         b1=firpm(499,f,a);
%         conv2=conv(conv1,b1);
%        
% 
%         % Plotting Frequency Domain
%         N= length(conv2);
%         Fs = 256; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         C1 = fft(conv2);
%         Comega = (-floor(N/2):(N-1-floor(N/2)))*(Fs/N);
%         figure(fig_iter + 1)
%    
%         plot(Comega, fftshift(abs(C1)),'k','LineWidth',0.8);
%         hold on
%         xlabel("Frequency in(Hz)")
%         ylabel('Magnitude')
%         title('Filtered Frequency Domain')
%         fig_iter = fig_iter + 1;
% 
%                
%         figure(fig_iter + 1)  
%        
%         plot((conv2),'b')
%         hold on
%         plot(raw_ECG_data,'k')
%         xlabel("Time in Samples")
%         ylabel('ECG vs Convolution Length 50')
%         title('ECG and Convolution Length 50 Over Time')
%         xlim([10000,10500])
        


