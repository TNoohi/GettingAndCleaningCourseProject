run_analysis.R follows the 5 steps required as described in the course project’s definition

1. Download the dataset
		Dataset downloaded and extracted under the folder called UCI HAR Dataset

2. Assign each data to variables

	features <- features.txt 
	
	activities <- activity_labels.txt
	
	subject_test <- test/subject_test.txt 
	
	x_test <- test/X_test.txt 
	
	y_test <- test/y_test.txt 
	
	subject_train <- test/subject_train.txt 
	
	x_train <- test/X_train.txt 
	
	y_train <- test/y_train.txt 


3.Merges the training and the test sets to create one data set

	X (10299 rows, 561 columns) is created by merging x_train and x_test using rbind() function
	
	Y (10299 rows, 1 column) is created by merging y_train and y_test using rbind() function
	
	Subject (10299 rows, 1 column) is created by merging subject_train and subject_test using rbind() function
	
	All_Data (10299 rows, 563 column) is created by merging Subject, Y and X using cbind() function

4.Extracts only the measurements on the mean and standard deviation for each measurement

	subSetData (10299 rows, 88 columns) is created by subsetting All_Data, selecting only columns: subject, code and the measurements on the mean and standard deviation (std) for each measurement

5. Uses descriptive activity names to name the activities in the data set

	- Entire numbers in code column of the subSetData replaced with corresponding activity taken from second column of the activities variable

- Appropriately labels the data set with descriptive variable names

		1 . code column in subSetData renamed into activities

		2. All word strats with capital letter

		3. Words are separated by "_" to make them easier to read

		4. All Acc in column’s name replaced by Accelerometer

		5. All Gyro in column’s name replaced by Gyroscope

		6. All BodyBody in column’s name replaced by Body

		7. All Mag in column’s name replaced by Magnitude

		8. All start with character f in column’s name replaced by Frequency

		9. All start with character t in column’s name replaced by Time


	-Code:
	
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


5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

	FinalData (180 rows, 88 columns) is created by sumarizing subSetData taking the means of each variable for each activity and each subject, after groupped by subject and activity.
	
	Export FinalData into FinalData.txt file.
