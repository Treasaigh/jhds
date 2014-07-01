# Load Masters
activity_labels <- read.table(file = './UCI HAR Dataset/activity_labels.txt',
                              header = FALSE,
                              col.names = c('activity_id', 'activity_desc'))

feature_labels <- read.table(file = './UCI HAR Dataset/features.txt',
                             header = FALSE,
                             sep = ' ',
                             col.names = c('feature_num', 'feature_name'))

keep_cols <- union(grep('mean()', feature_labels$feature_name),
                   grep('std()', feature_labels$feature_name))

# Load Test Data
subject_test <- read.table(file = './UCI HAR Dataset/test/subject_test.txt',
                           header = FALSE,
                           col.names = c('subject_id'))

activity_id_test <- read.table(file = './UCI HAR Dataset/test/y_test.txt',
                               header = FALSE,
                               col.names = c('activity_id'))
activity_id_test <- merge(x = activity_id_test, by.x = 'activity_id',
                          y = activity_labels, by.y = 'activity_id')

features_test <- read.fwf(file = './UCI HAR Dataset/test/X_test.txt',
                          header = FALSE,
                          widths = rep(16, times = 561),
                          buffersize = 100,
                          comment.char = '',
                          colClasses = c('numeric'))
names(features_test) <- feature_labels$feature_name
features_test <- features_test[,keep_cols]
full_test <- cbind(subject_test, activity_id_test, features_test)


# Load Train Data
subject_train <- read.table(file = './UCI HAR Dataset/train/subject_train.txt',
                            header = FALSE,
                            col.names = c('subject_id'))

activity_id_train <- read.table(file = './UCI HAR Dataset/train/y_train.txt',
                               header = FALSE,
                               col.names = c('activity_id'))
activity_id_train <- merge(x = activity_id_train, by.x = 'activity_id',
                           y = activity_labels, by.y = 'activity_id')

features_train <- read.fwf(file = './UCI HAR Dataset/train/X_train.txt',
                          header = FALSE,
                          widths = rep(16, times = 561),
                          buffersize = 100,
                          comment.char = '',
                          colClasses = c('numeric'))
names(features_train) <- feature_labels$feature_name
features_train <- features_train[,keep_cols]
full_train <- cbind(subject_train, activity_id_train, features_train)

# Combine & write out
full_data <- rbind(full_test, full_train)
write.table(x = full_data,
            file = 'tidy_full.txt',
            sep = '|',
            row.names = FALSE)


# Variable Aggregation
library(reshape2)
vars_id <- names(full_data)[c(1,3)]
vars_ms <- names(full_data)[4:82]
full_melt <- melt(data = full_data,
                  id.vars = vars_id, 
                  measure.vars = vars_ms)
full_cast <- dcast(full_melt, subject_id + activity_desc ~ variable, mean)
write.table(x = full_cast,
            file = 'tidy_agg.txt',
            sep = '|',
            row.names = FALSE)

