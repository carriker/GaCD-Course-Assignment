---
title: "README"
author: "Wayne Carriker"
date: "Tuesday, March 10, 2015"
output: html_document
---

This repository consists of 7 files related to the course assignment for Getting and
Cleaning Data offered by Johns Hopkins Bloomberg School of Public Health through 
Coursera.org in March 2015 (getdata-012). The included files are:

+ README.md - this file (plain text)
+ README.html - this file (html format)
+ CodeBook.md - description of the output variables for this analysis (plain text)
+ CodeBook.html - description of the output variables for this analysis (html text)
+ run_analysis.R - R script file to produce the output data files
+ tidy.txt - the complete "tidied" data set with all 10299 observations
+ tidy_means.txt - the reduced data set with 180 averaged observations

In order to execute the *run_analysis.R* script, it must be stored in a directory with the
source data files that can be obtained from: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip .

Within the zip file are many different data files, but only a small subset are used in
this assignment. The script can unpack just the subset of files that will be used when it
is run, or you can unzip the file before running the script as long as the files are
stored in the appropriate sub-directories:

+ ./run_analysis.R
+ ./UCI HAR Dataset.zip

or

+ ./run_analysis.R
+ ./UCI HAR Dataset/activity_labels.txt
+ ./UCI HAR Dataset/features.txt
+ ./UCI HAR Dataset/test/subject_test.txt
+ ./UCI HAR Dataset/test/X_test.txt
+ ./UCI HAR Dataset/test/y_test.txt
+ ./UCI HAR Dataset/train/subject_train.txt
+ ./UCI HAR Dataset/train/X_train.txt
+ ./UCI HAR Dataset/train/y_train.txt

In either case, the script will combine the data in these 8 files to produce the 2 output
files required for the assignment. You can read the comments in the code (as well as the
code itself) to understand the details, but at a high level the script does the following:

1. Uses a "tidied" version of the data in *features* to label the variables in *X_test*
and *X_train*
2. Combines *subject_test*, *y_test*, and *X_test* columnwise to tie test subjects,
activities, and data together
3. Combines *subject_train*, *y_train*, and *X_train* columnwise to tie training subjects,
activities, and data together
4. Combines the resulting tables together rowwise to tie test and training datasets
together
5. Merges the resulting table with *activity_labels* to convert from the encoded values
to text labels
6. Selects only those columns representing *mean()* and *std()* values in the raw dataset
7. Arranges the resulting table by subject and activity and outputs *tidy.txt*
8. Computes the average value of each variable grouped by subject and activity
9. Re-arranges the resulting table by subject and activity and outputs *tidy_means.txt*

The resulting files contain 68 columns including the subject identifier, a text descrition
of the subject's activity during data collection, 40 measured variables describing
means and standard deviations of the time sampled accelerometer and gyroscope readings,
and 26 additional frequency based variables derived by implementing a Fast Fourier
Transform on a subset of the time based variables. The initial output in *tidy.txt*
includes al 10299 observations. In *tidy_means.txt* the output is reduced to one average
value per variable grouped by subject (30 subjects) and activity (6 activities) for a
total of 180 observations.
