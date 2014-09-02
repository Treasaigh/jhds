#  http://groupware.les.inf.puc-rio.br/har
url_train <- 'https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv'
url_test <- 'https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv'
download.file(url = url_train, destfile = 'data_train.csv')
download.file(url = url_test, destfile = 'data_test.csv')

pml_train <- read.csv(file = 'data_train.csv',
                      na.strings = c('NA','#DIV/0!',''))
pml_quiz <- read.csv(file = 'data_test.csv',
                     na.strings = c('NA','#DIV/0!',''))
for(i in c(8:ncol(pml_train)-1)) {
  pml_train[,i] = as.numeric(as.character(pml_train[,i]))
  pml_quiz[,i] = as.numeric(as.character(pml_quiz[,i]))
}

feature_index <- colnames(pml_train)
feature_index <- colnames(pml_train[colSums(is.na(pml_train)) == 0])
feature_index <- feature_index[-c(1:7)]
# feature_index <- feature_index[- length(feature_index)]




# EDA
head(pml_train[feature_index])
length(feature_index)
length(pml_train[,1])
sum(is.na(pml_train[,1]))
summary(pml_train[,1])
summary(pml_train$classe)

head(is.na(pml_train))
summary(is.na(pml_train))
table(pml_train$cvtd_timestamp)
pml_quiz$problem_id



library(caret)

# Time Test
set.seed(1301)
index_sample <- createDataPartition(y=pml_train$classe, p=0.75, list=FALSE)
data_sample <- pml_train[index_sample,]

mod_rf <- train(classe ~ ., data=data_sample, method='rf')
mod_lm <- train(classe ~ ., data=data_sample, method='lm')
mod_tree <- train(classe ~ ., data=data_sample, method='rpart')


# k-fold
set.seed(1300)
folds <- createFolds(y=pml_train$classe, k=10, list=TRUE, returnTrain=TRUE)
sapply(folds,length)



# Splitting
set.seed(1300)
index_train <- createDataPartition(y=pml_train$classe, p=0.10, list=FALSE)
data_train <- pml_train[index_train,feature_index]
data_xval <- pml_train[-index_train,feature_index]
dim(data_train); dim(data_xval)


# Pre-Model EDA
ggplot(aes(x=classe), data=data_train) +
    geom_histogram(fill='dark orange') +
    ggtitle('Histogram of Classe Frequency in Training Set') +
    xlab('Classe of Excercise') +
    ylab('Frequency in Training Data')


colnames(data_train)
preProcess(x = data_train[-53], method = 'pca', thresh = 0.95)


# Models - Original
mod_rf <- train(classe ~ ., data=data_train, method='rf') # Random Forest
mod_rf <- train(classe ~ ., data=data_train, method='rf', proximity=TRUE, preProcess='pca', thresh=0.95) # Random Forest
mod_tree <- train(classe ~ ., data=data_train, method='rpart') # Trees
mod_gbm <- train(classe ~ ., data=data_train, method='gbm', verbose=FALSE) # Gradient Boosting
mod_lda <- train(classe ~ ., data=data_train, method='lda') # Linear Discriminant Analysis
mod_nb <- train(classe ~ ., data=data_train, method='nb') # Naive Bayes

# Models - revamped
mod_rf <- train(classe ~ .,
                data=data_train, 
                method='rf', 
                trControl=trainControl(method="cv", 
                                       number=4, 
                                       allowParallel=TRUE, 
                                       verboseIter=TRUE)) # Random Forest
mod_tree <- train(classe ~ ., 
                  data=data_train, 
                  method='rpart',
                  trControl=trainControl(method="cv", 
                                         number=4, 
                                         allowParallel=TRUE, 
                                         verboseIter=TRUE)) # Trees
mod_gbm <- train(classe ~ ., 
                 data=data_train, 
                 method='gbm', 
                 verbose=FALSE,
                 trControl=trainControl(method="cv", 
                                        number=4, 
                                        allowParallel=TRUE, 
                                        verboseIter=TRUE)) # Gradient Boosting
