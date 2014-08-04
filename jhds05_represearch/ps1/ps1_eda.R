# https://github.com/frankdevans/RepData_PeerAssessment1
# Data: https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip

temp <- read.csv(file = 'activity.csv',
                 header = TRUE,
                 na.strings = 'NA')

temp$date <- as.Date(temp$date, '%Y-%m-%d')

names(temp)
summary(temp$steps)
summary(temp$date)
summary(temp$interval)

sum(is.na(temp$steps))
length(is.na(temp$steps))
sum(is.na(temp$steps)) / length(is.na(temp$steps))  # % missing



#########################################################################################
# Make connection to URL, download, unzip, and load into dataframe
file_url <- 'https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip'
temp <- tempfile()
download.file(file_url, temp)
activity <- read.csv(file = unz(temp,'activity.csv'),
                     header = TRUE,
                     na.strings = 'NA')
unlink(temp)



# Make connection to URL, download, unzip, and load into dataframe
file_url <- 'https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip'
setInternet2(TRUE)
download.file(file_url, 'activity.zip')
activity <- read.csv(file = unz('activity.zip','activity.csv'),
                     header = TRUE,
                     na.strings = 'NA')


activity$date <- as.Date(activity$date, '%Y-%m-%d')
activity <- activity[order(activity$date, activity$interval),]
act_nonnull <- subset(activity, !is.na(activity$steps))


# Mean steps per day
library(ggplot2)

g_steps_sum <- aggregate(x = act_nonnull$steps,
                         by = list(date = act_nonnull$date),
                         FUN = sum)
list(steps_mean = mean(g_steps_sum$x), steps_median = median(g_steps_sum$x))

steps_mean <- mean(g_steps_sum$x)
steps_median <- median(g_steps_sum$x)
steps_mean
steps_median
summary(g_steps_sum$x)
class(g_steps_sum)

ggplot(data = g_steps_sum, aes(x = x)) +
    geom_histogram(fill = 'navy', binwidth = 500) + 
    ggtitle('Histogram: Total Steps Taken Per Day') +
    xlab('Daily Average of Steps Taken') +
    ylab('Count of Days')


# Average Daily Activity Pattern
g_steps_mean <- aggregate(x = act_nonnull$steps,
                          by = list(time_interval = act_nonnull$interval),
                          FUN = mean)
head(g_steps_mean)

ggplot(data = g_steps_mean, aes(x = time_interval, y = x)) +
    geom_line(color = 'dark green', size = 1.1) +
    ggtitle('Daily Average Steps Taken Throughout Day (5 Minute Intervals)') +
    xlab('5 Minute Interval Throughout Day') +
    ylab('Daily Average of Steps Taken Each Interval')

max(g_steps_mean$x)
g_steps_mean[g_steps_mean$x == max(g_steps_mean$x),]  # whole DF row
g_steps_mean$time_interval[g_steps_mean$x == max(g_steps_mean$x)]  # time_interval only



# Imputing Missing Values
sum(is.na(activity$steps))

act_impute <- merge(x = activity, by.x = 'interval',
                    y = g_steps_mean, by.y = 'time_interval')
names(act_impute)[4] <- 'g_mean_steps'
names(act_impute)
class(act_impute$steps)
head(act_impute$steps)
sum(is.na(act_impute$steps))
act_impute$steps_impute <- as.numeric(act_impute$steps)
act_impute$steps_impute[is.na(act_impute$steps_impute)] <- act_impute$g_mean_steps[is.na(act_impute$steps_impute)]
head(act_impute$steps_impute)
sum(is.na(act_impute$steps_impute))

g_steps_sum_impute <- aggregate(x = act_impute$steps_impute,
                                by = list(date = act_impute$date),
                                FUN = sum)
steps_mean_impute <- mean(g_steps_sum_impute$x)
steps_median_impute <- median(g_steps_sum_impute$x)
steps_mean_impute
steps_median_impute

ggplot(data = g_steps_sum_impute, aes(x = x)) +
    geom_histogram(fill = 'blue', binwidth = 500) + 
    ggtitle('Histogram: Total Steps Taken Per Day (Missing Data Imputed)') +
    xlab('Daily Average of Steps Taken') +
    ylab('Count of Days')


# Weekday vs Weekend Patterns
act_impute$day_of_week <- weekdays(act_impute$date, abbreviate=TRUE)
unique(act_impute$day_of_week)
# act_impute$weekday <- act_impute$day_of_week %in% c('Mon','Tue','Wed','Thu','Fri')
length(act_impute$weekday[act_impute$weekday == FALSE])
ref_dow <- data.frame(day_of_week = c('Mon','Tue','Wed','Thu','Fri','Sat','Sun'),
                      dow_type = c('weekday','weekday','weekday','weekday','weekday','weekend','weekend'))
act_impute <- merge(x = act_impute, by.x = 'day_of_week',
                    y = ref_dow, by.y = 'day_of_week')

g_steps_mean_impute_wdwe <- aggregate(x = act_impute$steps_impute,
                                      by = list(interval = act_impute$interval, dow_type = act_impute$dow_type),
                                      FUN = mean)
unique(g_steps_sum_impute_wdwe$dow_type)

ggplot(data = g_steps_mean_impute_wdwe[g_steps_mean_impute_wdwe$dow_type == 'weekend',], aes(x = interval, y = x)) +
    geom_line(size = 1.1) +
    ggtitle('Daily Average Steps Taken Throughout Day (5 Minute Intervals)') +
    xlab('5 Minute Interval Throughout Day') +
    ylab('Daily Average of Steps Taken Each Interval')

ggplot(data = g_steps_mean_impute_wdwe, aes(x = interval, y = x)) +
    geom_line(color = 'dark orange', size = 1.1) + 
    facet_wrap( ~ dow_type, nrow = 2, ncol = 1) +
    ggtitle('Daily Average Steps Taken Throughout Day (5 Minute Intervals)') +
    xlab('5 Minute Intervals Throughout Day') +
    ylab('Daily Average of Steps Taken Each Interval')


























