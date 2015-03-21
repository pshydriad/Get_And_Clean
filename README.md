# Get_And_Clean
The course assignment for the Get and Clean Data class


################    ---- BEFORE YOU BEGIN ----    #################

It is assumed that you are familiar with the UCI Machine Learning data set as outlined in the course assignment.  No attempt is made here to reproduce the content that is in the readme of that data set.

################      ---- run_analysis.R ----    #################

This script takes the data from the UCI Machine Learning repository and creates two tidy sets, the last of which is written out to a text file.  

First, a consolidated data file is created which is a collection of all of the data in both the test and training data sets.  Care is taken to create readable field values for activities as well as column names.

Next, a thinner data set is made by taking only those columns which represent the mean() and std() of the data.

Last, this thinner data set is summerized by taking the mean of every variable column grouped on the subject and activity.  

This last data set is written out to a file named meansdata.txt


################    ---- meansdata.txt ----    #################

The resulting data of the code is written out to this file.

The data set includes 180 records.  One for each of the 30 people in the study for each of the 6 activities.

First are the columns of the file that identify the subject and their activities at the time of the measurements

Activity_Code
Activity_Name
Subject

Then there is a seperate column for the mean and the std of each of the following measurements.  Also, each item shown below with an XYZ appears as a distinct column for each axis.  Therefore a single line below might represent as many as six variables.  

That is ... var-mean()-X, var-mean()-Y, var-mean()-Z, var-std()-X, var-std()-Y, var-std()-Z

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

Please refer to the readme for the dataset for more infomration on the values included.