# Code book

## Data set generated

* tidy_data: contains the tidy data as per step 4 of the project assignment
* grouped_average(.txt): contains the grouped mean data as per step 5 of the project assignment

## Column names

The observations corresponding to the features, the subject id and the activity are merged using the ```cbind``` function. The train and test set are then merged together using the ```rbind``` function.

### Selected features and feature names

The names of the feature are cotming from the file ```features.txt```. Only the features for which the name contains the substring ```"mean()"``` or ```"std()"``` are kept in the tidy data.

* No transformation are made to the features data in the tidy_data.
* In the data set grouped_average(.txt), the features columns contain the mean of the each features grouped by subject id and by activity. 

### Subject

The name of the column containing the subject id is ```subject```.

No modification is made to the subject id data.

### Activity

The name of the column containing the subject id is ```activity```. The activity id is then replaced by the corresponding activity name from the file ```activity_labels.txt```. The activity data is of type factor.
