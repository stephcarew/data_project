---
title: "ReadMe.md"
---

#Summary of Human Activity Recognition Using Smartphones Dataset

##Study Design
The data used in this study was collected as part of the Human Activity Recognition Using Smartphones Dataset Version 1.0. A description of this study is contained in the file Original_Study_README.txt. The original study collected movement-related measurements on 30 subjects performing 6 activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING).

In this analysis, we summarize the mean and standard deviation of each measurement by subject and activity type. An output showing the mean of each of these variables by subject and activity type is contained in the file tidy_data.txt. Information about the variables in the tidy_data.txt file is contained in the file CodeBook.md.

A commented R script called run_analysis.R contains the necessary instructions to go from the raw data collected in the original study to the tidy_data.txt file. Roughly, we perform the following steps:

1. Match the list of features to the measurements collected in the test and training sets.

2. Match the subjects to the measurements collected in the test and training sets.

3. Match the activities to the measurements collected in the test and training sets.

4. Merge the test and training set data.

5. Extract the measurements pertaining to mean and standard deviation.

6. Calculate the mean of each of these measurements by subject and activity and save it to tidy_data.txt