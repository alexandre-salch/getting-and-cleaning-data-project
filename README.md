# getting-and-cleaning-data-project

## Prerequisites

Your working directory should contain the data extracted from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip unzipped into the folder "UCI HAR Dataset". Such that the file activity_labels.txt can be accessed from your working directory by the URL "UCI HAR Dataset/activity_labels.txt".

Please refer to the readme in the archive to learn more about this data set.

## run_analysis.R

The script ```run_analysis.R``` will merge the data from the data sets (train and test) and create a single tidy data containing the subject id, the activity name and all average and standard deviations features.

From this data, the script computes the means of all features grouped by subject id and activity name. The resulting data set is then stored in the file ```grouped_average.txt``` in the working directory.

Please refer to the [codebook](codebook.md) to learn more about contents of the tidy data and grouped average. 
