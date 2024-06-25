function qrs_indices = qrs_detect(ecg_signal, fs)
%QRS_DETECT Detect QRS complex locations in an ECG signal using Hamilton algorithm
%   Inputs:
%       - ecg_signal: ECG signal vector
%       - fs: Sampling frequency of the ECG signal
%   Output:
%       - qrs_indices: Indices of detected QRS complex locations in the ECG signal

% Filter the ECG signal
f_low = 0.05; % Low-pass filter cutoff frequency (in Hz)
f_high = 15; % High-pass filter cutoff frequency (in Hz)
order = 4; % Filter order
[b, a] = butter(order, [f_low, f_high] / (fs/2), 'bandpass'); % Design a bandpass filter
filtered_ecg = filtfilt(b, a, ecg_signal); % Apply the bandpass filter

% Differentiate the filtered ECG signal
diff_ecg = diff(filtered_ecg);

% Square the differentiated ECG signal
squared_ecg = diff_ecg.^2;

% Integrate the squared ECG signal
integration_window = round(0.15 * fs); % Integration window length (150 ms)
integrated_ecg = cumsum(squared_ecg);
integrated_ecg(1:integration_window) = 0;
integrated_ecg = integrated_ecg - [0; integrated_ecg(1:end-1)];

% Find the QRS complex location
threshold1 = 0.25 * max(integrated_ecg); % First threshold for QRS complex detection
threshold2 = 0.5 * max(integrated_ecg); % Second threshold for QRS complex detection
qrs_indices = [];
for i = 2:length(integrated_ecg)-1
    if integrated_ecg(i) > threshold1 && integrated_ecg(i) > integrated_ecg(i-1) && integrated_ecg(i) > integrated_ecg(i+1)
        if integrated_ecg(i) > threshold2
            qrs_indices = [qrs_indices; i];
        else
            % Refine QRS complex location using slope information
            [~,max_slope_idx] = max(diff_ecg(i-1:i+1)); % Find index with maximum slope
            qrs_indices = [qrs_indices; i + max_slope_idx - 2];
        end
    end
end

end
