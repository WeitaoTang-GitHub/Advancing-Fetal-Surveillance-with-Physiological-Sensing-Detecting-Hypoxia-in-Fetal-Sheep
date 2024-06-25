function [duration, peaknum, gamma1, gamma2, pph] = EEGProcess(clean_EEG)
%EEGPROCESS Processing of cleaned EEG signal and detection of HIPeaks
%   Takes in the clean_EEG 1 by n array and proceeds to process the signal. 
%   It then passes the signal to MarkHIPeaks2.
%   Outputs the duration of the signal, the number of peaks, the number of 
%   peaks per half hour, and the 2 threshold values used in peak detection. 
%   See MarkHIPeaks2 for peaks detection.
%Written by Charles Byron, 20/02/2023

close all

%% Cleaning and plotting clean data
EEG1 = clean_EEG;

%sample rate and downsample amount, must be input manually
fs = 400;

%% Labelling HI speaks

%noting duration
duration = length(EEG1);
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
halfhour_samples = fs*60*30;

%by inspection identification of UCO point or using real time
figure(2)
plot(EEG1)

UCO = input("\nWhat is the index of the UCO by inspection: ");

%setting N for envelope size and array indexing
env_EEG = EEG1(UCO:end);
N = length(EEG1);
env_size = round(N/2000);

%creating high envelope for thresholding
[hi, lo] = envelope(env_EEG, env_size, 'peak');

%% Processing to make secondary signal

%Normalisation and zero mean
norm_EEG1 = normalize(EEG1);

%fast fourier transformation
fft_EEG1 = fft(norm_EEG1);

%80-120Hz bandpass
N = length(fft_EEG1);
a = zeros(1,length(1:(floor(N/fs)*80-1)));
b = fft_EEG1((floor(N/fs)*80):(floor(N/fs)*120));
c = zeros(1,length((floor(N/fs)*120+1):(floor(N/fs)*(fs-120)-1)));
d = fft_EEG1((floor(N/fs)*(fs-120)):(floor(N/fs)*(fs-80)));
e = zeros(1,length((floor(N/fs)*(fs-80)+1):N));

fft_EEG1 = [a, b, c, d, e];

%inverse fft
filtered_EEG1 = ifft(fft_EEG1, 'symmetric');

%creating high envelope for thresholding
[hi2, lo2] = envelope(filtered_EEG1(UCO:(UCO+12*halfhour_samples)), env_size, 'peak');

%Plotting transformed signal
figure(303)
hold on
title('Filtered EEG after FFT Filtering and IFFT')
xlabel("Samples at" + fs + " samples/second")
ylabel("Amplitude (uV)")
%xlim([10277000, 10278200])
plot(filtered_EEG1)
hold off

%Making thresholds, this may need tweaking depending on collection method
%I have tweaked these in various ways, the current prevailing method is to
%select these thresholds based on observations of the signal amplitudes.
%See accompanying documentation
alpha = 2;%mean(hi2)-1*std(hi2);
gamma1 = 4.8;%mean(hi)+1*std(hi);
gamma2 = abs(alpha);

%% Peak Identification

%setup of some variable for use in the loop below
halfhour_samples = fs*60*30;
pph = zeros(1, floor(hours/0.5));
peak_hold = [];

for i = 1:(hours*2)
    if UCO>((i)*halfhour_samples+1)||(UCO+12*halfhour_samples)<((i)*halfhour_samples+1)
        peak_index = [];

        pph(i) = 0;
        peak_hold = [peak_hold, peak_index+(i-1)*halfhour_samples];
    else
        %processing each half hour
        [peak_index, peaknum] = MarkHIPeaks2(EEG1(((i-1)*halfhour_samples+1):(i*halfhour_samples)), filtered_EEG1(((i-1)*halfhour_samples+1):(i*halfhour_samples)), gamma1, gamma2);

        %collecting running data
        pph(i) = peaknum;
        peak_hold = [peak_hold, peak_index+(i-1)*halfhour_samples];
    end
end

%plot of clean labelled data with peaks
figure(100)
hold on
%xlim([1, 30*fs])
title('Full Clean EEG Signal with Peaks Marked')
xlabel("Samples at " + fs + " samples/second")
ylabel('Amplitude (uV)')
plot(EEG1)
plot(peak_hold, EEG1(peak_hold), 'o', 'MarkerEdgeColor','red')
hold off

end
    
