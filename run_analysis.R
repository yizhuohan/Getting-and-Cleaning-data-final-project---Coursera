library(dplyr)
library(tidyr)
#read all the files
X_test <- read.table("C:\\Users\\yizhuohan\\Documents\\Getting and Cleaning Data\\UCI HAR Dataset\\test\\X_test.txt", header = F)
y_test <- read.table("C:\\Users\\yizhuohan\\Documents\\Getting and Cleaning Data\\UCI HAR Dataset\\test\\y_test.txt", header = F, sep = "", dec = ".")
subject_test <- read.table("C:\\Users\\yizhuohan\\Documents\\Getting and Cleaning Data\\UCI HAR Dataset\\test\\subject_test.txt")
X_train <- read.table("C:\\Users\\yizhuohan\\Documents\\Getting and Cleaning Data\\UCI HAR Dataset\\train\\X_train.txt", header = F, sep = "", dec = ".")
y_train <- read.table("C:\\Users\\yizhuohan\\Documents\\Getting and Cleaning Data\\UCI HAR Dataset\\train\\y_train.txt", header = F, sep = "", dec = ".")

subject_train <- read.table("C:\\Users\\yizhuohan\\Documents\\Getting and Cleaning Data\\UCI HAR Dataset\\train\\subject_train.txt")

features <- read.table("C:\\Users\\yizhuohan\\Documents\\Getting and Cleaning Data\\UCI HAR Dataset\\features.txt")
features$V2 <- as.character(features$V2)
activities <- read.table("C:\\Users\\yizhuohan\\Documents\\Getting and Cleaning Data\\UCI HAR Dataset\\activity_labels.txt")
activities$V2 <- as.character(activities$V2)
#Merges the training and the test sets to create one data set.
#I also combined the subject and activities into the new data frame
Newdf <- rbind(
  cbind(subject_test, X_test, y_test),
  cbind(subject_train, X_train, y_train)
)
colnames(Newdf) <- c("can_ind", features$V2, "target")

head(Newdf) #check

#Extracts only the measurements on the mean and standard deviation for each measurement.

features_onlymeanandstd <- grep("-(mean|std).*", features$V2)
mappingname <- features[features_onlymeanandstd, 2]
mappingname <- gsub("-mean", "Mean", mappingname)
mappingname <- gsub("-std", "SD", mappingname)
mappingname <- gsub("[-()]", "", mappingname)

# subset the desired columns by names
Only_Variables <- rbind(X_train, X_test)
Only_Variables <- Only_Variables[features_onlymeanandstd]
target <- rbind(y_train, y_test)
Only_Subjects <- rbind(subject_train, subject_test)
Newnewdf <- cbind(Only_Subjects,Only_Variables,target)
#Appropriately labels the data set with descriptive variable names.
colnames(Newnewdf) <- c("Subject",as.character(mappingname) ,"Activity")

#Uses descriptive activity names to name the activities in the data set
Newnewdf$Activity <- factor(Newnewdf$Activity, levels = activities$V1, labels = activities$V2)
Newnewdf$Subject <- as.factor(Newnewdf$Subject)

#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
library(reshape2)
Newnewdf %>%
  melt(id = c("Subject", "Activity")) %>%
  dcast(Subject + Activity ~ variable, fun.aggregate = mean)

#write the file out
write.table(tidyData, "C:\\Users\\yizhuohan\\Documents\\Getting and Cleaning Data\\tidy_dataset.txt", row.names = FALSE, quote = FALSE)

