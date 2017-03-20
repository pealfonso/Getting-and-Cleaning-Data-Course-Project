# Getting-and-Cleaning-Data-Course-Project
This repository contains the files for the Peer- Reviewed Getting and Cleaning Data Course Project

This tidy data sets were developed with the script in file: run_analyis.R included in the repository.

See the CodeBook for more information about the data in the tidy data sets

The data sets used to prepare both datasets were obtained from the following website:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The data was processed following the script in: “run_analysis.R” 

Script:

Data is  downloaded from above link into a temporary file

Files downloaded are:

activity_labels.txt

features.txt

X_train.txt

y_train.txt

subject_train.txt

X_test.txt

y_test.txt

subject_test.txt

Files read into data frames in R using read.table.

The variables that refer to mean and std were identified by performing a search using Regular Expressions  in the “features” data.

Performed subsetting on  test data and training data  based on the index and values resulting from above features list.

Obtain vector of activities for test and training data sets by logical subsetting of training and test labels values based on values of factor activities 

Binded columns referring to subjects and activities for both training and test.

Binded rows for both data sets: training and test to obtain the first tidy data set.

Melted the first data set and defined all variables XYZ std and mean as measurements.

Used dcast to reshape the data set into group of subjects, group of activities and the average (mean ) value for each measurement.




Author: Pedro Alfonso
Coursera Course: Getting and Cleaning Data

March 19, 2017






