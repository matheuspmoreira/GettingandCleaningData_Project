## Setting to the file directory.
getwd()
setwd("C:/Users/Matheus/Desktop/Data Science/R/Coursera Data Science/Obtendo e limpando os dados/Projeto/UCI HAR Dataset")


## Reading the train data and its activities
train_data <- read.table("train/X_train.txt")
train_activity <- read.table("train/Y_train.txt")

## Reading the test data and its activities
test_data <- read.table("test/X_test.txt")
test_activity <- read.table("test/Y_test.txt")
                        
## Labeling the data set with descriptive variable names taken from
## the "features.txt" file 
col_names <- readLines("features.txt")
colnames(train_data) <-  col_names
colnames(test_data) <- col_names

## Renaming the train and test activity column
colnames(train_activity) <- "activity"
colnames(test_activity) <- "activity"

## Combining into the same dataframe '_activity' and '_data' data
train_final <- cbind(train_activity,train_data)
test_final <- cbind(test_activity,test_data)

## Merging the training and the test sets into 'final_data'
#==================================================================
## OUTPUT PART 1
final_data <- rbind(train_final,test_final)
# Transforming the activity column into a factor column.
final_data$activity <- factor(final_data$activity)
#=================================================================

## Extracting only the measurements on the mean and standard
## deviation for each measurement.
library(dplyr)
measurements_mean_std <- final_data %>% select(activity | grep("mean()[^A-z0-9_]|std", colnames(final_data)))

## Using descriptive activity names to name the activities
## in the data set
levels(measurements_mean_std$activity) <- c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS",
                              "SITTING","STANDING", "LAYING")


## Creating a second, independent tidy data set with the average
## of each variable for each activity and each subject.
average_data <- measurements_mean_std %>% group_by(activity) %>% summarise_if(is.numeric, mean)

