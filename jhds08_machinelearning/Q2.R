# Q1
library(AppliedPredictiveModeling)
library(caret)
data(AlzheimerDisease)

#
adData = data.frame(predictors)
trainIndex = createDataPartition(diagnosis,p=0.5,list=FALSE)
training = adData[trainIndex,]
testing = adData[-trainIndex,]

#
adData = data.frame(diagnosis,predictors)
testIndex = createDataPartition(diagnosis, p = 0.50,list=FALSE)
training = adData[-testIndex,]
testing = adData[testIndex,]

# 
adData = data.frame(diagnosis,predictors)
train = createDataPartition(diagnosis, p = 0.50,list=FALSE)
test = createDataPartition(diagnosis, p = 0.50,list=FALSE)

# No, wrong slicing
adData = data.frame(diagnosis,predictors)
trainIndex = createDataPartition(diagnosis,p=0.5,list=FALSE)
training = adData[trainIndex,]
testing = adData[trainIndex,]



# Q2
library(AppliedPredictiveModeling)
data(concrete)
library(caret)
set.seed(975)
inTrain = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]
training = mixtures[ inTrain,]
testing = mixtures[-inTrain,]
library(Hmisc)

plot(mixtures$CompressiveStrength,)
head(rownames(mixtures))

summary(mixtures$Age)
summary(cut2(mixtures$Age, g=8))
summary(mixtures$FlyAsh)

qplot(mixtures$Age)
qplot(mixtures$FlyAsh)

qplot(rownames(mixtures),mixtures$CompressiveStrength, color=mixtures$Age)
qplot(rownames(mixtures),mixtures$CompressiveStrength, color=cut2(mixtures$Age, g=8))
qplot(rownames(mixtures),mixtures$CompressiveStrength, color=mixtures$FlyAsh)
qplot(rownames(mixtures),mixtures$CompressiveStrength, color=cut2(mixtures$FlyAsh, g=8))


# Q3
library(AppliedPredictiveModeling)
data(concrete)
library(caret)
set.seed(975)
inTrain = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]
training = mixtures[ inTrain,]
testing = mixtures[-inTrain,]

qplot(mixtures$Superplasticizer)
summary(mixtures$Superplasticizer)
summary(log10(mixtures$Superplasticizer + 1))
qplot(log10(mixtures$Superplasticizer + 1))



# Q4
library(caret)
library(AppliedPredictiveModeling)
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

colnames(training)[1]
index_IL <- grep("^IL",colnames(training))
length(index_IL)
colnames(training)[index_IL]
pre_proc <- preProcess(x = training[,index_IL],
                       method = 'pca',
                       thresh = 0.9)
pre_proc


# Q5
library(caret)
library(AppliedPredictiveModeling)
set.seed(3433)
data(AlzheimerDisease)
index_IL <- grep("^IL",colnames(predictors))
adData = data.frame(diagnosis,predictors[,index_IL])
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

colnames(training)

pca_IL <- preProcess(x = training[,-1],
                     method = 'pca',
                     thresh = 0.8)
train_PCA <- predict(pca_IL, training[,-1])
fit_PCA <- train(training$diagnosis ~ ., method='glm', data=train_PCA)
test_PCA <- predict(pca_IL, testing[,-1])
confusionMatrix(testing$diagnosis, predict(fit_PCA, test_PCA))


fit_all <- train(training$diagnosis ~ ., method='glm', data=training)
confusionMatrix(testing$diagnosis, predict(fit_all))





















