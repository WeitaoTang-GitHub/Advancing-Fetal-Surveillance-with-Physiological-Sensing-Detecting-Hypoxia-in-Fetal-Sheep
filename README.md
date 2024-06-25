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
- **UCO_Sample_Data.csv**: Record each Sheep sample, UCO start time, UCO end time, UCO duration, average UCO duration.
- **UCO_time.txt**: Record each Sheep sample, the recording start time, UCO start time, end time.

### Specific files
Each MATLAB file contains approximately 12 hours of data. If the UCO surgery occurs earlier, it will be necessary to obtain the data from the previous 12 hours. Conversely, if the UCO surgery occurs later, data from the subsequent 12 hours will be required.
- **all_eeg_features_in_one_15_min_specific_several_file.ipynb**
- **all_ecg_features_in_one_15_min_specific_several_file.ipynb**
- **all_emg_features_in_one_15_min_specific_several_file.ipynb**

## Usage

1. Extract the provided RAR archive.
2. Follow the instructions in the notebooks and scripts to preprocess the data and prepare it for training.

For more detailed information, please refer to each script and notebook.

## Citation

If you use this code in your research, please cite it as follows:

### APA Reference

Weitao Tang. (2024). Weitao-chat/Advancing-Fetal-Surveillance-with-Physiological-Sensing-Detecting-Hypoxia-in-Fetal-Sheep: v1.0.0 (V1.0.0). Zenodo. https://doi.org/10.5281/zenodo.12524664

### Havard Reference

Weitao Tang (2024) 《Weitao-chat/Advancing-Fetal-Surveillance-with-Physiological-Sensing-Detecting-Hypoxia-in-Fetal-Sheep: v1.0.0》. Zenodo. doi: 10.5281/zenodo.12524664.

### MLA Reference

Weitao Tang. Weitao-chat/advancing-fetal-surveillance-with-physiological-sensing-detecting-hypoxia-in-fetal-sheep: V1.0.0. V1.0.0, Zenodo, 2024年6月25日, doi:10.5281/zenodo.12524664.

### Vancouver Reference

1. Weitao Tang. Weitao-chat/Advancing-Fetal-Surveillance-with-Physiological-Sensing-Detecting-Hypoxia-in-Fetal-Sheep: v1.0.0. Zenodo; 2024. 

### Chicago Reference

Weitao Tang. 《Weitao-chat/advancing-fetal-surveillance-with-physiological-sensing-detecting-hypoxia-in-fetal-sheep: V1.0.0》. Zenodo, 2024年6月25日. https://doi.org/10.5281/zenodo.12524664.

### IEEE Reference

[1]Weitao Tang, 《Weitao-chat/Advancing-Fetal-Surveillance-with-Physiological-Sensing-Detecting-Hypoxia-in-Fetal-Sheep: v1.0.0》. Zenodo, 6月 25, 2024. doi: 10.5281/zenodo.12524664.


### BibTeX

```bibtex
@software{weitao_chat_2024_12524664,
  author       = {Weitao Tang},
  title        = {{Weitao-chat/Advancing-Fetal-Surveillance-with- 
                   Physiological-Sensing-Detecting-Hypoxia-in-Fetal-
                   Sheep: v1.0.0}},
  month        = jun,
  year         = 2024,
  publisher    = {Zenodo},
  version      = {V1.0.0},
  doi          = {10.5281/zenodo.12524664},
  url          = {https://doi.org/10.5281/zenodo.12524664}
}
