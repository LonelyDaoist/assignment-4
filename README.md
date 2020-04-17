Assignment \#4


This is the 4th assignment of the coursera data science specialisation
in which I do basic transformation on exercicing data collected from
Samsung smart watch.

## Getting Started

first clone this repo
```
git clone https://github.com/LonelyDaoist/assignment-4.git
```

when you first run the run_analysis script, you'll be asked whether you want to keep the current states, this is used to avoid unecessary computation and re-reading of the files which can be slow. type false.

here's what the script does:

* read the features, the training set, the testing set, the subject ids and the activities. Note that the columns are labeled with the features when reading them.

* Merge everything that has been read into one dataframe

* Extract only the mean and std of the measurments into a new dataframe

* Replace the activities id (integers from 1 to 6) by their actual labels (walking, laying, etc...) in the  dataframe of the previous step

* Group the previous dataframe using the subject and the activity columns

In the end the grouped dataframe is generated, it contains the average of the measurments for each subject for each activity.
