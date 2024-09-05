### EEG (Electroencephalography) Features

**Frequency Domain Features:**
1. **Absolute Power of Delta (0-3.9 Hz)**: (μV²) Measures the total power within the Delta frequency band. Delta waves are associated with deep sleep and brain injuries.
2. **Relative Power of Delta (0-3.9 Hz)**: (%) The ratio of Delta power to the total power across all frequency bands.
3. **Absolute Power of Theta (4-7.9 Hz)**: (μV²) Measures the total power within the Theta frequency band. Theta waves are linked to drowsiness, meditation, and creativity.
4. **Relative Power of Theta (4-7.9 Hz)**: (%) The ratio of Theta power to the total power across all frequency bands.
5. **Absolute Power of Alpha (8-12.9 Hz)**: (μV²) Measures the total power within the Alpha frequency band. Alpha waves are related to relaxation and calmness.
6. **Relative Power of Alpha (8-12.9 Hz)**: (%) The ratio of Alpha power to the total power across all frequency bands.
7. **Absolute Power of Beta (13-22 Hz)**: (μV²) Measures the total power within the Beta frequency band. Beta waves are associated with active thinking and concentration.
8. **Relative Power of Beta (13-22 Hz)**: (%) The ratio of Beta power to the total power across all frequency bands.

**Time Domain Features:**
1. **Petrosian Fractal Dimension (PFD)**: (dimensionless) A measure of the complexity of the EEG signal, indicating the amount of self-similarity in the data.
2. **Detrended Fluctuation Analysis (DFA)**: (dimensionless) A method to detect long-range correlations in the EEG signal.
3. **Shannon Entropy**: (nats) A measure of the randomness or unpredictability in the EEG signal.
4. **Multiscale Entropy**: (dimensionless) Analyzes the complexity of the EEG signal across multiple time scales.

### EMG (Electromyography) Features

**Frequency Domain Features:**
1. **Absolute Power of Low Frequencies (20-60 Hz)**: (μV²) Measures the total power within the low-frequency range of the EMG signal.
2. **Relative Power of Low Frequencies (20-60 Hz)**: (%) The ratio of low-frequency power to the total power across all frequency bands.
3. **Absolute Power of Medium Frequencies (60-250 Hz)**: (μV²) Measures the total power within the medium-frequency range of the EMG signal.
4. **Relative Power of Medium Frequencies (60-250 Hz)**: (%) The ratio of medium-frequency power to the total power across all frequency bands.
5. **Absolute Power of High Frequencies (250-500 Hz)**: (μV²) Measures the total power within the high-frequency range of the EMG signal.
6. **Relative Power of High Frequencies (250-500 Hz)**: (%) The ratio of high-frequency power to the total power across all frequency bands.
7. **Dominant Frequency**: (Hz) The frequency at which the EMG signal has the highest power.

**Time Domain Features:**
1. **Mean Amplitude**: (μV) The average amplitude of the EMG signal over a given time period.
2. **Median Amplitude**: (μV) The middle value of the amplitudes when they are sorted in ascending order.
3. **Root Mean Square (RMS) Amplitude**: (μV) A measure of the signal's power, calculated as the square root of the mean of the squared amplitudes.
4. **Maximum Amplitude**: (μV) The highest amplitude value observed in the EMG signal.
5. **Duration**: (seconds) The length of time over which the EMG activity occurs.

### ECG (Electrocardiography) Features

**Time Domain Features:**
1. **NNmean**: (ms) Mean value of NN intervals.
2. **NNmode**: (ms) Mode of NN intervals.
3. **NNmedian**: (ms) Median value of NN intervals.
4. **NNskew**: (dimensionless) Skewness of NN intervals.
5. **NNkurt**: (dimensionless) Kurtosis of NN intervals.
6. **NNvariance**: (ms²) Variance of NN intervals, representing the degree of variability or dispersion of NN intervals from the mean.
7. **NNiqr**: (ms) Interquartile range of NN intervals.
8. **SDNN**: (ms) Standard deviation of all NN intervals.
9. **RMSSD**: (ms) The square root of the mean of the sum of the squares of differences between adjacent NN intervals.
10. **pnn1**: (%) NN1 count divided by the total number of all NN intervals (number of pairs of adjacent NN intervals differing by more than 1 ms).
11. **pnn2**: (%) NN2 count divided by the total number of all NN intervals (number of pairs of adjacent NN intervals differing by more than 2 ms).
12. **pnn3**: (%) NN3 count divided by the total number of all NN intervals (number of pairs of adjacent NN intervals differing by more than 3 ms).
13. **pnn4**: (%) NN4 count divided by the total number of all NN intervals (number of pairs of adjacent NN intervals differing by more than 4 ms).
14. **pnn5**: (%) NN5 count divided by the total number of all NN intervals (number of pairs of adjacent NN intervals differing by more than 5 ms).

**Frequency Domain Features (Default Using Lomb Periodogram):**
1. **ulf**: (ms²) Power in the ultra-low frequency range (default < 0.003 Hz).
2. **vlf**: (ms²) Power in the very low frequency range (default 0.003 ≤ vlf < 0.04 Hz).
3. **lf**: (ms²) Power in the low-frequency range (default 0.04 ≤ lf < 0.15 Hz).
4. **hf**: (ms²) Power in the high-frequency range (default 0.15 ≤ hf < 0.4 Hz).
5. **lfhf**: (dimensionless) Ratio of LF [ms²] to HF [ms²].
6. **ttlpwr**: (ms²) Total spectral power (approximately < 0.4 Hz).

**Other HRV Features:**
1. **PRSA - AC**: (ms) Acceleration capacity.
2. **PRSA - DC**: (ms) Deceleration capacity.

**Entropy Features:**
1. **SampEn**: (a.u.) Sample entropy, which measures the regularity and complexity of a time series.
2. **ApEn**: (a.u.) Approximate entropy, which measures the regularity and complexity of a time series.

**Quality Features:**
1. **avgsqi**: (%) The quality of this time window.