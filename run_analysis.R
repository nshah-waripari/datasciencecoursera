
## read the raw data files as is
readData <- function(file_path){
        data_set <- read.table(file_path)
}

## merge & label train and test X datasets
mergeAndLabel <- function(train_data, test_data, data_features){
        ## read train and test data fron tge given path
        x_train <- readData(train_data)
        x_test <- readData(test_data)
        # merge train and test data
        merged_data <- rbind(x_train, x_test)
        
        # read features list from features.txt file
        x_features <- readData(data_features)
        # create a char array of features names
        x_feature_label <- as.vector(x_features[, 2])
        # apply the label
        names(merged_data) <- x_feature_label
        # extract only the measurements on the mean and standard deviation for each measurement
        sub <- merged_data[,grepl("(mean\\(\\)|std\\(\\))", names(merged_data))]
        
        # appropriately label each column with descriptive names
        names(sub) <- gsub("^t", "Time", names(sub))
        names(sub) <- gsub("^f", "Frequency", names(sub))
        names(sub) <- gsub("-mean\\(\\)", "Mean", names(sub))
        names(sub) <- gsub("-std\\(\\)", "StdDev", names(sub))
        names(sub) <- gsub("-", "", names(sub))
        names(sub) <- gsub("BodyBody", "Body", names(sub))
        sub
}

activities <- function(y_train_data, y_test_data){
        # read activities train and test data
        y_train <- readData(y_train_data)
        y_test  <- readData(y_test_data)
        y_merged <- rbind(y_train, y_test)[, 1]
        
        # activities descriptive names lookup
        activityNames <-
                c("Walking", "Walking Upstairs", "Walking Downstairs", "Sitting", "Standing", "Laying")
        # transform activities id  to description
        activities <- activityNames[y_merged]
}

subjects <- function(subject_train_data, subject_test_data){
        # read subject train and test data
        subject_train <- readData(subject_train_data)
        subject_test  <- readData(subject_test_data)
        subject_merged <- rbind(subject_train, subject_test)[, 1]

}

# main function to return tidy data
tidy <- function(){
        # cleaned-up measurement data
        merged_data <- mergeAndLabel("./UCI HAR Dataset/train/X_train.txt", "./UCI HAR Dataset/test/X_test.txt", "./UCI HAR Dataset/features.txt")
        # activities data
        activities_data <- activities("./UCI HAR Dataset/train/y_train.txt", "./UCI HAR Dataset/test/y_test.txt")
        # subject data
        subjects_data <- subjects("./UCI HAR Dataset/train/subject_train.txt", "./UCI HAR Dataset/test/subject_test.txt")
        # combine them together for our final tidy data
        tidy <- cbind(Subject = subjects_data, Activity = activities_data, merged_data)
        
        
}

# independent tidy data set with the average of each variable for each activity and each subject
tidy_mean <- function(){
        library(dplyr)
        tidy_means <- tidy() %>% group_by(Subject, Activity) %>% summarise_each(funs(mean))
        names(tidy_means)[-c(1,2)] <- paste0("Mean", names(tidy_means)[-c(1,2)])
        # write to a file
        write.table(tidy_means, "tidy_means.txt", row.names = FALSE)
        tidy_means
        
}
        

