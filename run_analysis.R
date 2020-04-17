source('~/assignment#4/rename_feature.R')
source('~/assignment#4/describe_activity.R')

## To avoid rereading files and redoing unecessary computations,
## each one will have its own "done state" which when set to false,
## the script will assume it hasn't been done and redo it.
## set keep to true if you dont want to change the states
keep <- readline("Would you like to keep the current state (true/false): ")
keep <- as.logical(keep)

if (!keep) {
  doneStates <- list(
    features = F,
    train.x = F,
    test.x = F,
    train.y = F,
    test.y = F,
    train.subject = F,
    test.subject = F,
    dataset = F,
    extract = F,
    describe = F
    )
}

## Reading the data and assigning descriptive variable names
if (!doneStates$features) {
  features <- readLines("UCI HAR Dataset/features.txt")
  features <- unlist(lapply(X = features, FUN = rename_feature))
}

if (!doneStates$train.x) {
  train.x <- read.table("UCI HAR Dataset/train/X_train.txt",
                        col.names = features)
}

if (!doneStates$test.x) {  
  test.x <- read.table("UCI HAR Dataset/test/X_test.txt",
                       col.names = features)
}

if (!doneStates$train.y) {
  train.y <- read.table("UCI HAR Dataset/train/y_train.txt",
                        col.names = c("activity"))
}

if (!doneStates$test.y) {  
  test.y <- read.table("UCI HAR Dataset/test/y_test.txt",
                       col.names = c("activity"))
}

if (!doneStates$train.subject) {
  train.subject <- read.table("UCI HAR Dataset/train/subject_train.txt",
                        col.names = c("subject"))
}

if (!doneStates$test.subject) {  
  test.subject <- read.table("UCI HAR Dataset/test/subject_test.txt",
                       col.names = c("subject"))
}

## Merging the train and test sets

if (!doneStates$dataset) {
  dataset <- rbind(cbind(train.subject,train.y,train.x),cbind(test.subject,test.y,test.x))
}

## Extracting mean and std from each measurment

if (!doneStates$extract) {
  mean_std_features <- grep("mean[^F]|std",names(dataset))
  dataset <- dataset[,c(1,2,mean_std_features)]
}

## Please note that the dataset was labeled while reading it
## using the argument: col.names

## Describing the activities
if (!doneStates$describe) {
  dataset$activity <- c(sapply(dataset$activity,describe_activity))
}

## Grouping means by activity and subject

grouped_means <- aggregate(dataset[,c(-1,-2)],list(dataset$subject,dataset$activity), mean)
names(grouped_means)[names(grouped_means)=="Group.1"] <- "subject"
names(grouped_means)[names(grouped_means)=="Group.2"] <- "activity"