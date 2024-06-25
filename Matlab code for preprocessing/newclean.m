function clean_EEG = newclean(EEG,fs)
%NEWCLEAN Cleaning of EEG samples for detection of HIPeaks
%   takes in the 1 by n array EEG and the samples rate fs and performs
%   various filtering processes in preparation for HIpeaks detection.
%Written by Charles Byron, 20/02/2023

%only for use if fs exceeds 512Hz
%6th order lowpass butterworth with cutoff 512Hz
% fc = 512;
% filter1 = butter(6, fc/(fs/2), 'low');
% %freqz(filter1)
% step1 = conv(EEG, filter1, 'same');
% %plot for checking
% figure(200)
% hold on
% %xlim(poi) %point of interest
% xlabel("Samples at" + fs + "samples/second")
% ylabel("Amplitude")
% title("First step Clean EEG Data")
% plot(step1);
% hold off
step1 = EEG;

%1st order highpass butterworth with cutoff 1.6Hz
fc = 1.6;
filter2 = butter(1, fc/(fs/2), 'high');
% f = [0, fc/fs, fc/(fs/2), 1];
% m = [0, 0, 1, 1];
% filter2 = fir2(1, f, m);
%freqz(d)
step2 = conv(step1, filter2, 'same');

% %plot for checking
% figure(201)
% hold on
% %xlim(poi) %point of interest
% xlabel("Samples at " + fs + " samples/second")
% ylabel("Amplitude")
% title("Second step Clean EEG Data")
% plot(step2);
% hold off

%0 mean of signal
step3 = step2-mean(step2);
% %plot for checking
% figure(202)
% hold on
% %xlim(poi) %point of interest
% xlabel("Samples at " + fs + " samples/second")
% ylabel("Amplitude")
% title("Third step Clean EEG Data")
% plot(step3);
% hold off

%100th order fir bandstop with cutoffs 25.6Hz and 66.56Hz
fc = [25.6, 66.56];
f = [0, fc(1)/(fs/2)-0.01, fc(1)/(fs/2), fc(2)/(fs/2), fc(2)/(fs/2)+0.01, 1]; 
m = [1, 1, 0, 0, 1, 1];
filter3 = fir2(100,f,m);

% %plot to check filter
% figure(205)
% freqz(filter3)
 clean_EEG = conv(step3, filter3, 'same');
% 
% %plot for checking
% figure(203)
% hold on
% %xlim(poi) %point of interest
% xlabel("Samples at " + fs + " samples/second")
% ylabel("Amplitude")
% title("Fourth step Clean EEG Data")
% plot(clean_EEG);
% hold off
end

