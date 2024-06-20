# Data Processing and Preprocessing

The MATLAB files are provided in a RAR archive. You can extract and use these files as needed. The files mainly focus on preprocessing EEG, ECG, and EMG data using methods such as bandpass filtering. They convert adchit files into MATLAB files, and then use Python scripts to extract information from the MATLAB files into XLSX spreadsheet files for XGBoost training.

## Scripts and Notebooks

- **all_eeg_features_in_one_15_min.ipynb**: Extract the EEG features from Matlab files and label Baseline(60 number of 15 seconds segments 1 hour before UCO start time) as -1, UCO duration as 0, Post-UCO(60 number of 15 seconds segments after UCO end time) as 1.  
- **all_ecg_features_in_one_15_min.ipynb**: Extract the ECG features from Matlab files.
- **all_emg_features_in_one_15_min.ipynb**: Extract the EMG features from Matlab files.
- **Merge_all_data**: This script merges EEG, ECG, and EMG features and related data for each sheep.
- **change_15min_to_same_time.ipynb**: Initially, we set Baseline and Post-UCO to 15 minutes. To maintain class balance, we later adjusted Baseline and Post-UCO for each sheep to match the UCO duration.
- **Experiment.ipynb**: This notebook includes all the experimental details.
- **Paper display.ipynb**: This notebook ensures that all figures are displayed with optimal visual quality for the paper.

### Specific files
Each MATLAB file contains approximately 12 hours of data. If the UCO surgery occurs earlier, it will be necessary to obtain the data from the previous 12 hours. Conversely, if the UCO surgery occurs later, data from the subsequent 12 hours will be required.
- **all_eeg_features_in_one_15_min_specific_several_file.ipynb**
- **all_ecg_features_in_one_15_min_specific_several_file.ipynb**
- **all_emg_features_in_one_15_min_specific_several_file.ipynb**

## Usage

1. Extract the provided RAR archive.
2. Follow the instructions in the notebooks and scripts to preprocess the data and prepare it for training.

For more detailed information, please refer to each script and notebook.

