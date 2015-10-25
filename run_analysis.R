library(dplyr)

# Function that merges the data set, the subject and the activity from a given folder.
# 
# parameters:
#     - path: string, name of the folder
#     - features_names: vector of strings, contains the name of all the features in the data set
#     - selected_features_names: vector of logicals, contains boolean value equals to true if the feature should be stored in the tidy data set
# returns:
#     - a data frame with a column for each feature (the name of the columns corresponds to the names in feature.txt), 
#       plus a column for the subject (column name is subject) and one for the activity (column name is activity)
merge_one_dataset <- function(path, features_names, selected_features_names) {
  data_subject <- read.fwf(file = paste("UCI HAR Dataset/", path, "/subject_", path, ".txt", sep = ""), widths = 2)
  data_subject <- rename(data_subject, subject = V1)
  data_feature <- read.fwf(file = paste("UCI HAR Dataset/", path, "/y_", path, ".txt", sep = ""), widths = 1)
  data_feature <- rename(data_feature, activity = V1)
  data_set <- read.fwf(file = paste("UCI HAR Dataset/", path, "/X_", path, ".txt", sep = ""), widths = rep(16, 561))
  colnames(data_set) <- features_names
  selected_set <- data_set[,selected_features_names]
  
  cbind(data_subject, data_feature, selected_set)
}

# Function used to extract column names corresponding to avg() and mean() measures.
#
# returns: 
#     - true if the string passed as parameter contains either the string "mean()" or the string "std()"
#     - false otherwise 
mean_or_std <- function(string) {
  grepl(pattern = "mean\\(\\)", x = string) || grepl(pattern = "std\\(\\)", x = string)
}

# Function that returns a merged data frame from train and test data.
# 
# returns:
#     - a data frame with a column for each feature (the name of the columns corresponds to the names in feature.txt), 
#       plus a column for the subject (column name is subject) and one for the activity (column name is activity)
get_tidy_data <- function() {
  features <- read.csv(file = "UCI HAR Dataset/features.txt", header = FALSE, sep = " ")
  features_names <- as.character(features$V2)
  selected_features_names <- features_names[sapply(features_names, mean_or_std)]
  
  train_set <- merge_one_dataset("train", features_names, selected_features_names)
  test_set <- merge_one_dataset("test", features_names, selected_features_names)
  complete_set <- rbind(train_set, test_set)
  
  activities <- read.csv(file = "UCI HAR Dataset/activity_labels.txt", header = FALSE, sep = " ")$V2
  
  complete_set$activity <- activities[complete_set$activity]
  
  complete_set
  
}

tidy_data <- get_tidy_data()

grouped_average <- tidy_data %>% group_by(subject, activity) %>% summarise_each(funs(mean))

write.table(x = grouped_average, file = "grouped_average.txt", row.names = FALSE)

