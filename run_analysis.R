## R script that merges training and test data sets to create one data set, extracts mean and standard deviation for each measurement, apply descriptive activity names and label the data set and finally creates an independent tidy data set with average of each variable for each activity and each subject

if (!require("data.table")) {
    install.packages("data.table")
}

if (!require("reshape2")) {
    install.packages("reshape2")
}

require("data.table")
require("reshape2")

# Load activity labels
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]

# Load data column names
features <- read.table("./UCI HAR Dataset/features.txt")[,2]

# Extract mean and standard deviation
extract_features <- grepl("mean|std", features)

# Process x_test, y_test and subject_test data
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

names(X_test) = features

# Extract mean and standard deviation for each measurement in test dataset
X_test = X_test[,extract_features]

# Load activity labels
y_test[,2] = activity_labels[y_test[,1]]
names(y_test) = c("Activity_ID", "Activity_Label")
names(subject_test) = "subject"

# Bind test data
test_data <- cbind(as.data.table(subject_test), y_test, X_test)

# Process X_train, y_train and subject_train data
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")

subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

names(X_train) = features

# Extract mean and standard deviation for each measurement in training dataset
X_train = X_train[,extract_features]

# Load activity data
y_train[,2] = activity_labels[y_train[,1]]
names(y_train) = c("Activity_ID", "Activity_Label")
names(subject_train) = "subject"

# Bind training data
train_data <- cbind(as.data.table(subject_train), y_train, X_train)

# Merge training and test data
data = rbind(train_data, test_data)

id_labels   = c("subject", "Activity_ID", "Activity_Label")
data_labels = setdiff(colnames(data), id_labels)
melted_data      = melt(data, id = id_labels, measure.vars = data_labels)

# Apply mean to melted dataset
tidy_dataset   = dcast(melted_data, subject + Activity_Label ~ variable, mean)

write.table(tidy_dataset, file = "./UCI HAR Dataset/tidy_dataset.txt")