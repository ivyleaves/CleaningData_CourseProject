# Tidy Dataset creation from the Human Activity Recognition Using Smartphones Dataset

## Below are the steps

+ 1. Test and Training set - features, labels, subjects were merged
+ 2. Feature name, descriptive label name and subjects were attached to the respective data set.
+ - a. The descriptive label name will help someone to see what activity is being in consideration
+ 3. The Mean and Standard deviation features are extracted from the merged data set for creating tiny data set
+ 4. The above mean and StdDev feature were further summarized for each subject and activity
+ 5. The final dataset in tidy format is summaryData_Means.txt
+ 6. The above dataset can be read by read.table("summaryData_Means.txt", header = TRUE)
+ 7. The feature definition and terminology are listed in codebook. 




