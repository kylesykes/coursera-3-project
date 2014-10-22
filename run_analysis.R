library(plyr)
library(dplyr)

# Sets WD
setwd('/Users/kylesykes/Dropbox/Coursera/Getting and Cleaning Data/Project/UCI HAR Dataset')
# First get and clean up feature names
features <- read.table("features.txt", header = FALSE)
features <- features[,2]
features <- gsub("^t","Time",features)
features <- gsub("^f","Frequency",features)
features <- gsub("Gyro","Gyroscopic",features)
features <- gsub("Acc","Acceleration",features)
features <- gsub("Mag","Magnitude",features)
features <- gsub("std","StandardDeviation",features)
features <- gsub("mean","Mean",features)
features <- gsub("meanfreq","MeanFrequency",features)

# Imports all the necessary data, rbinds together test/train data for X and Y and 
# renames columns to more meaningful things.
Xtest <- read.table('test/X_test.txt', header = FALSE)
Xtrain <- read.table('train/X_train.txt', header = FALSE)
Ytest <- read.table('test/y_test.txt', header = FALSE)
Ytrain <- read.table('train/y_train.txt', header = FALSE)
SubTest <- read.table('test/subject_test.txt', header = FALSE)
SubTrain <- read.table('train/subject_train.txt', header = FALSE)
Xdata <- rbind(Xtest,Xtrain)
colnames(Xdata) <- features
Ydata <- rbind(Ytest, Ytrain)
colnames(Ydata) <- c("Activity")
Sdata <- rbind(SubTest, SubTrain)
colnames(Sdata) <- c("Subject")
# Combines the above data sets Xdata and Ydata together (just tacks on the activity name for each observation)
data <- cbind(Sdata, Ydata, Xdata)

# Applying names to the entries in the Activity column
data[,"Activity"] <- factor(data[,"Activity"], levels = 1:6, labels = c('Walking','Walking Up stairs','Walking Down Stairs','Sitting','Standing','Laying'))

## Extract only columns with mean and std
# Find indices where they include "mean" or "std"
# and subset the data by those columns
data2 <- data[,gdata2rep('Mean\\(\\)|StandardDeviation\\(\\)|Activity|Subject',colnames(data))]

# Now summarise the statistics for each subject and activity using dplyr
df <- data2 %>% 
        group_by(Subject, Activity) %>%
        summarise_each(funs(mean))
  
# Write the resulting data frame to a table for review
write.table(df, 'cleaned/cleanedtable.txt', row.name = FALSE)




