---
title: "CodeBook"
author: "Wayne Carriker"
date: "Tuesday, March 10, 2015"
output: html_document
---

# Tidy Dataset Features

The tidy dataset consists of a subset of the features in the raw database derived from the
accelerometer and gyroscope 3-axial raw signals from a smart phone sampled while 30
different subjects participated in 6 different activities. More information about the raw
data can be found in the *features_info.txt* file in the *UIC HAR Dataset.zip* file.

## Observations

As noted above, there are 30 test subjects. Each test subject is simply identified by a
corresponding number from 1 to 30. Each subject participated in 6 different activities:
walking, walking up stairs, walking down stairs, sitting, standing, and lying down. These
activities are identified by the labels: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS,
SITTING, STANDING, and LAYING. (Though grammatically incorrect, LAYING was used in the raw
data so it was left that way in the tidy data set as well.)

Across the 30 test subjects there are a total of 10299 observations, for an average of
approximately 343 samples per subject. Test subject 8 has the fewest samples at 281 and
test subject 25 has the most at 409. All of these observations are stored in *tidy.txt*.
In *tidy_means.txt* all of the samples for each subject are averaged together for each
activity resulting in 180 observations (6 per subject).

## Variables

In the raw data there are 561 different pieces of information. All of these are
described in the aforementioned *features_info.txt*. The tidy dataset has been reduced to
"just" 66 different variables in addition to the subject and activity identifiers. 40 of
these variables are time based and include mean and standard deviation values for 5
different 3-axis measurements as well as mean and standard deviations for the overall
magnitudes of the 3-axis measurements. The remaining 26 variables are frequency based
and are the result of applying a Fast Fourier Transform to some of the above time based
variables:

- subject
- activity
- tbodyacc(mean|std)[xyz] - represents 6 different variables
   + tbodyaccmeanx
   + tbodyaccmeany
   + tbodyaccmeanz
   + tbodyaccstdx
   + tbodyaccstdy
   + tbodyaccstdz
- tgravityacc(mean|std)[xyz]
- tbodyaccjerk(mean|std)[xyz]
- tbodygyro(meanx|std)[xyz]
- tbodygyrojerk(mean|std)[xyz]
- tbodyaccmag(mean|std)
- tgravityaccmag(mean|std)
- tbodyaccjerkmag(mean|std)
- tbodygyromag(mean|std)
- tbodygyrojerkmag(mean|std)
- fbodyacc(mean|std)[xyz]
- fbodyaccjerk(mean|std)[xyz]
- fbodygyro(mean|std)[xyz]
- fbodyaccmag(mean|std)
- fbodyaccjerkmag(mean|std)
- fbodygyromag(mean|std)
- fbodygyrojerkmag(mean|std)
