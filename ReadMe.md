## Prepare tidy data from Human Activity Recognition Using Smartphones Data Set
- Description of dataset is available at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
- Raw dataset was taken from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The goal of the script "run_Analysis.R" is to prepare tidy data the can be used for later analysis. The script contains a series of functions and each function execute the following steps to prepare the tidy data:
- Test and Train data sets along with subject and activity identifiers are merged to create a single data set.
- Only the measurments on mean and standard deviation for each measurement are extracted.
- The variables or columns of the merged data set is further transformed into more human readable form.
- Finally the variable is further summarized by taking mean for each activity/subject pair.

The script is divided into six function definitions:
- readData : A generic function to read raw files.
- mergeAndLabel : Merges test and train raw measurment data files, extract only the measurements on the mean and standard deviation for each measurement and appropriately label each column with descriptive names.
- activities : Label activities id with descriptive names.
- subjects : Simply read subjects files.
- tidy : Merges tidied up measurment, activities and subjects data.
- tidy_mean : Returns tidy data set with the average of each variable for each activity and each subject.


The final data can be found in the "tidy_means.txt". A detailed description of variables can be found in "CodeBook.md".
