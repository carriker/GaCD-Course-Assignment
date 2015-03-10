## ------|---------|---------|---------|---------|---------|---------|---------|---------|
##
## run_analysis.R
##
## Course project for Getting and Cleaning Data (getdata-012) - March 2015
##
## This script takes raw data from a number of files from a "Human Activity Recognition
## Using Smartphones" study and produces two "tidy data" output files.
##
## Author: Wayne Carriker
## Date:   March 9, 2015
##

## Inputs
## Script assumes starting in a directory which contains a sub-directory: UCI HAR Dataset
##  CodeBook.Rmd             - describes the variables in the output
##  README.Rmd               - describes how all the assignment files fit together
##  run_analysis.R           - this script
##  UCI HAR Dataset.zip      - zipped directory/file set
##    or
##  UCI HAR Dataset          - unzipped directory/file structure with assignment inputs
##   activity_labels.txt     - input providing text descriptions of subject activities
##   features.txt            - input providing text descriptions of test data columns
##   test                    - 1st sub-directory with test subject data
##    subject_test.txt       - input providing test subject identifiers
##    X_test.txt             - input providing test subject data
##    y_test.txt             - input providing test subject activity codes
##   train                   - 2nd sub-directory with test subject data
##    subject_test.txt       - input providing test subject identifiers
##    X_test.txt             - input providing test subject data
##    y_test.txt             - input providing test subject activity codes
## many additional files also exist in UCI HAR Dataset, but they are unused in this
## assignment, so they can be ignored

## Outputs
##  tidy.txt                 - output combining test & train data sets for mean() & std()
##  tidy_means.txt           - output of average of each variable by subject & activity
## both output files are sorted by subject number and activity number


## First, determine if the data exists in a zip file or if it has already been unpacked
## and adjust the working directory to shorten path references in the script. We'll
## move back to the root directory for the output files so no changes to the raw data.
## Also load plyr and dplyr libraries for 'arrange', 'select', and 'ddply'.
if (!file.exists("./UCI HAR Dataset/activity_labels.txt")) {
    unzip("UCI HAR Dataset.zip", files = c("UCI HAR Dataset/activity_labels.txt", 
                                           "UCI HAR Dataset/features.txt",
                                           "UCI HAR Dataset/test/subject_test.txt",
                                           "UCI HAR Dataset/test/X_test.txt",
                                           "UCI HAR Dataset/test/y_test.txt",
                                           "UCI HAR Dataset/train/subject_train.txt",
                                           "UCI HAR Dataset/train/X_train.txt",
                                           "UCI HAR Dataset/train/y_train.txt"))
}
setwd("./UCI HAR Dataset")
library(plyr, quietly = TRUE)
library(dplyr, quietly = TRUE)

## Second, load the activity labels and the data feature labels
activity_labels <- read.table("activity_labels.txt", sep = " ", 
                             col.names = c("activitynumber", "activity"), 
                             colClasses = c("numeric", "character"))
feature_labels <- read.table("features.txt", sep = " ", 
                             col.names = c("featurecol", "feature"), 
                             colClasses = c("numeric", "character"))

## Third, load the test and training data
## test_activities and train_activities are prepped for merging with activity_labels
## feature_labels is used directly to name data columns, resulting in some automatic
## conversion of the labels to remove '-' and '()' which will be further cleaned later
test_subjects <- read.table("test/subject_test.txt", col.names = "subject")
test_activities <- read.table("test/y_test.txt", col.names = "activitynumber")
train_subjects <- read.table("train/subject_train.txt", col.names = "subject")
train_activities <- read.table("train/y_train.txt", col.names = "activitynumber")
## read.table is pretty slow to actually load the data, but fread doesn't work cleanly
## with the files (at least not on a Windows machine) so there you go...
test_data <- read.table("test/X_test.txt", col.names = feature_labels$feature)
train_data <- read.table("train/X_train.txt", col.names = feature_labels$feature)

## Fourth, combine the data frames into one:
##   Combine subject, activitiy number, and data columns
##   Combine test and train rows
##   Merge activity descriptions
##   Order the rows by subject and activity number and columns by subject, activity & data
##   Drop all the columns except subject, activity, and mean() and std() data
data <- rbind(cbind(test_subjects, test_activities, test_data), 
              cbind(train_subjects, train_activities, train_data))
data <- merge(data, activity_labels, by.x = "activitynumber", by.y = "activitynumber")
data <- data[,c(2,1,564,3:563)]
data <- arrange(data, subject, activitynumber)
data <- select(data, matches("^subject$|^activity|(mean|std)\\.\\.(\\.[XYZ]|$)"))

## Fifth, clean up the data labels and save
##   No capital letters
##   No periods
##   Also fix a typo in the input data which sometimes has 'bodybody' instead of 'body'
##   (Note, while I felt compelled to correct this typo in the data, I did not feel
##   compelled to correct the activity labels grammar to replace 'Laying' with 'Lying')
##   Save as 'tidy.txt' (first return to the starting directory)
labels <- gsub("\\.", "", tolower(names(data)))
labels <- gsub("bodybody", "body", labels)
names(data) <- labels
setwd("..")
write.table(data[-2], file = "tidy.txt", row.names = FALSE)

## Finally, summarize the table and save it to 'tidy_means.txt'
## This data transformation is trivial with the correct library function
library(plyr, quiet = TRUE)
new_data <- ddply(data, .(subject, activity), numcolwise(mean))
new_data <- arrange(new_data, subject, activitynumber)
write.table(new_data[-3], file = "tidy_means.txt", row.names = FALSE)
