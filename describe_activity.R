describe_activity <- function(n) {
  activities <- read.table("UCI HAR Dataset/activity_labels.txt",
                          sep = " ")
  as.character(activities[n,"V2"])
}