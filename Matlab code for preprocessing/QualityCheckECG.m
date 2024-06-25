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

        %loading ECG
        ECG_chan = f.getChannelByName('ECG');

        %% is this required for ECG *10^3
       
        raw_ECG_data = ECG_chan.getData(i)*10^3;  
        fs = ECG_chan.fs(i);

        figure(fig_iter)
        hold on
        plot(raw_ECG_data)
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
         
            
                %saving data for later use
                save_data = conv1;
                savefile = append("Clean Data", erase(filename, "Main Data"), " Channel "+i,".mat");
                save(savefile, 'save_data')


        %creating quality struct
        s = struct("File", filename, "Channel", i, "Quality", quality, "NumericalQuality", NumericalQuality);
        Bigtable(BT_iter) = s;
        BT_iter = BT_iter + 1;
    end
end

%saving quality table to excel for referral and later use, alter date
writetable(struct2table(Bigtable), 'Data ECG Quality.xlsx')









%%

%                 N = length(raw_ECG_data);
%                 X = (1/N)*fft(raw_ECG_data);
%                 kX = -floor(N/2):(N-1-floor(N/2));
%                 figure(fig_iter +1); stem(kX, fftshift(abs(X)));
%                 xlabel("k (multiple of fundemental frequency)")
%                 ylabel('Magnitude')
%                 title('Magnitude of Discrete Time Fourier Coefficients')
% 
% 
%                 fig_iter = fig_iter + 1;
            
%             f=[0 0.42 0.50 1]; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             a=[1 1 0 0];
%             b=firpm(19,f,a);
%             conv1=conv(raw_ECG_data,b);
%                

%                 N= length(conv1)
%                 Fs = 256; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                 C1 = fft(conv1);
%                 Comega = (-floor(N/2):(N-1-floor(N/2)))*(Fs/N);
%                 figure(fig_iter + 1)
%            
%                 plot(Comega, fftshift(abs(C1)),'k','LineWidth',0.8);
%                 hold on
%                 xlabel("Frequency in(Hz)")
%                 ylabel('Magnitude')
%                 title('Magnitude of DTFC Order 4 f1=[0 0.32 0.46 1];')
%                 plot(omega2, fftshift(abs(X2)),'r:');
%                 legend('After Filter','Before Filter')