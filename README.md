# Advancing Fetal Surveillance with Physiological Sensing: Detecting Hypoxia in Fetal Sheep

The MATLAB files mainly focus on preprocessing EEG, ECG, and EMG data using methods such as bandpass filtering (MATLAB code only runs in Windows system). They convert adchit files into MATLAB files, and then use Python scripts to extract information from the MATLAB files into XLSX spreadsheet files for XGBoost training.

## Scripts and Notebooks

- **Merge_all_data**: This script merges EEG, ECG, and EMG features and related data for each sheep.
- **Experiment.ipynb**: This notebook includes all the experimental details.
- **Paper display.ipynb**: This notebook ensures that all figures are displayed with optimal visual quality for the paper.
- **UCO_Sample_Data.csv**: Record each Sheep sample, UCO start time, UCO end time, UCO duration, average UCO duration.

## Usage

To ensure the code runs smoothly, we have included some fake data for testing purposes.

1. **Download and Extract the GitHub Repository**:
   - Download the entire repository as a ZIP file.
   - If the names are too long and the extraction fails, shorten the names and try again.

2. **Install Python Packages**:
   - Python version: 3.11.7
   - Install all the required python packages by requirement.txt.

3. **Data Merging and Experimentation**:
   - Since we use Leave-One-Out Cross Validation, we created the "IEEE Sensor Xlsx Data" folder, which contains EEG, ECG, and EMG data for each sheep, including some fake data for testing.
   - Run `Merge_all_data.ipynb` to merge all EEG, ECG, and EMG XLSX data based on the `time` attribute, and save the merged data to the "Merge_data" folder. This will provide data for 14 fetal sheep.
   - Finally, run `Experiment.ipynb` to conduct the experiments. Remember to modify folder names as needed since "_fake" has been added to the data folder names.

For more detailed information, please refer to each script and notebook.


## Citation

If you use this code in your research, please cite it as follows:

### APA Reference

Weitao, T., Gari, C., Marzbanrad, . faezeh ., Nhi, T., Nasim, K., Reza, S., David, W., & Robert, G. (2024, February 9). Advancing Fetal Surveillance with Physiological Sensing Detecting Hypoxia in Fetal Sheep. Advancing Fetal Surveillance with Physiological Sensing: Detecting Hypoxia in Fetal Sheep, IEEE Sensor. https://doi.org/10.5281/zenodo.13668416


### BibTeX

```bibtex
@inproceedings{tang2024advancing,
  title={Advancing Fetal Surveillance with Physiological Sensing: Detecting Hypoxia in Fetal Sheep},
  author={Tang, Weitao and Gari, C. and Marzbanrad, Faezeh and Nhi, T. and Nasim, K. and Reza, S. and David, W. and Robert, G.},
  booktitle={IEEE Sensor Conference},
  year={2024},
  month={February 9},
  doi={10.5281/zenodo.13668416},
  url={https://doi.org/10.5281/zenodo.13668416}
}
