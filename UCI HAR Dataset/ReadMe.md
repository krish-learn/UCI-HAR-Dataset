---
title: "RunAnalysisReadMe"
author: "KK"
date: "September 21, 2018"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

Getting and Cleaning Data - Course Project

run_analysis.R does the following - 

 - Merges the training and the test sets to create one data set.
 - Extracts only the measurements on the mean and standard deviation for each measurement.
 - Uses descriptive activity names to name the activities in the data set
 - Appropriately labels the data set with descriptive activity names.
 - Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Steps to use the run_analysis.R 
 - Download the data source and put into a folder on your local drive. You'll have a UCI HAR Dataset folder.
 - Save run_analysis.R in the parent folder of UCI HAR Dataset, then set it as your working directory using setwd() function in RStudio.
 - Run source("run_analysis.R"), then it will generate a new file tidydata.txt in your working directory.

Dependencies
libraries - data.table and dplyr. run_analysis.R file will install the dependencies automatically. 
