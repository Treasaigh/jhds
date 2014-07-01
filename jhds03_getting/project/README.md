## Introduction

The principal file for this analysis is `run_analysis.R`, which takes the raw data from the
original dataset and outputs a tidy data set (`tidy_full.txt`) with only columns relating 
to the mean and standard deviation for each measure.  The script additionally produces a 
second tidy data set (`tidy_agg.txt`) that is an aggregation average of the measure data 
over all combinations of the dimenstions in the full tidy data output.


## Input
* <b>Dataset</b>: <a href='https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'>
'href=https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'</a>

* <b>Description</b>: (see CodeBook.md for further details on variables) The experiments 
have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. 
Each person performed six activities  wearing a smartphone (Samsung Galaxy S II) on the waist. 
Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 
3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded 
to label the data manually. The obtained dataset has been randomly partitioned into two sets, 
where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters 
and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). 
The sensor acceleration signal, which has gravitational and body motion components, was separated 
using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force 
is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency 
was used. From each window, a vector of features was obtained by calculating variables from the 
time and frequency domain. See 'features_info.txt' for more details. 

* <b>Input size</b>: the input data set consists of approx. 560 columns and 11,000 rows, mostly
numeric data on initial load.


* <b> Files in dataset</b>:
<ol>
<li>'features_info.txt': Shows information about the variables used on the feature vector.</li>
<li>'features.txt': List of all features.</li>
<li>'activity_labels.txt': Links the class labels with their activity name.</li>
<li>'train/X_train.txt': Training set.</li>
<li>'train/y_train.txt': Training labels.</li>
<li>'test/X_test.txt': Test set.</li>
<li>'test/y_test.txt': Test labels.</li>
</ol>

* <b> Files in dataset in both train and test versions</b>: Their descriptions are equivalent.
<ol>
<li>'train/subject_train.txt': Each row identifies the subject who performed the activity 
for each window sample. Its range is from 1 to 30. </li>
<li>'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the 
smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 
element vector. The same description applies for the 'total_acc_x_train.txt' and 
'total_acc_z_train.txt' files for the Y and Z axis. </li>
<li>'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained 
by subtracting the gravity from the total acceleration. </li>
<li>'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured 
by the gyroscope for each window sample. The units are radians/second. </li>
</ol>

* <b> Notes</b>:
<ol>
<li>Features are normalized and bounded within [-1,1].</li>
<li>Each feature vector is a row on the text file.</li>
</ol>



## Output
* <b>Output Dataset (`tidy_full.txt`)</b>:  accomplishes the following analytic objectives.
<ol>
<li>Merges the training and the test sets to create one data set.</li>
<li>Extracts only the measurements on the mean and standard deviation for each measurement.</li>
<li>Uses descriptive activity names to name the activities in the data set.</li>
<li>Appropriately labels the data set with descriptive variable names.</li>
</ol>

* <b>Output Dataset (`tidy_agg.txt`)</b>:  accomplishes the following analytic objective
in addition to the successful completion of the objectives above.
<ol>
<li>Creates a second, independent tidy data set with the average of each variable for 
each activity and each subject.</li>
</ol>
* <b> Format</b>: data is pipe delimited ('|') text flat files, one record per row, includes
a header row at the top, and uses quote marks to wrap strings.




