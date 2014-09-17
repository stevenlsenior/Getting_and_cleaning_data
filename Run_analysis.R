## This R script is the programming assignment for the Coursera course 'getting and cleaning data'

## The script processes a data set containing accellerometer data collected from a smartphone.
## The data was provided by the course and can be found at: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Note: this script assumes that the 'UCI HAR Dataset' folder is in the working directory.

# This script uses the dplyr package
install.packages("dplyr")
library(dplyr)

## 1. Merge training and test data sets to create one data set

# Read in X, Y and subject variable sets for test and training data using readLines and read.table respectively
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
Y_test <- readLines("UCI HAR Dataset/test/Y_test.txt")
subject_test <- readLines("UCI HAR Dataset/test/subject_test.txt")

X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
Y_train <- readLines("UCI HAR Dataset/train/Y_train.txt")
subject_train <- readLines("UCI HAR Dataset/train/subject_train.txt")

# Use cbind() to append the Y variable to the X variables in both test and train datasets
test <- as.tbl(cbind(subject_test, Y_test, X_test))
train <- as.tbl(cbind(subject_train, Y_train, X_train))

## 2. Extracts only the measurements on the mean and standard deviation for each data set

# Read in 'features.txt' and add as variable names
features <- readLines("UCI HAR Dataset/features.txt")
features <- c("subject", "activity", features)        # First two columns were added from 'subject' and 'Y' files
names(test)  <- features
names(train) <- features

# Use rbind_list() to merge the training and test data sets together
all_data <- rbind(test, train)


# Use select() and contains() to select only columns containing mean and sd measurements
mean_std <- select(all_data, subject, activity, contains("-mean()"), contains("-std()"))

## 3. Uses descriptive activity names to name activities in the data set

# Read in 'activity_labels.txt' and recode Activity values accordingly
act_labs <- read.table("UCI HAR Dataset/activity_labels.txt")

relabel <- function(x){
	act_labs$V2[act_labs$V1 == x]  # Looks up the activity value in act_labs$V1 and returns the corresponding label
	} 

mean_std <- mutate(mean_std, activity = sapply(as.integer(activity), relabel))

## 4. Create a second, independent tidy data set with the average of each variable for each activity and subject
tidy <- mean_std %>%
	group_by(subject, activity) %>%
	summarise_each(funs = "mean")       # Calculate averages by subject and by activity
