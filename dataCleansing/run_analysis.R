library(dplyr)
library(data.table)

downloadData <- function() {
  working_data <- "getdata-projectfiles-UCI HAR Dataset"
  
  ## Fetching the dataset:
  if (!file.exists(working_data)){
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
    download.file(fileURL, working_data, method="curl")
  }  
  if (!file.exists("UCI HAR Dataset")) { 
    unzip(working_data) 
  }
}

runAnalysis <- function() {
  
  downloadData()

#Now we extract all the feature dataset
featureData <- read.table("UCI HAR Dataset/features.txt")

#Preparing the training dataset
trainingData <- read.table("UCI HAR Dataset/train/X_train.txt")
#Creating the test dataset
testingData <- read.table("UCI HAR Dataset/test/X_test.txt")

#Now merging all the data
mergedData <- rbind(trainingData, testingData)
colnames(mergedData) <- t(featureData[,2])

#find means and std of data
means_stds_features <- featureData$V2[grep("mean\\(\\)|std\\(\\)", featureData[, 2])]

#merging activity, subject with original dataset
resultingDataset<-cbind(mergedData,getSubjects(),getActivities())

#tidying resultingDataset containing means_stds_features as per activity and subject
dataTidy <- melt(resultingDataset, id.vars=means_stds_features, measure.vars=c("subject", "activity"))

#Set new labels for columns
names(dataTidy)<-gsub("^t", "Time-", names(dataTidy))
names(dataTidy)<-gsub("^f", "Frequency-", names(dataTidy))
names(dataTidy)<-gsub("Acc", "-Accelerometer-", names(dataTidy))
names(dataTidy)<-gsub("Gyro", "-Gyroscope-", names(dataTidy))
names(dataTidy)<-gsub("Mag", "-Magnitude-", names(dataTidy))

#finally writing tidy means data
write.table(dataTidy, "tidy_means_data.txt", row.names = FALSE)
}

getSubjects <- function() {
  
  #fetching subjects data
  trainingSubjectData <- read.table("UCI HAR Dataset/train/subject_train.txt")
  testingSubjectData <- read.table("UCI HAR Dataset/test/subject_test.txt" )
  finalSubjectsData <- rbind(trainingSubjectData, testingSubjectData)
  finalSubjectsData<-rename(finalSubjectsData,subject=V1)
  
  finalSubjectsData
  
}

getActivities <- function() {
  
  
  #find activities dataset
  activityLabelsDataset <- read.table("UCI HAR Dataset/activity_labels.txt")
  
  trainingActivityData <- read.table("UCI HAR Dataset/train/Y_train.txt")
  testingActivityData <- read.table("UCI HAR Dataset/test/Y_test.txt" )
  mergedActivityData <- rbind(trainingActivityData, testingActivityData)
  
  # format the data set
  finalActivityData<-merge(mergedActivityData,activityLabelsDataset)
  finalActivityData<-select(finalActivityData,V2)
  finalActivityData<-rename(finalActivityData,activity=V2)
  
  finalActivityData
  
}

runAnalysis()