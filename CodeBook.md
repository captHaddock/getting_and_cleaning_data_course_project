# Codebook
The Codebook includes 3 parts

* Package dependencies
* A summary of the steps/transformations done to get from raw to the tidy data.
* A variable description for the tidy data set

## Package dependencies

Following package are used in the script run_analysis.R:

* dplyr
* stringr
* data.table

You will need to install the packages if you do not already have them

## From Raw- to Tidy-data

For best understanding I would recommend to read the comments with the code in the script run_analys.R. In that script an explanition comes together with each programming step.

Following is a summary of the steps/transformations done to get from raw to the tidy data.

1. Dowload raw-data to working directory from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2. Unzip the downloaded folder
3. Read the data into R
4. r-bind the raw-data to one dataframe 
5. Use feature.txt to extract only the measurements on the mean and standard deviation for each measurement.
6. Use the feature.txt to give the columns descriptive variable names.
7. C-bind the subject and activity columns to data with descriptive variable names
8. Create a second, independent tidy data set with the average of each variable for each activity and each subject.

## Variable description:

Following variables are included in the final tidy datset named "tidyData":

#### subject
Integer, describes the subject who performed the activity for each window sample. Its range is from 1 to 30.

#### activity  
Character, describes the activity. There are 6 different activities which can take folling values:

* WALKING
* WALKING_UPSTAIRS
* WALKING_DOWNSTAIRS
* SITTING
* STANDING
* LAYING

The following 66 variables are all numeric. They are all means calculated from the original data for each subject and activity. The variable names has been transformed to camelCase-standard to give the dataset descriptive variable names with a standard that forfills the requierments for variable names in a "tidy" dataset.
The varaible names by themself give information about what is included but I recomend to read the README.txt. that comes with the zipped data for more detailed information

* tBodyAccMeanX 
* tBodyAccMeanY 
* tBodyAccMeanZ 
* tBodyAccStdX 
* tBodyAccStdY 
* tBodyAccStdZ 
* tGravityAccMeanX 
* tGravityAccMeanY 
* tGravityAccMeanZ 
* tGravityAccStdX 
* tGravityAccStdY 
* tGravityAccStdZ 
* tBodyAccJerkMeanX 
* tBodyAccJerkMeanY 
* tBodyAccJerkMeanZ 
* tBodyAccJerkStdX 
* tBodyAccJerkStdY 
* tBodyAccJerkStdZ 
* tBodyGyroMeanX 
* tBodyGyroMeanY 
* tBodyGyroMeanZ 
* tBodyGyroStdX 
* tBodyGyroStdY 
* tBodyGyroStdZ 
* tBodyGyroJerkMeanX 
* tBodyGyroJerkMeanY 
* tBodyGyroJerkMeanZ 
* tBodyGyroJerkStdX 
* tBodyGyroJerkStdY 
* tBodyGyroJerkStdZ 
* tBodyAccMagMean 
* tBodyAccMagStd 
* tGravityAccMagMean 
* tGravityAccMagStd 
* tBodyAccJerkMagMean 
* tBodyAccJerkMagStd 
* tBodyGyroMagMean 
* tBodyGyroMagStd 
* tBodyGyroJerkMagMean 
* tBodyGyroJerkMagStd 
* fBodyAccMeanX 
* fBodyAccMeanY 
* fBodyAccMeanZ 
* fBodyAccStdX 
* fBodyAccStdY 
* fBodyAccStdZ 
* fBodyAccJerkMeanX 
* fBodyAccJerkMeanY 
* fBodyAccJerkMeanZ 
* fBodyAccJerkStdX 
* fBodyAccJerkStdY 
* fBodyAccJerkStdZ 
* fBodyGyroMeanX 
* fBodyGyroMeanY 
* fBodyGyroMeanZ 
* fBodyGyroStdX 
* fBodyGyroStdY 
* fBodyGyroStdZ 
* fBodyAccMagMean 
* fBodyAccMagStd 
* fBodyBodyAccJerkMagMean 
* fBodyBodyAccJerkMagStd 
* fBodyBodyGyroMagMean 
* fBodyBodyGyroMagStd 
* fBodyBodyGyroJerkMagMean 
* fBodyBodyGyroJerkMagStd 