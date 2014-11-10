# Getting and Cleaning Data Project

This repo contains project code for `Getting and Cleaning Data` module at Courera
by John Hopkins university.

## Script

The script contains a function `data.cleaner()` which performs the following job:

 * Install relavant libraries (if does not exist)
 * Downloads zip data file (if not present in the working directory)
 * Unzip data file (if has not been unziped already)
 * reads train and test datasets and merges them
 * processes the merged dataset (extract the relevant variables,
   adds descriptive activity names, etc.)
 * writes the merged dataset to `rawdata.csv`
 * generates the tidy dataset
 * writes the tidy dataset to `tidydata.csv` and `tidydata.txt`
 
*Note*: Please make sure `run_analysis.R` resides in the current working directory.
