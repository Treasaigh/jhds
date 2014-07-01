## Code Book: variables in data output
### Dimensions
* subject_id (integer numeric): identifier of which of the 30 volunteers the data line represents
* activity_id (integer numeric): identifier of which activity was being performed
* activity_desc (factor string): description of the activity being performed.

### Measures
(From original dataset description) The features selected for this database come from the accelerometer 
and gyroscope 3-axial raw signals.  The signals were sampled at a rate of 50Hz and subsequently filtered
and smoothed to remove noise.  Then the signals were transformed and 3D models were used to determine
velocity and acceleration.  Further details on the data, its transformations, and full range of captured
features can be located in the `features_info.txt' file found with the raw data set.

<b>All measures floating point numeric, and have been normalized and bound within -1 to +1.</b>
* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

<b>The set of variables that were estimated from these signals are:</b>

* mean(): Mean value
* std(): Standard deviation

(Additional variable sets are available in the original raw dataset, this set has been specifically
reduced to these two variable sets intentionally for this tidy data set.)


## Summary Choices
* <b> Mean and Standard Deviation</b>: feature variables have been reduced to only show those variables
where the mean and standard deviation were computed from raw sensor data.  All other feature data was
filtered out of the data output of this analysis.
* <b> Aggregated Data Set</b>: there is additionally included in this output an aggregated data set that
provides the mean average for each factor in the full data set, aggregated for all unique values of
subject_id and activity_desc.

## Study Design
Data was accessed via: <a href='https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'>
'href=https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'</a>.  Original
data collection and study design information for the raw data originally collected can by found in the 
`README.txt` file found in the original raw dataset.


