setwd("/Users/RJCC/Dropbox/@Next/AI/JH_data_prep/UCI HAR Dataset")
library(dplyr)

# This script,run_analysis.R, does the following.
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with 
#    the average of each variable for each activity and each subject.

# Subroutine functions
join_data = function(folder_path, file1, file2){
    # This function reads two files of similar datasets, merge and returns them
    
    if(!file.exists(folder_path)){ return("folder path is invalid")}
    
    fullpath_file1 = file.path(folder_path,file1)
    fullpath_file2 = file.path(folder_path,file2)
    data1 = data2 = NULL
    
    if(!file.exists(fullpath_file1) | !file.exists(fullpath_file2)){
        return("please check the file names")
    }
    
    data1 = read.table(fullpath_file1 )
    data2 = read.table(fullpath_file2)
    # This is only a basic check on column shape. It does not check the data types
    # Even it checks, it is hard to verify if they represent the same data
    if(length(data1)!=length(data2)){
        return("two datasets have different number of columns")
    }
    rbind(data1,data2)
    
}

get_feature_cols_means_std = function(folder_path,features_file){
    # This function gets the column numbers for all features that has "mean" and "std"
    
    if(!file.exists(folder_path)){ return("folder path is invalid")}
    
    fullpath_feature_file = file.path(folder_path,features_file)
    
    if(!file.exists(fullpath_feature_file)){
        return("Check filename of the features file")
    }
    
    features = read.table(fullpath_feature_file)
    
    # gets column numbers and names where description has mean or std in it
    col_nums =grep("mean|std",features[,2])
    col_names = grep("mean|std",features[,2],value = TRUE)
    
    # cleans names for any special characters
    col_names = gsub("[()-]","",col_names)
    
    list("col_numbers"=col_nums,"col_names"=col_names)
}

get_activity_names = function(folder_path, activity_file){
    # This function gets the activity names as text corresponding to each number
    
    if(!file.exists(folder_path)){ return("folder path is invalid")}
    
    fullpath_activity_file = file.path(folder_path,activity_file)
    
    if(!file.exists(fullpath_activity_file)){
        return("Check filename of the activity file")
    }
    
    activities = read.table(fullpath_activity_file)
    
    activities
}

data_path = "/Users/RJCC/Dropbox/@Next/AI/JH_data_prep/UCI HAR Dataset"
train_data_file = "/train/X_train.txt"
test_data_file = "/test/X_test.txt"
train_label_file = "/train/y_train.txt"
test_label_file = "/test/y_test.txt"
features_file = "/features.txt"
activilty_label_file = "/activity_labels.txt"
train_subject_file = "/train/subject_train.txt"
test_subject_file = "/test/subject_test.txt"

# Reads data from the files
#observations
total_data = join_data(data_path, train_data_file,test_data_file)
#labels
total_labels = join_data(data_path, train_label_file,test_label_file)
#subjects 
total_subjects = join_data(data_path,train_subject_file,test_subject_file)
#activity text labels
activity_labels = get_activity_names(data_path,activilty_label_file)

# Gets the columns to be kept i.e. only with means and standard deviation
cols = get_feature_cols_means_std(data_path,features_file)
cols_to_keep= cols[[1]]
# selects the given columns as needed
total_data = total_data %>% select(cols_to_keep)

# changes the integer labels with text labels
total_labels = activity_labels[match(total_labels[,1],activity_labels[,1]),2]
#total_labels = as.factor(total_labels)

# Combines observations and labels
total_set = cbind(total_data,total_labels,total_subjects)

# Gives descriptive names to variables
cols_names = cols[[2]]
names(total_set) =c(cols_names,"activitylabel","subject")

averages = total_set %>% group_by(activitylabel,subject) %>% summarize_all(list(mean))
tidydata <- averages
write.table(tidydata, "TidyData.txt", row.name=FALSE, sep=",")
