library(dplyr)
library(reshape2)
library(xlsx)

#Downloading the file
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
temp <- tempfile()
download.file(fileUrl, temp)

#Reading activity labels and features
activities <- read.table(unz(temp, "UCI HAR Dataset/activity_labels.txt"),header= FALSE) 
features<- read.table(unz(temp, "UCI HAR Dataset/features.txt"))


#Reading Training Data from file
trainingSet <- read.table(unz(temp, "UCI HAR Dataset/train/X_train.txt"),header= FALSE)

trainingLabels <- read.table(unz(temp, "UCI HAR Dataset/train/y_train.txt"),header= FALSE )
trainingSubjects <- read.table(unz(temp, "UCI HAR Dataset/train/subject_train.txt"),header= FALSE)

#Reading Test Data from file
testSet <- read.table(unz(temp, "UCI HAR Dataset/test/X_test.txt"),header= FALSE)
testLabels <- read.table(unz(temp, "UCI HAR Dataset/test/y_test.txt"),header= FALSE)
testSubjects <- read.table(unz(temp, "UCI HAR Dataset/test/subject_test.txt"),header= FALSE)

unlink(temp)

#Subsetting features to contain the list of only those referring to mean and std
features <- features [grepl("(-mean[^a-zA-Z]|std)", features$V2),]

#Defining vector to select measurements from test and training sets
measurementVec <- features$V1

typeofData <- factor(c("Training", "Test"))


#Transforming TrainingDataSet

trainingSet <- trainingSet[,measurementVec]
names(trainingSet) <- features$V2
trainingLabels$V1 <- activities$V2[trainingLabels$V1]
typeColumn1 = rep(typeofData[1], n= nrow(trainingSet))

trainingSet<- cbind(subject = trainingSubjects$V1, dataType = typeColumn1, activity= trainingLabels$V1, trainingSet)


#Transforming TestSet
testSet <- testSet[,measurementVec]
names(testSet) <- features$V2
testLabels$V1 <- activities$V2[testLabels$V1]
typeColumn2 = rep(typeofData[2], n= nrow(trainingSet))
testSet<- cbind(subject = testSubjects$V1, dataType= typeColumn2, activity= testLabels$V1, testSet)

#Binding training and test datasets  to obtain final data set

finalDataSet <- rbind(trainingSet, testSet)



#outputting in csv file
write.table(finalDataSet, "myTidyDataSet1.txt", row.names = FALSE, quote = FALSE)



#To obtain the second tidy data set 
#(average for each value grouped by subject and by activity)
#We will melt the previous tidy data set to make it skinny
#then we will dcast it to show the subject and activity as variables
#and the averages as measurement values

meltedDF <- melt(finalDataSet, id =c("subject", "activity"), measure.vars= names(finalDataSet)[4:69])
secondTidyDF <- dcast(meltedDF, subject+activity ~ variable, mean)


#outputting csv file
write.table(secondTidyDF, "myTidyDataSet2.txt", row.names = FALSE, quote = FALSE)



                   









