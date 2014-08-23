#### Getting anc Cleaing Data Peer Assignment ####

# Clear the existing objects
rm(list=ls())

# Downloading data for the project

if (!require("base")) { install.packages("base") }
if (!require("utils")) { install.packages("utils") }
if (!require("data.table")) { install.packages("data.table") }
if (!require("downloader")) { install.packages("downloader") }

require("base")
require("utils")
require("data.table")
require("downloader")


fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

if(!file.exists("getdata-projectfiles-UCI-HAR-Dataset.zip")) {
      print("Downloading Data")
      download(fileUrl, destfile="getdata-projectfiles-UCI-HAR-Dataset.zip", mode="wb") }

if(!file.exists("UCI HAR Dataset")) {
      print("Extracting Data")
      unzip("getdata-projectfiles-UCI-HAR-Dataset.zip")
}

if(!file.exists(result_folder)){
      print("Creating result folder")
      dir.create(result_folder)
} 

# The function loads and processes a dataset from train or test datasets

load.dataset <- function (set, features, labels) {
      # Construct the relative pathes of data files
      prefix <- paste(set, '/', sep = '')
      file.data <- paste(prefix, 'X_', set, '.txt', sep = '')
      file.label <- paste(prefix, 'y_', set, '.txt', sep = '')
      file.subject <- paste(prefix, 'subject_', set, '.txt', sep = '')
      
      data <- read.table(file.data)[, features$index]
      names(data) <- features$name
      
      label.set <- read.table(file.label)[, 1]
      data$label <- factor(label.set, levels=labels$level, labels=labels$label)
      
      subject.set <- read.table(file.subject)[, 1]
      data$subject <- factor(subject.set)
      
      data.table(data)
}

data.cleaner <- function () {
      setwd('UCI HAR Dataset/')
      
      # Get the features
      feature.set <- read.table('features.txt', col.names = c('index', 'name'))
      features <- subset(feature.set, grepl('-(mean|std)[(]', feature.set$name))
      
      # Get the labels
      label.set <- read.table('activity_labels.txt', col.names = c('level', 'label'))
      
      # Read train and test data sets
      print("Loading train dataset")
      train.set <- load.dataset('train', features, label.set)
      
      print("Loading test dataset")
      test.set <- load.dataset('test', features, label.set)
      
      # The raw data set
      dataset <- rbind(train.set, test.set)
      
      # Generate the tidy data set
      print("Generating tidy dataset")
      tidy.dataset <- dataset[, lapply(.SD, mean), by=list(label, subject)]
      
      # Fix the variable names
      names <- names(tidy.dataset)
      names <- gsub('-mean', 'Mean', names) # Replace `-mean' by `Mean'
      names <- gsub('-std', 'Std', names) # Replace `-std' by 'Std'
      names <- gsub('[()-]', '', names) # Remove the parenthesis and dashes
      names <- gsub('BodyBody', 'Body', names) # Replace `BodyBody' by `Body'
      setnames(tidy.dataset, names)
      
      # Write the raw and the tidy data sets to files
      setwd('..')
      write.csv(dataset, file = 'rawdata.csv', row.names = FALSE)
      write.csv(tidy.dataset, file = 'tidydata.csv',
                row.names = FALSE, quote = FALSE)
      
      print("tidydata.cvs file has been added to your working directory")
}

data.cleaner()
