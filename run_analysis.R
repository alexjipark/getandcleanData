# Original dataset downloaded from:
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# This R script creates the tidy dateset in the following steps:

library(data.table)
# 0. Loads test and training sets and the activities
test_data <- read.table("./UCI HAR Dataset/test/X_test.txt",header=F)
test_labels <- read.table("./UCI HAR Dataset/test/y_test.txt",header=F)
test_subjects <- read.table("./UCI HAR Dataset/test/subject_test.txt",header=F)
train_data <- read.table("./UCI HAR Dataset/train/X_train.txt",header=F)
train_labels <- read.table("./UCI HAR Dataset/train/y_train.txt",header=F)
train_subjects <- read.table("./UCI HAR Dataset/train/subject_train.txt",header=F)

# 3. Uses descriptive activity names to name the activities in the data set
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt",header=F
                              ,colClasses="character")
test_labels$V1 <- factor(test_labels$V1,levels=activity_labels$V1
                         ,labels=activity_labels$V2)
train_labels$V1 <- factor(train_labels$V1,levels=activity_labels$V1
                          ,labels=activity_labels$V2)

# 4. Appropriately labels the data set with descriptive activity names
features <- read.table("./UCI HAR Dataset/features.txt",header=F
                       ,colClasses="character")
colnames(test_data)<-features$V2
colnames(train_data)<-features$V2
colnames(test_labels)<-c("Activity")
colnames(train_labels)<-c("Activity")
colnames(test_subjects)<-c("Subject")
colnames(train_subjects)<-c("Subject")

# 2. extract only the measurements on the mean and standard deviation for 
#    each measurement
col_mean <- grep("mean()",colnames(test_data), fixed = T)
col_std <- grep("std()",colnames(test_data), fixed = T)

test_data_MS <- test_data[,c(col_mean,col_std)]
train_data_MS <- train_data[,c(col_mean,col_std)]

# 1. merge test and training sets into one data set, including the activities
test_data_MS<-cbind(test_labels,test_data_MS)
test_data_MS<-cbind(test_subjects,test_data_MS)
train_data_MS<-cbind(train_labels,train_data_MS)
train_data_MS<-cbind(train_subjects,train_data_MS)
dataset<-rbind(test_data_MS,train_data_MS)

# 5. Creates a second, independent tidy data set with the average of each 
#    variable for each activity and each subject.
dataset_MS <- data.table(dataset,key = "Subject,Activity")
tidy_dataset <- dataset_MS[, lapply(.SD,mean), by = key(dataset_MS)]
write.table(tidy_dataset, "tidy_dataset.txt", sep = ",", row.names = F)
