###  Preparation before running the script ----
  
# 1. Put yourself in your desired working directory.

# 2. Dowload data to working directory
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./20Dataset.zip", method = "curl")

# 3. Unzip downloaded folder before reading data into R

# 4. Load libraries 
# You will need to install the packages if you do not already have them
library(dplyr)
library(stringr)
library(data.table)


###  Step 1 ----

# Read raw-data into R and name files according to names from source
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt") 
# 2947 obs, 561 variables

y_test <- read.table("./UCI HAR Dataset/test/y_test.txt") 
# 2947 obs, 1 variable

subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt") 
# 2947 obs, 561 variables

X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
# 7352 obs, 561 variable

y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
# 7352 obs, 1 variable

subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
# 7352 obs, 1 variable

# r-bind "X_test" and "X_train" to one dataframe 
data <- rbind(X_test, X_train)
# 10299 obs, 561 variables
label <- rbind(y_test, y_train)
# 10299 obs, 1 variable
subject <- rbind(subject_test, subject_train)

# I wait with c-binding "data", "label" and "subject" until I picked out the relevant
# variables from "data". Important to not change sorting order of "data before 
# c-binding "label" and "subject".


### Step 2 ----
### Extracts only the measurements on the mean and standard deviation for each measurement. 
features <- read.table("./UCI HAR Dataset/features.txt")
# 561 obs, 2 variables
# column V2 in fetures describes the variables in "data" for test and train.

# I need "\\(\\)" after the "mean" and "std" string to avoid variables like
# "fBodyGyro-meanFreq()-Z". I only want variables with "mean" and "std" directly 
# followed by "()"
meanStd <- grep("mean\\(\\)|std\\(\\)", features[, 2])
features[meanStd, ]
# Looks OK, 66 values

dataMeanStd <- data[, meanStd]
# 10299 obs, 66 variables

# Set names to camelCase-standard to give the dataset descriptive variable names with 
# a standard that forfills the requierments for variable names in a "tidy" dataset.
# This is maybe a part of step 4 but I find it easier to do here.

names <- features[meanStd, ]

names2 <- names %>% 
  arrange(V1) %>% 
  mutate(V3 = str_replace_all(V2, "\\(\\)", "")) %>% 
  mutate(V3 = str_replace_all(V3, "-", "")) %>%
  mutate(V3 = str_replace_all(V3, "mean", "Mean")) %>%
  mutate(V3 = str_replace_all(V3, "std", "Std"))
# Names looks OK

# Apply variablenames do data
names(dataMeanStd) <- c(names2$V3)


### Step 3 & 4 ----
### Uses descriptive activity names to name the activities in the data set
### Appropriately labels the data set with descriptive variable names. 

activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
# 6 obs, 2 variables.

# activity_labels can be used to replace codevalues in "label" data
activity_labels$V2 <- as.character(activity_labels$V2)
activity <- left_join(label, activity_labels, by = "V1")
activity <- select(activity, V2)
# 10299 obs

# Change variable names
names(activity) <- "activity"
names(subject) <- "subject"

# c-bind variables "activity" and "subject" to "dataMeanStd"
dataMeanStd <- cbind(subject, activity, dataMeanStd)

# Sort the final data
dataMeanStd <- arrange(dataMeanStd, subject, activity)

### 5 ----
### From the data set in step 4, creates a second, independent tidy data set with the
### average of each variable for each activity and each subject.

# I find it easier to make the tidy data set in data.table package compared to use
# the aggregate() function.
dataMeanStd <- as.data.table(dataMeanStd)
tidyData <- dataMeanStd[, lapply(.SD, mean), by = list(subject, activity)]
head(tidyData)
# Looks OK
