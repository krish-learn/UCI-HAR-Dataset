
#The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. 
#The goal is to prepare tidy data that can be used for later analysis. 
#You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository 
#with your script for performing the analysis, and 3) a code book that describes the variables, the data, 
#and any transformations or work that you performed to clean up the data called CodeBook.md. 
#You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts
#work and how they are connected.

#One of the most exciting areas in all of data science right now is wearable computing - Companies like 
#Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. 
#The data linked to from the course website represent data collected from the accelerometers from the 
#Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

##Download data

setwd("C:/Users/Raman/Documents/AI/JHU_DataScience/Getting&CleaningData/data/UCI HAR Dataset/UCI HAR Dataset")

fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl, "dataset.zip")
unzip("Dataset.zip", exdir = getwd())


## Reading all data into a DataFrame
setwd("UCI HAR Dataset")

# features the colnames for the features of X dataset
features <- read.csv("features.txt", header = FALSE, sep = ' ')
features <- as.character(features[,2]) 
# test
str(features)

# Prepare Training dataset
data.train.x <- read.table("./train/X_train.txt")
data.train.y <- read.table("./train/y_train.txt")
data.train.s <- read.table("./train/subject_train.txt")
data.train <- data.frame(data.train.s, data.train.y, data.train.x)
names(data.train) <- c(c('subject', 'activity'), features)
# test
dim(data.train)

# Prepare Test dataset
data.test.x <- read.table("./test/X_test.txt")
data.test.y <- read.table("./test/y_test.txt")
data.test.s <- read.table("./test/subject_test.txt")
data.test <- data.frame(data.test.s, data.test.y, data.test.x)
names(data.test) <- c(c('subject', 'activity'), features)
#test
dim(data.test)

# Q1 - Merge Train & Test into one dataset
mergedata <- rbind(data.train, data.test)
# check the dimenstion of merged dataset
dim(mergedata)

# Q2 - Extract the columns from features that has mean and standard 
mean_std.select <- grep('mean|std', features)
# check features with mean or std
head(mean_std.select, 10)

# Q2 - Extract only the measurements on the mean and standard from the merged data
finaldata <- mergedata[, c(1,2,mean_std.select)]
# check dimensions of new table with mean and std
dim(finaldata)

# Q3 - Use descriptive activity names to name the activities in the data set - Extract Activity names
activitylabels <- read.csv("activity_labels.txt", header = FALSE, sep = ' ')
activitylabels <- as.character(activitylabels[,2]) 

# Q3 - Use descriptive activity names to name the activities in the data set - Assign Activity names
finaldata$activity <- activitylabels[finaldata$activity]
# check if the activity names been assigned
head(finaldata$activity, 30)

# Q4 - Appropriately labels the data set with descriptive variable names
# replace t with time
# replace Acc with Accelerometer
# replace Gyro with Gyroscope
# replace f with frequency
# replace Mag with Magnitude

# check column names before expansion
str(finaldata)
names(finaldata)<-gsub("^t", "time", names(finaldata))
names(finaldata)<-gsub("^f", "frequency", names(finaldata))
names(finaldata)<-gsub("Acc", "Accelerometer", names(finaldata))
names(finaldata)<-gsub("Gyro", "Gyroscope", names(finaldata))
names(finaldata)<-gsub("Mag", "Magnitude", names(finaldata))
# check column names after expansion
str(finaldata)

# Q5 - Create a second,independent tidy data set and ouput it
library(dplyr)
tidydata <- aggregate(. ~subject + activity, finaldata, mean)
write.table(tidydata, file = "tidydata.txt")
# check if tidydata file is created
checktidy <- read.table("tidydata.txt")
head(checktidy,3)