mod_lda <- train(classe ~ ., 
                 data=data_train, 
                 method='lda',
                 trControl=trainControl(method="cv", 
                                        number=4, 
                                        allowParallel=TRUE, 
                                        verboseIter=TRUE)) # Linear Discriminant Analysis
mod_nb <- train(classe ~ ., 
                data=data_train, 
                method='nb',
                trControl=trainControl(method="cv", 
                                       number=4, 
                                       allowParallel=TRUE, 
                                       verboseIter=TRUE)) # Naive Bayes




# Predictions
pred_rf <- predict(mod_rf,data_xval)
cm_rf <- confusionMatrix(pred_rf,data_xval$classe)
cm_rf

summary(pred_rf)
plot(summary(pred_rf))
plot(summary(data_train$classe))
class(cm_rf$overall)
cm_rf$overall[1]
oos_error <- 1 - cm_rf$overall['Accuracy']
cm_rf$table


pred_tree <- predict(mod_tree,data_xval)
cm_tree <- confusionMatrix(pred_tree,data_xval$classe)
cm_tree$overall[1]

pred_gbm <- predict(mod_gbm,data_xval)
cm_gbm <- confusionMatrix(pred_gbm,data_xval$classe)
cm_gbm$overall[1]

pred_lda <- predict(mod_lda,data_xval)
cm_lda <- confusionMatrix(pred_lda,data_xval$classe)
cm_lda$overall[1]

pred_nb <- predict(mod_nb,data_xval)
cm_nb <- confusionMatrix(pred_nb,data_xval$classe)
cm_nb$overall[1]



# Compare Models
model_compare <- data.frame(Model = c('Random Forest',
                                      'Trees',
                                      'Gradient Boosting',
                                      'Linear Discriminant',
                                      'Naive Bayes'),
                            Accuracy = c(cm_rf$overall[1],
                                         cm_tree$overall[1],
                                         cm_gbm$overall[1],
                                         cm_lda$overall[1],
                                         cm_nb$overall[1]))

ggplot(aes(x=Model, y=Accuracy), data=model_compare) +
    geom_bar(stat='identity', fill = 'blue') +
    ggtitle('Comparative Accuracy of Models on Cross-Validation Data') +
    xlab('Models') +
    ylab('Overall Accuracy')


plot(cm_rf$table)
ggplot(data=data.frame(cm_rf$table)) + 
    geom_tile(aes(x=Reference, y=Prediction, fill=Freq)) +
    ggtitle('Prediction Accuracy for Classes in Cross-Validation (Random Forest Model)') +
    xlab('Actual Classe') +
    ylab('Predicted Classe from Model')
ggplot(data=data.frame(cm_tree$table)) + 
    geom_tile(aes(x=Reference, y=Prediction, fill=Freq)) +
    ggtitle('Prediction Accuracy for Classes in Cross-Validation (Decision Tree Model)') +
    xlab('Actual Classe') +
    ylab('Predicted Classe from Model')
cm_rf



# Apply to Quiz
final_col <- length(colnames(pml_quiz[]))
colnames(pml_quiz)[final_col] <- 'classe'
quiz_rf <- predict(mod_rf,pml_quiz[,feature_index])
quiz_rf

quiz_tree <- predict(mod_tree,pml_quiz[,feature_index])
quiz_gbm <- predict(mod_gbm,pml_quiz[,feature_index])
quiz_lda <- predict(mod_lda,pml_quiz[,feature_index])
quiz_nb <- predict(mod_nb,pml_quiz[,feature_index])




pml_write_files <- function(x){
    n = length(x)
    for(i in 1:n){
        filename = paste0("problem_id_",i,".txt")
        write.table(x[i],file=filename,quote=FALSE,row.names=FALSE,col.names=FALSE)
    }
}

pml_write_files(quiz_rf)



















