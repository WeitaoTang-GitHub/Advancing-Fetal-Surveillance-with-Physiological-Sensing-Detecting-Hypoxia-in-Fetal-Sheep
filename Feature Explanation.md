Here are the features listed by their respective types (EEG, EMG, ECG) along with explanations for each:

### EEG (Electroencephalography) Features

**Frequency Domain Features:**
1. **Absolute Power of Delta (0-3.9 Hz):** Measures the total power within the Delta frequency band. Delta waves are associated with deep sleep and brain injuries.
2. **Relative Power of Delta (0-3.9 Hz):** The ratio of Delta power to the total power across all frequency bands.
3. **Absolute Power of Theta (4-7.9 Hz):** Measures the total power within the Theta frequency band. Theta waves are linked to drowsiness, meditation, and creativity.
4. **Relative Power of Theta (4-7.9 Hz):** The ratio of Theta power to the total power across all frequency bands.
5. **Absolute Power of Alpha (8-12.9 Hz):** Measures the total power within the Alpha frequency band. Alpha waves are related to relaxation and calmness.
6. **Relative Power of Alpha (8-12.9 Hz):** The ratio of Alpha power to the total power across all frequency bands.
7. **Absolute Power of Beta (13-22 Hz):** Measures the total power within the Beta frequency band. Beta waves are associated with active thinking and concentration.
8. **Relative Power of Beta (13-22 Hz):** The ratio of Beta power to the total power across all frequency bands.

**Time Domain Features:**
1. **Petrosian Fractal Dimension (PFD):** A measure of the complexity of the EEG signal, indicating the amount of self-similarity in the data.
2. **Detrended Fluctuation Analysis (DFA):** A method to detect long-range correlations in the EEG signal.
3. **Shannon Entropy:** A measure of the randomness or unpredictability in the EEG signal.
4. **Multiscale Entropy:** Analyzes the complexity of the EEG signal across multiple time scales.

### EMG (Electromyography) Features

**Frequency Domain Features:**
  1. **Absolute Power of Low Frequencies (20-60 Hz):** Measures the total power within the low-frequency range of the EMG signal.
2. **Relative Power of Low Frequencies (20-60 Hz):** The ratio of low-frequency power to the total power across all frequency bands.
3. **Absolute Power of Medium Frequencies (60-250 Hz):** Measures the total power within the medium-frequency range of the EMG signal.
4. **Relative Power of Medium Frequencies (60-250 Hz):** The ratio of medium-frequency power to the total power across all frequency bands.
5. **Absolute Power of High Frequencies (250-500 Hz):** Measures the total power within the high-frequency range of the EMG signal.
6. **Relative Power of High Frequencies (250-500 Hz):** The ratio of high-frequency power to the total power across all frequency bands.
7. **Dominant Frequency:** The frequency at which the EMG signal has the highest power.

**Time Domain Features:**
1. **Mean Amplitude:** The average amplitude of the EMG signal over a given time period.
2. **Median Amplitude:** The middle value of the amplitudes when they are sorted in ascending order.
3. **Root Mean Square (RMS) Amplitude:** A measure of the signal's power, calculated as the square root of the mean of the squared amplitudes.
4. **Maximum Amplitude:** The highest amplitude value observed in the EMG signal.
5. **Duration:** The length of time over which the EMG activity occurs.

### ECG (Electrocardiography) Features

**Time Domain Features:**
1. **Standard Deviation of Normal-to-Normal (NN) Beat Intervals (SDNN):** A measure of the variability in the intervals between consecutive heartbeats.
2. **Root Mean Square of Successive Differences (RMSSD):** A measure of the short-term variability in heart rate.
3. **Mean of Normal-to-Normal Intervals (Mean NN):** The average time interval between consecutive heartbeats.
4. **Mean Heart Rate (Mean HR):** The average heart rate over a given time period.
5. **Standard Deviation of Heart Rate (SDHR):** A measure of the variability in heart rate.
6. **Minimum Heart Rate (Min HR):** The lowest heart rate observed during a given time period.
7. **Maximum Heart Rate (Max HR):** The highest heart rate observed during a given time period.
