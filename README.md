---
title: "README.md"

Output : a dataframe of averages in grouped_df form with name "averages"

---
Information about the R scripts used for the data cleaning project. The project is based on data collected from the accelerometers  from the samsung galaxy smarphone. Full description of the dataset is available at 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


This repo is for the "Get and Clean Data" Coursera by John Hopkins on Data Sci, the week-4 assignment...


# Run_analysis.R

This is the script that is called to performed the cleaning and tidying of the dataset as described in the excercise and listed below.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

This file assumes that datazip file has been downloaded and unzipped.


The functions to read data from the files are as followings.

 * join_data
    - Takes names of two data files with similar variables and return the row-combined dataset 
 * get_feature_cols_means_std
    - Takes the features file name as input, filters the feature names for "mean" and "std", and then returns the filtered column numbers and tidy names
 * get_activity_names
    - Reads the file that contains activity names and number mapping
