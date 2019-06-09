---
title: "README.md"

Output : a dataframe of averages in grouped_df form with name "averages"

---
Information about the R scripts used for the data cleaning project. The project is based on data collected from the accelerometers  from the samsung galaxy smarphone. Full description of the dataset is available at 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


This repo is for the "Get and Clean Data" Coursera by John Hopkins on Data Sci, the week-4 assignment...


# Run_analysis.R

This is the script that is called to performed the cleaning and tidying of the dataset as described in the excercise and listed below.

This script assumes that the dataset.zip file has been downloaded and unzipped.
(https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


The functions to read data from the files are as followings.

 * join_data
    - Takes names of two data files with similar variables and return the row-combined dataset 
 * get_feature_cols_means_std
    - Takes the features file name as input, filters the feature names for "mean" and "std", and then returns the filtered column numbers and tidy names
 * get_activity_names
    - Reads the file that contains activity names and number mapping

# Codebook.md: describes the variables, functions, and relevant transformations for the data cleaning project.

## run_analysis.R

## File names

- data_path             : the working folder containing data files;
- train_data_file       : the training data;
- test_data_file        : the test data;
- train_label_file      : the labels of training data;
- test_label_file       : the labels of test data;
- features_file         : the feature names;
- activilty_label_file  : the activity text labels; 
- train_subject_file    : the subject ID No. for training data;
- test_subject_file     : the subject ID No. for test data.

## Variables

 - total_data       : the joined train and test data;
 - total_labels     : the joined labels for train and test data;
 - total_subjects   : the joined list of subjects from train and test data;
 - activity_labels : contains tabel mapping between activity code and text label;
 - cols            : keeps the return set from the function "get_feature_cols_means_std";
 - cols_to_keep : stores the columns numbers to keep based on the criteria of feature names that only contain mean and standard deviation;
 - cols_names: keeps the column names as returned by the function ""get_feature_cols_means_std". These are used to give descriptive name to each feature;
 - total_set   : contains the total set of data combined with activity labels and subject ID numbers;
 - averages : stores the final result grouped by activity and subject with average value of all features for each group.

## Transformations
  - total_data with all features is filtered based on the given columns for mean and std values. The number of these columns are provided by te function "get_feature_cols_means_std".
  - total_labels is return by the function as integer values. These values are transformed to text label by doing a lookup of values of total_labels into activity_labels dataframe.
  - total_set is prepared by doing column bind of observations, activity labels, and subject ID numbers.
  - name of columns in total_set are replaced as provided in cols_names.
  - averages is obtained by using dplyr library and chaining the functions groupby and summarize_each.
  
## Subroutine functions

## join_data

This function does basic checks for file names and data structure before it row binds train and test data. It assumes that first file is training data and second file is test data.
    
## get_feature_cols_means_std

It uses the "grep" function to capture all column numbers and column names that contains "mean" or "std" in its description. Once the original feature names are available it uses "gsub" function to replace all special chracters from the text; in this case expecially "()" and "-".

## get_activity_names
This function gets the activity names as text corresponding to each number.
