###############################################################
##
## run_analysis.R
## ------------
## Course assignment for Getting and Cleaning Datasets 
## March 21, 2015
##
################    ---- ASSIGNMENT  ----    #################
##
## 1. Merges the training and test data sets to create one combined data set
## 2. Extract only the measurements on the mean and standard deviation for each measurement
## 3. Uses descriptive activity names to name the activities in the data set.
## 4. Appropriately lables the data set with descriptive variable names.
## 5. Create a second, independently tidy data set with the average of each variable for each activity and each subject.
##
################    ---- ASSUMPTIONS  ----    #################
##
## The contents of the assignment zip file have been extracted to the working directory
## which now contains a folder called UCI HAR Dataset and the associated sub folders.
##
################    ---- ATTRIBUTION  ----    #################
##
## Data used for this assignment is attributed as follows:
## Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
##
###############################################################
##
##
require(plyr)
require(dplyr)
##


## Combine the two main tables
data <- rbind(
                cbind(
                    read.table("UCI HAR Dataset\\test\\subject_test.txt", header = FALSE),
                    read.table("UCI HAR Dataset\\test\\y_test.txt", header = FALSE),
                    read.table("UCI HAR Dataset\\test\\X_test.txt", header = FALSE)
                )
              ,
                cbind(
                    read.table("UCI HAR Dataset\\train\\subject_train.txt", header = FALSE),
                    read.table("UCI HAR Dataset\\train\\y_train.txt", header = FALSE),
                    read.table("UCI HAR Dataset\\train\\X_train.txt", header = FALSE)
                )
              )

## Add the header lables from the features file in the top folder
colnames(data) <- c("Subject","Activity_Code",as.vector(read.table("UCI HAR Dataset\\features.txt")[,2]))

## Get the reference activity types
activities <- read.table("UCI HAR Dataset\\activity_labels.txt")
colnames(activities) <- c("Activity_Code","Activity_Name")

## Add the activity label to the main data table
data <- join(activities, data, by = "Activity_Code")

# Seed the thin data set wtih the columns about the subject and the activity
thindata <- data[,1:3]
# Indicate the next column to add to the thin dataset
tdi <- 4

for (fdi in 4:ncol(data)){
    if( (length(grep('-mean\\(\\)',colnames(data)[fdi])) > 0) | 
        (length(grep('-std\\(\\)',colnames(data)[fdi])) > 0)  )
    {
        # Add the column to the thin data set from the fat data set
        thindata <- cbind(thindata, data[,fdi])
        # Name the column in the thin data set as the same name as the one from the fat data set
        names(thindata)[tdi] <- names(data)[fdi] 
        tdi <- tdi+1
    }
}

## Now find the averages for each group of subject and activity (30 subjects times 6 activities, expecting 180 rows)
means_data = ddply(thindata, .(Activity_Code, Activity_Name, Subject), colwise(mean))
write.table(means_data, "meansdata.txt", row.name=FALSE)


