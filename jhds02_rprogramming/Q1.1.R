getwd()
test_data <- read.csv('hw1_data.csv')
head(test_data)
tail(test_data)
test_data[47,]
length(test_data$Ozone[is.na(test_data$Ozone)])
mean(test_data$Ozone[!is.na(test_data$Ozone)])
sub_test <- test_data[test_data$Ozone > 31 & test_data$Temp > 90,]
mean(sub_test$Solar.R[!is.na(sub_test$Solar.R)])
summary(sub_test$Solar.R)
summary(test_data$Temp[test_data$Month == 6])
summary(test_data$Ozone[test_data$Month == 5])









