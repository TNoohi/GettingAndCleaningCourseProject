# Getting and Cleaning Course Project

# Loading Required Libraries
library(dplyr)

# Downloading Data
fileName <- "GettingandCleaningCourseProject.zip"
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, fileName, method="curl")
unzip(fileName)

# Assigning All Data Frames

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)

# Merging Data
X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)
All_Data <- cbind(subject, Y, X)

#Extracting only the measurements on the mean and standard deviation for each measurement.
subSetData <- All_Data %>% select(subject, code, contains("mean"), contains("std"))



#Using descriptive activity names to name the activities in the data set.
subSetData$code <- activities[subSetData$code, 2]


# Appropriately labels the data set with descriptive variable names.
names(subSetData)[1] = "Subject"
names(subSetData)[2] = "Activity"
names(subSetData)<-gsub("Acc", "_Accelerometer", names(subSetData))
names(subSetData)<-gsub("Gyro", "_Gyroscope", names(subSetData))
names(subSetData)<-gsub("BodyBody|Body", "_Body", names(subSetData))
names(subSetData)<-gsub("Mag", "_Magnitude", names(subSetData))
names(subSetData)<-gsub("^t", "Time", names(subSetData))
names(subSetData)<-gsub("\\.t", "_Time", names(subSetData))
names(subSetData)<-gsub("tBody", "Time_Body", names(subSetData))
names(subSetData)<-gsub("[Mm]ean|\\.[Mm]ean|\\.[Mm]ean(\\.*){2,3}", "_Mean", names(subSetData))
names(subSetData)<-gsub("std|\\.std|\\.std(\\.*){2,3}", "_STD", names(subSetData))
names(subSetData)<-gsub("[Ff]req|\\.[Ff]req|[Ff]req(\\.*){2,3}", "_Frequency", names(subSetData))
names(subSetData)<-gsub("^f", "Frequency", names(subSetData))
names(subSetData)<-gsub("angle", "Angle", names(subSetData))
names(subSetData)<-gsub("(\\.*){0,2}[Gg]ravity", "_Gravity", names(subSetData))
names(subSetData)<-gsub("Jerk", "_Jerk", names(subSetData))
names(subSetData)<-gsub("(\\.*){0,3}X", "_X", names(subSetData))
names(subSetData)<-gsub("(\\.*){0,3}Y", "_Y", names(subSetData))
names(subSetData)<-gsub("(\\.*){0,3}Z", "_Z", names(subSetData))





# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

FinalData <- subSetData %>%
  group_by(Subject, Activity) %>%
  summarise_all(funs(mean))
write.table(FinalData, "FinalData.txt", row.name=FALSE)
