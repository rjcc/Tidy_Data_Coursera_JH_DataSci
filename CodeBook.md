---
title: "CodeBook.md"
output: html_document
---
The Codebook describes the variables and relevant transformations for the data cleaning project.

# run_analysis.R

## file names

- data_path             : the working folder containing data files 
- train_data_file       : the training data
- test_data_file        : the test data
- train_label_file      : the labels of training data
- test_label_file       : the labels of test data
- features_file         : the feature names
- activilty_label_file  : the activity text labels 
- train_subject_file    : the subject ID No. for training data
- test_subject_file     : the subject ID No. for test data

## variables

 - total_data       : the joined train and test data
 - total_labels     : the joined labels for train and test data
 - total_subjects   : the joined list of subjects from train and test data
 - activity_labels : contains tabel mapping between activity code and text label
 - cols            : keeps the return set from the function "get_feature_cols_means_std"
 - cols_to_keep : stores the columns numbers to keep based on the criteria of feature names that only contain mean and standard deviation
 - cols_names: keeps the column names as returned by the function ""get_feature_cols_means_std". These are used to give descriptive name to each feature
 - total_set   : contains the total set of data combined with activity labels and subject ID numbers
 - averages : stores the final result grouped by activity and subject with average value of all features for each group.

## transformations
  - total_data with all features is filtered based on the given columns for mean and std values. The number of these columns are provided by te function "get_feature_cols_means_std".
  - total_labels is return by the function as integer values. These values are transformed to text label by doing a lookup of values of total_labels into activity_labels dataframe
  - total_set is prepared by doing column bind of observations, activity labels, and subject ID numbers
  - name of columns in total_set are replaced as provided in cols_names
  - averages is obtained by using dplyr library and chaining the functions groupby and summarize_each
  
## Subroutine functions

## join_data

This function does basic checks for file names and data structure before it row binds train and test data. It assumes that first file is training data and second file is test data
    
## get_feature_cols_means_std

It uses the "grep" function to capture all column numbers and column names that contains "mean" or "std" in its description. Once the original feature names are available it uses "gsub" function to replace all special chracters from the text; in this case expecially "()" and "-"
