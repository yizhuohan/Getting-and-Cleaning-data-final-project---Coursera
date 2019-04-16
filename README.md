# Getting-and-Cleaning-data-final-project---Coursera
For cleaning the data, I implemented R programming. 
packages "tidyr", "dplyr" and "reshape2" are used for manipulate the raw dataframe.

The project is for Getting and Cleaning data course on Coursera

The main steps are as follow: 
1.Merges the training and the test sets to create one data set.
2.Extracts only the measurements on the mean and standard deviation for each measurement.
3.Uses descriptive activity names to name the activities in the data set
4.Appropriately labels the data set with descriptive variable names.
5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Each step were commented above the r script. For the first step, 
instead of only combine test and train sets, I directly bind out the whole data with variables, targets, and column names. 
