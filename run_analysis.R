source('~/assignment#4/rename_feature.R')
source('~/assignment#4/describe_activity.R')

## Reading the data and assigning descriptive variable names
if (!exists("features")) {
  features <- readLines("UCI HAR Dataset/features.txt")
  features <- unlist(lapply(X = features, FUN = rename_feature))
}

if (!exists("train.x")) {
  train.x <- read.table("UCI HAR Dataset/train/X_train.txt",
                        col.names = features)
}

if (!exists("test.x")) {  
  test.x <- read.table("UCI HAR Dataset/test/X_test.txt",
                       col.names = features)
}

if (!exists("train.y")) {
  train.y <- read.table("UCI HAR Dataset/train/y_train.txt",
                        col.names = c("activity"))
}

if (!exists("test.y")) {  
  test.y <- read.table("UCI HAR Dataset/test/y_test.txt",
                       col.names = c("activity"))
}

if (!exists("train.subject")) {
  train.subject <- read.table("UCI HAR Dataset/train/subject_train.txt",
                        col.names = c("subject"))
}

if (!exists("test.subject")) {  
  test.subject <- read.table("UCI HAR Dataset/test/subject_test.txt",
                       col.names = c("subject"))
}

## Merging the train and test sets

if (!exists("dataset")) {
  dataset <- rbind(cbind(train.subject,train.x,train.y),cbind(test.subject,test.x,test.y))
}

## Extracting mean and std from each measurment

mean_std_features <- grep("mean|std",features)
mean_std_dataset <- dataset[,mean_std_features]

## Describing the activities
  
dataset$activity <- c(sapply(dataset$activity,describe_activity))

## Grouping means by activity and subject

grouped_means <- aggregate(dataset,list(dataset$subject,dataset$activity), mean)
