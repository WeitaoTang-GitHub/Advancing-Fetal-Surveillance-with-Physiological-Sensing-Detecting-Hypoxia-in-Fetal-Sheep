![alt text](https://zenodo.org/badge/DOI/10.5281/zenodo.13668416.svg)

# Advancing Fetal Surveillance with Physiological Sensing: Detecting Hypoxia in Fetal Sheep

The MATLAB files mainly focus on preprocessing EEG, ECG, and EMG data using methods such as bandpass filtering. They convert adchit files into MATLAB files, and then use Python scripts to extract information from the MATLAB files into XLSX spreadsheet files for XGBoost training.

The extraction code for EEG, ECG, and EMG has not been provided.

For EEG feature extraction, please refer to the EEG Lab: [https://sccn.ucsd.edu/eeglab/index.php](https://sccn.ucsd.edu/eeglab/index.php).

For ECG feature extraction, please refer to my supervisor Gari Clifford’s PhysioNet Cardiovascular Signal Toolbox: [https://github.com/cliffordlab/PhysioNet-Cardiovascular-Signal-Toolbox](https://github.com/cliffordlab/PhysioNet-Cardiovascular-Signal-Toolbox).

We used a 200-second time window for EEG, ECG, and EMG feature extraction, with a 15-second sliding window. We extracted the first two windows of real data from the Baseline, UCO segment, and Post-UCO periods for each fetal sheep as "Fake data" to allow our code to run without providing the actual data.

As we have optimized the parameters for the fetal sheep data, we will provide a detailed explanation of our parameter selection in the upcoming journal version.

## Scripts and Notebooks

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

3. **Experimentation**:
   - Run `Experiment.ipynb` to conduct the experiments. 
   - Run `Paper display.ipynb` to display the result of our paper, it may different because of the fake data.

For more detailed information, please refer to each script and notebook.


## Citation

If you use this code in your research, please cite it as follows:

### APA Reference

Weitao, T., Gari, C., Marzbanrad, . faezeh ., Nhi, T., Nasim, K., Reza, S., David, W., & Robert, G. (2024, February 9). Advancing Fetal Surveillance with Physiological Sensing Detecting Hypoxia in Fetal Sheep. Advancing Fetal Surveillance with Physiological Sensing: Detecting Hypoxia in Fetal Sheep, IEEE Sensor. https://doi.org/10.5281/zenodo.13668416


### BibTeX

Please make sure hyperref package in your LaTeX document by including this line in your preamble: \usepackage{hyperref}

```bibtex
@inproceedings{tang2024advancing,
  title={Advancing Fetal Surveillance with Physiological Sensing: Detecting Hypoxia in Fetal Sheep},
  author={Tang, Weitao and Gari, C. and Marzbanrad, Faezeh and Nhi, T. and Nasim, K. and Reza, S. and David, W. and Robert, G.},
  booktitle={IEEE Sensor Conference},
  year={2024},
  month={February 9},
  doi={10.5281/zenodo.13668416},
  note={Available at: \href{https://github.com/Weitao-chat/Advancing-Fetal-Surveillance-with-Physiological-Sensing-Detecting-Hypoxia-in-Fetal-Sheep}{GitHub repository}}
}
