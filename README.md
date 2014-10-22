The first step was to read in the variables from "features.txt" and clean them up.  I performed the following replacements:

t -> Time
f -> Frequency
Gyro -> Gyroscopic
Acc -> Acceleration
Mag -> Magnitude
std -> StandardDeviation
mean -> Mean
meanfreq -> MeanFrequency

I chose to do this step first because then after importing my data sets, I can relabel the columns immediately into meaninigful labels.

The second step was to read in the Xtrain, Xtest, Ytrain, Ytest data, and subject labels.  Then I added the rows of each test set (X and Y) together to a data frame for X, Y, and Subject data.  Then I renamed the columns to meaningful names per the above conventions, and labeled the Subject column "Subject" and the Activity column as "Activity".  Finally then I combined the rows of all three data sets together (since each had the same number of observations).

Before filtering out the columns involving mean and std, I applied labels to the factors in the Activity column to make them more readable.  Then I subsetted by columns containing mean and std (along with the Subject and Activity column).

Finally, now that we only have the columns we're interested in we use the dplyr package to group the results by Subject and Activity, and then summarise for each grouping by taking the mean of each variable (column).  This results in there being 6 rows for each subject, one for each activity, and the mean of each column for that particular grouping.

Finally, we simply write the data frame back out to a .txt file in a tidy format.
