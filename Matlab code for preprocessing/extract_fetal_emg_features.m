function features = extract_fetal_emg_features(emg_signal, fs,new_filename)
% EXTRACT_FETAL_EMG_FEATURES Extracts key features from fetal EMG signals
% Inputs:
%   - emg_signal: A vector representing the fetal EMG signal
%   - fs: Sampling frequency of the EMG signal (in Hz)
% Outputs:
%   - features: A struct containing the extracted features

% Rectify the EMG signal
rectified_emg = abs(emg_signal);

% Extract amplitude features
features.filename = new_filename;
features.amplitude_mean = mean(rectified_emg);
features.amplitude_median = median(rectified_emg);
features.amplitude_rms = rms(rectified_emg);
features.amplitude_std = std(rectified_emg);
features.amplitude_max = max(rectified_emg);


window_len = 64;
overlap =round(0.75*window_len);
%Low (<60Hz), Mid (60-250Hz), and gamma (250-600Hz Hz)

% Estimate the PSD using Welch's method
[psd, freqs] = pwelch(rectified_emg, window_len,overlap , [], fs);

plot(psd,freqs)
low = 0.25;
high =  60;
idx_lowFreq= freqs >= low & freqs <= high;

freq_res = freqs(2) - freqs(1);  % = 1 / 4 = 0.25

lowFreq_power = trapz(freqs(idx_lowFreq),psd(idx_lowFreq)) * freq_res;
total_power = trapz(freqs,psd) * freq_res;
low_rel_power = lowFreq_power / total_power;


low = 60;
high =  250;
idx_midFreq = freqs >= low & freqs <= high;

freq_res = freqs(2) - freqs(1);  % = 1 / 4 = 0.25

mid_power = trapz(freqs(idx_midFreq),psd(idx_midFreq)) * freq_res;

mid_rel_power = mid_power / total_power;


low = 250;
high = 600;
idx_highFreq = freqs >= low & freqs <= high;

freq_res = freqs(2) - freqs(1);  % = 1 / 4 = 0.25

high_power = trapz(freqs(idx_highFreq),psd(idx_highFreq)) * freq_res;

high_rel_power = high_power / total_power;
%

%
%
features.low_power = lowFreq_power;
features.med_power = mid_power;
features.high_power = high_power;

features.low_rel_power = low_rel_power;
features.mid_rel_power = mid_rel_power;
features.high_rel_power = high_rel_power;






% Extract frequency features
frequencies = abs(fft(emg_signal));
nyquist = 0.5 * fs;
frequency_range = linspace(0, nyquist, length(emg_signal)/2+1);
[~, dominant_frequency_index] = max(frequencies(1:length(emg_signal)/2+1));
features.dominant_frequency = frequency_range(dominant_frequency_index);



% % Set parameters for sample entropy algorithm
% m = 2; % embedding dimension
% r = 0.2 * std(emg_signal); % tolerance value, set to 20% of signal standard deviation
% 
% % Calculate sample entropy
% N = length(emg_signal);
% sampen = zeros(1, N - m + 1);
% for i = 1:N-m+1
%     for j = i+1:N-m+1
%         if max(abs(emg_signal(i:i+m-1) - emg_signal(j:j+m-1))) <= r
%             sampen(m) = sampen(m) + 1;
%         end
%     end
% end
% sampen = sampen / (N - m + 1);
% 
% % Calculate entropy as the negative logarithm of sample entropy
% features.entropy = -log(sampen);


% Extract timing features
threshold = 0.1 * max(rectified_emg); % Example threshold for onset/offset detection
[onset_times, offset_times] = find_emg_onset_offset(rectified_emg, threshold, fs);
%features.onset_times = onset_times;
%features.offset_times = offset_times;
features.duration = median(offset_times - onset_times) / fs; % Median duration of muscle activation

end

function [onset_times, offset_times] = find_emg_onset_offset(emg_signal, threshold, fs)
% FIND_EMG_ONSET_OFFSET Detects onset and offset times of EMG activity
% Inputs:
%   - emg_signal: A vector representing the rectified EMG signal
%   - threshold: Threshold for detecting onset/offset (scalar)
%   - fs: Sampling frequency of the EMG signal (in Hz)
% Outputs:
%   - onset_times: Onset times of EMG activity (in samples)
%   - offset_times: Offset times of EMG activity (in samples)

% Find onset times
above_threshold = emg_signal > threshold;
diff_above_threshold = diff(above_threshold);
onset_times = find(diff_above_threshold > 0) + 1;

% Find offset times
offset_times = find(diff_above_threshold < 0) + 1;

% Remove offset times before the first onset time
offset_times(offset_times < onset_times(1)) = [];

% If there are more onset times than offset times, remove the last onset time
if length(onset_times) > length(offset_times)
    onset_times(end) = [];
end

% Convert onset and offset times from samples to seconds
onset_times = onset_times / fs;
offset_times = offset_times / fs;

end
