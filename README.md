# Getting and Cleaning Data Project

This repo contains project code for `Getting and Cleaning Data` module at Courera
by John Hopkins university.

## Script

The script contains a function `data.cleaner()` which performs the following job:

 * Install relavant libraries (if does not exist)
 * Downloads zip data file (if not present in the working directory)
 * Unzip data file (if has not been unziped already)
 * reads train and test data sets and merges them
 * processes the merged data set (extract the relevant variables,
   adds descriptive activity names, etc.)
 * writes the merged data set to `rawdata.csv`
 * generates the tidy data set
 * writes the tidy data set to `tidydata.csv`
 
*Note*: Please make sure `run_analysis.R` resides in the current working directory.

