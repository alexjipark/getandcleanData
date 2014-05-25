## Getting And Cleaning Data Project

### How to create the Tidy dataset
* Download and unzip dataset from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* Full description of the data can be found here (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
* Basic description can be found in README.txt in the unziped file
* Change current directory to directory with the dataset
* Run script run_analysis.R
* The tidy dataset will be created as tidy_dataset.txt

### Assumptions
* Measurements are in X_train.txt, resp.,  X_testing.txt file
* Subject information is in subject_train.txt, resp., subject_testing.txt file
* Activity codes are in y_train.txt, resp., y_testing.txt file
* All activity codes and labels are in activity_labels.txt.
* Names of all features (measurements) are in features.txt.
* All columns representing means contain ...mean() in them.
* All columns representing standard deviations contain ...std() in them.

### Data preparation steps
run_analysis.R does the following:
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive activity names. 
* Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
