# Advancing Fetal Surveillance with Physiological Sensing: Detecting Hypoxia in Fetal Sheep

The MATLAB files mainly focus on preprocessing EEG, ECG, and EMG data using methods such as bandpass filtering. They convert adchit files into MATLAB files, and then use Python scripts to extract information from the MATLAB files into XLSX spreadsheet files for XGBoost training.

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

To ensure the code runs smoothly, we have included some fake data for testing purposes.

1. **Download and Extract the GitHub Repository**:
   - Download the entire repository as a ZIP file.
   - If the names are too long and the extraction fails, shorten the names and try again.

2. **MATLAB Setup**:
   - Open MATLAB and select "Browse for folder" to open the "Matlab code for preprocessing" folder within the project.
   - Add all `.m` files and the "Fake data" folder to the MATLAB path.

3. **MATLAB Toolbox Installation**:
   - Install the following toolbox via MATLAB's "Get More Apps":
     - ADInstruments (LabChart) SDK
   - This toolbox is necessary for reading the original `.aicht` data files.

4. **Install Python Packages**:
   - Python version: 3.11.7
   - Install all the required python packages by requirement.txt.

6. **Running MATLAB Scripts**:
   - Open the provided `21203` folder which includes sample files with noise data.
   - Run `Clean_Process.m` to preprocess EEG signals and generate EEG MATLAB data.
   - Run `Clean_Process_ECG.m` to preprocess ECG signals and generate ECG MATLAB data.
   - Run `Clean_Process_EMG.m` to preprocess EMG signals and generate EMG MATLAB data.

7. **Feature Extraction and Labeling**:
   - The processed MATLAB data will be stored in the "Fake data" folder.
   - Use `all_eeg_features_in_one_15_min.ipynb`, `all_ecg_features_in_one_15_min.ipynb`, and `all_emg_features_in_one_15_min.ipynb` to extract features and labels from the EEG, ECG, and EMG MATLAB data respectively and save them to XLSX files. Note that the last block for all three files requires real data to work.


8. **Data Merging and Experimentation**:
   - Since we use Leave-One-Out Cross Validation, we created the "IEEE Sensor Xlsx Data" folder, which contains EEG, ECG, and EMG data for each sheep, including some fake data for testing. Don't use the data and result folders you created before; they are only for code running and comprehension of the logic.
   - Run `Merge_all_data.ipynb` to merge all EEG, ECG, and EMG XLSX data based on the `time` attribute, and save the merged data to the "Merge_data" folder. This will provide data for 16 sheep.
   - Finally, run `Experiment.ipynb` to conduct the experiments. Remember to modify folder names as needed since "_fake" has been added to the data folder names.

For more detailed information, please refer to each script and notebook.


## Citation

If you use this code in your research, please cite it as follows:

### APA Reference

Weitao Tang. (2024). Weitao-chat/Advancing-Fetal-Surveillance-with-Physiological-Sensing-Detecting-Hypoxia-in-Fetal-Sheep: V1.0.1 (V1.0.1). Zenodo. https://doi.org/10.5281/zenodo.12540027

### Havard Reference

Weitao Tang (2024) 《Weitao-chat/Advancing-Fetal-Surveillance-with-Physiological-Sensing-Detecting-Hypoxia-in-Fetal-Sheep: V1.0.1》. Zenodo. doi: 10.5281/zenodo.12540027.

### MLA Reference

Weitao Tang. Weitao-chat/advancing-fetal-surveillance-with-physiological-sensing-detecting-hypoxia-in-fetal-sheep: V1.0.1. V1.0.1, Zenodo, 2024年6月26日, doi:10.5281/zenodo.12540027.

### Vancouver Reference

Weitao Tang. Weitao-chat/Advancing-Fetal-Surveillance-with-Physiological-Sensing-Detecting-Hypoxia-in-Fetal-Sheep: V1.0.1. Zenodo; 2024.

### Chicago Reference

Weitao Tang. 《Weitao-chat/advancing-fetal-surveillance-with-physiological-sensing-detecting-hypoxia-in-fetal-sheep: V1.0.1》. Zenodo, 2024年6月26日. https://doi.org/10.5281/zenodo.12540027.

### IEEE Reference

Weitao Tang, 《Weitao-chat/Advancing-Fetal-Surveillance-with-Physiological-Sensing-Detecting-Hypoxia-in-Fetal-Sheep: V1.0.1》. Zenodo, 6月 26, 2024. doi: 10.5281/zenodo.12540027.


### BibTeX

```bibtex
@software{weitao_chat_2024_12540027,
  author       = {Weitao Tang},
  title        = {Weitao-chat/Advancing-Fetal-Surveillance-with-Physiological-Sensing-Detecting-Hypoxia-in-Fetal-Sheep: v1.0.1},
  month        = jun,
  year         = 2024,
  publisher    = {Zenodo},
  version      = {v1.0.1},
  doi          = {10.5281/zenodo.12540027},
  url          = {https://doi.org/10.5281/zenodo.12540027},
  note         = {\url{https://doi.org/10.5281/zenodo.12540027}}
}
