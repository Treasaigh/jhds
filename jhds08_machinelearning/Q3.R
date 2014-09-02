# Q1
library(AppliedPredictiveModeling)
data(segmentationOriginal)
library(caret)








# Q3
library(pgmm)
data(olive)
olive = olive[,-1]

newdata = as.data.frame(t(colMeans(olive)))
newdata
summary(olive$Area)
table(olive$Area)



# Q4
library(ElemStatLearn)
data(SAheart)
set.seed(8484)
train = sample(1:dim(SAheart)[1],size=dim(SAheart)[1]/2,replace=F)
trainSA = SAheart[train,]
testSA = SAheart[-train,]

set.seed(13234)


missClass = function(values,prediction){sum(((prediction > 0.5)*1) != values)/length(values)}




# Q5
library(ElemStatLearn)
data(vowel.train)
data(vowel.test)

set.seed(33833)
















