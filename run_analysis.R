setwd("C:/Users/Himanshu/Desktop/CourseraRCleaningData/Project1")

#Downloading the data and unzipping it
if(!file.exists("data.zip"))
{
  urlPath <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(urlPath, "data.zip")
  
  unzip("data.zip",exdir=".")
  
}
#Loading the training data - feature, labels and subject
train<-read.table("./UCI HAR Dataset/train/X_train.txt")
train_labels<-read.table("./UCI HAR Dataset/train/y_train.txt", col.names = "activityLabel")
train_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = "Subject")

#Loading the test data - feature, labels and subject
test<-read.table("./UCI HAR Dataset/test/X_test.txt")
test_labels<-read.table("./UCI HAR Dataset/test/y_test.txt",col.names="activityLabel")
test_subject<-read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = "Subject")

#Loading the features name 
featureNames<-as.character(read.table("./UCI HAR Dataset/features.txt")$V2)

#Loading the Activity name
activityNames<-as.character(read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("activityLabel", "activityName"))[,2])

#Merging the datasets - features, labels and subjects
MergedData <- rbind(train,test)
MergedLabels<-rbind(train_labels,test_labels)
MergedSubject<-rbind(train_subject, test_subject)

#Getting descriptive name for activity labels
activityLabeltoDescription <- activityNames[MergedLabels$activityLabel]

# Adding the column headers to the Merged Data set
names(MergedData)<- featureNames

#Selecting  the features which have mean or standard deviation as measurement
measurements<-grep("(mean|std)\\(\\)" , names(MergedData))

#Subsetting the MergedData to include only mean and standard deviation features
MergedSubData <- MergedData[,measurements]

#Renaming the features name to be more descriptive and more readable 
# Substituting-  t = Time, f = Freq, mean to Mean , std to StdDev,
# Removing extra/redundant text "-", "Body" etc
names(MergedSubData) <- gsub("^t","Time",names(MergedSubData))
names(MergedSubData) <- gsub("f","Freq",names(MergedSubData))
names(MergedSubData) <- gsub("mean\\(\\)", "Mean",names(MergedSubData))
names(MergedSubData) <- gsub("std\\(\\)", "StdDev", names(MergedSubData))
names(MergedSubData) <- gsub("BodyBody","Body",names(MergedSubData))
names(MergedSubData) <- gsub("-","",names(MergedSubData))

#Checking the featurename are coming up correctly
#str(MergedSubData)


#Combining all the features to final merged data set
FinalMerge<-cbind(MergedSubData, Subject = MergedSubject$Subject, Activity = activityLabeltoDescription)

str(FinalMerge, list.len = 600)

library(dplyr)
DataAggregated<- group_by(FinalMerge, Subject, Activity)
summaryData <- summarise_each(DataAggregated,funs(mean))

names(summaryData)[-c(1,2)] <- paste("Mean_", names(summaryData)[-c(1,2)])

write.table(summaryData, "summaryData_Means.txt", row.names = FALSE)

test<-read.table("summaryData_Means.txt", header = TRUE)
