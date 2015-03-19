Getting and cleaning data
R script that merges training and test data sets to create one data set, extracts mean and standard deviation for each measurement, apply descriptive activity names and label the data set and finally creates an independent tidy data set with average of each variable for each activity and each subject

The code install the required packages and do the following:

1. Load activity labels and data column names

2. Extract mean and standard deviation

3. Process x_test, y_test, X_train, y_train and subject_test data

4. Extract mean and standard deviation for each measurement in test dataset

5. Load activity labels and column bind X_train and y_train as well as X_test and y_test data

6. Row bind training and test data

7. Apply mean to melted data set and write the data set into a new tidy text file

The data can be accessed from: http://archive.ics.uci.edu/ml/machine-learning-databases/00240/
