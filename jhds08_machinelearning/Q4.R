# Q1
library(caret)
library(ElemStatLearn)
data(vowel.train)
data(vowel.test) 

vowel.train$y <- as.factor(vowel.train$y)
vowel.test$y <- as.factor(vowel.test$y)
set.seed(33833)

#mod_rf <- train(y ~ ., data=vowel.train, method='rf', trControl = trainControl(method='cv'), number=3)

mod_rf <- train(y ~ ., data=vowel.train, method='rf')
pred_rf <- predict(mod_rf, vowel.test)
cm_rf <- confusionMatrix(pred_rf, vowel.test$y)

mod_gbm <- train(y ~ ., data=vowel.train, method='gbm', verbose=FALSE)
pred_gbm <- predict(mod_gbm, vowel.test)
cm_gbm <- confusionMatrix(pred_gbm, vowel.test$y)

df_ens <- data.frame(pred_rf, pred_gbm, y = vowel.test$y)
mod_ens <- train(y ~ ., data=df_ens, method='gam')
pred_ens <- predict(mod_ens, df_ens)
cm_ens <- confusionMatrix(pred_ens, vowel.test$y)

cm_rf$overall['Accuracy']
cm_gbm$overall['Accuracy']
cm_ens$overall['Accuracy']



# Q2
library(caret)
library(gbm)
set.seed(3433)
library(AppliedPredictiveModeling)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

set.seed(62433)
mod_rf <- train(diagnosis ~ ., data=training, method='rf')
mod_gbm <- train(diagnosis ~ ., data=training, method='gbm', verbose=FALSE)
mod_lda <- train(diagnosis ~ ., data=training, method='lda')

pred_rf <- predict(mod_rf, testing)
pred_gbm <- predict(mod_gbm, testing)
pred_lda <- predict(mod_lda, testing)

cm_rf <- confusionMatrix(pred_rf, testing$diagnosis)
cm_gbm <- confusionMatrix(pred_gbm, testing$diagnosis)
cm_lda <- confusionMatrix(pred_lda, testing$diagnosis)

df_ens <- data.frame(pred_rf, pred_gbm, pred_lda, diagnosis = testing$diagnosis)
mod_ens <- train(diagnosis ~ ., data=df_ens, method='rf')
pred_ens <- predict(mod_ens, df_ens)
cm_ens <- confusionMatrix(pred_ens, df_ens$diagnosis)


cm_rf$overall['Accuracy']
cm_gbm$overall['Accuracy']
cm_lda$overall['Accuracy']
cm_ens$overall['Accuracy']



# Q3
set.seed(3523)
library(AppliedPredictiveModeling)
data(concrete)
inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training = concrete[ inTrain,]
testing = concrete[-inTrain,]

set.seed(233)
mod_las <- train(CompressiveStrength ~ ., data=training, model='lasso')
pred_las <- predict(mod_las, testing)
plot(mod_las)
plot(x = mod_las, xvar=c('fraction','penalty','L1norm'), use.color=FALSE)











# Q4
data_url <- 'https://d396qusza40orc.cloudfront.net/predmachlearn/gaData.csv'
library(lubridate)  # For year() function below
dat = read.csv("~/Desktop/gaData.csv")
training = dat[year(dat$date) < 2012,]
testing = dat[(year(dat$date)) > 2011,]
tstrain = ts(training$visitsTumblr)






# Q5
set.seed(3523)
library(AppliedPredictiveModeling)
data(concrete)
inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training = concrete[ inTrain,]
testing = concrete[-inTrain,]

set.seed(325)
mod_svm <- train(CompressiveStrength ~ ., data=training, model='svm')
pred_svm <- predict(mod_svm, testing)
sqrt(sum((pred_svm - testing$CompressiveStrength)^2))
sqrt(mean((pred_svm - testing$CompressiveStrength)^2))
























