## This R script is the programming assignment for the Coursera course 'getting and cleaning data'

## The script processes a data set containing accellerometer data collected from a smartphone.
## The data was provided by the course and can be found at: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Note: this script assumes that the 'UCI HAR Dataset' folder is in the working directory.

## 1. Merge training and test data sets to create one data set

## 2. Extracts only the measurements on the mean and standard deviation for each data set

# Read in 'features.txt'
# ? Clean up feature names?
# Use grepl to create logical vectors for features based on means and standard deviations
# Retain only those variables

## 3. Uses descriptive activity names to name activities in the data set

# Read in 'activity_labels.txt'
# Clean labels up (get rid of numbers)
# Re-code Y variable using activity label values [check this is the right variable]

## 4. Create a second, independent tidy data set with the average of each variable for each activity and subject

# Calculate avreages by subject and by activity
# Return tidy data.frame [check principles of tidy data]
