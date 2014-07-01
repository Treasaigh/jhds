# Grader
source("http://d396qusza40orc.cloudfront.net/rprog%2Fscripts%2Fsubmitscript3.R")
submit()

# ID: 3497981
# Course: rprog-004
#PW: nAQAWaMnb2


# EDA Scratch: best
setwd("~/Dropbox/Education/JHDS 2 - R Programming/ps3")

state <- 'TX'
outcome <- 'heart attack'
outcome_align <- data.frame(outcome_list = c('heart attack', 'heart failure', 'pneumonia'),
                            col_reference = c(11,17,23))
outcome_care <- read.csv(file = 'outcome-of-care-measures.csv',
                         colClasses = 'character',
                         header = TRUE)
if (!state %in% outcome_care$State) stop('invalid state')
if (!outcome %in% outcome_align$outcome_list) stop('invalid outcome')
for (i in c(11,17,23)) {outcome_care[,i] <- as.numeric(outcome_care[,i])}
outcome_care <- subset(outcome_care, State == state)

col_align <- outcome_align[outcome_align$outcome_list == outcome,2]
summary(outcome_care[,col_align])
head(outcome_care[order(outcome_care[,col_align]),col_align])
outcome_care <- outcome_care[order(outcome_care[,col_align], outcome_care$Hospital.Name),]
head(outcome_care[,col_align])
head(outcome_care$Hospital.Name)
outcome_care$Hospital.Name[1]


# personal test cases
best('TX','heart failure')
best('TX','something')
best('TO','heart failure')
best('AA','hlure')

# Assignment Test Cases
best("TX", "heart attack")
best("TX", "heart failure")
best("MD", "heart attack")
best("MD", "pneumonia")




# EDA Scratch: rankhospital
state <- 'TX'
outcome <- 'heart failure'
num = 4
outcome_align <- data.frame(outcome_list = c('heart attack', 'heart failure', 'pneumonia'),
                            col_reference = c(11,17,23))
outcome_care <- read.csv(file = 'outcome-of-care-measures.csv',
                         colClasses = 'character',
                         header = TRUE)
if (!state %in% outcome_care$State) stop('invalid state')
if (!outcome %in% outcome_align$outcome_list) stop('invalid outcome')
for (i in c(11,17,23)) {outcome_care[,i] <- as.numeric(outcome_care[,i])}
col_align <- outcome_align[outcome_align$outcome_list == outcome,2]
outcome_care <- subset(outcome_care, State == state)


if (num == 'best') num = 1
if (num == 'worst') num = length(outcome_care$Hospital.Name)
if (num > length(outcome_care$Hospital.Name)) print NA

outcome_care$Hospital.Name[num]




# Tests: assignment
rankhospital("TX", "heart failure", 4)
rankhospital("MD", "heart attack", "worst")
rankhospital("MN", "heart attack", 5000)




# EDA scratch: rankall
outcome <- 'heart attack'
num = 'best'
outcome_align <- data.frame(outcome_list = c('heart attack', 'heart failure', 'pneumonia'),
                            col_reference = c(11,17,23))
outcome_care <- read.csv(file = 'outcome-of-care-measures.csv',
                         colClasses = 'character',
                         header = TRUE)
if (!outcome %in% outcome_align$outcome_list) stop('invalid outcome')
for (i in c(11,17,23)) {outcome_care[,i] <- as.numeric(outcome_care[,i])}
col_align <- outcome_align[outcome_align$outcome_list == outcome,2]
outcome_care <- subset(outcome_care, !is.na(outcome_care[,col_align]))
#outcome_care <- outcome_care[order(outcome_care[,col_align], outcome_care$Hospital.Name),]

output <- data.frame()
for (t in unique(outcome_care$State)) {
    outcome_temp <- subset(outcome_care, State == t)
    outcome_temp <- outcome_temp[order(outcome_temp[,col_align], outcome_temp$Hospital.Name),]
    if (num == 'best') num_index = 1
    if (num == 'worst') num_index = length(outcome_temp$Hospital.Name)
    if (is.numeric(num)) num_index <- num
    if ((is.numeric(num)) & (num > length(outcome_temp$Hospital.Name))) {
        output_temp <- data.frame(NA,t)
    } else {
        output_temp <- outcome_temp[num_index,c(2,7)]
    }
    names(output_temp) <- c('hospital','state')
    output <- rbind(output, output_temp)
}
names(output) <- c('hospital','state')
output <- output[order(output$state),]
head(output)








test_df <- data.frame()
test_df2 <- data.frame(n=c(1,2), m=c('t','f'))
test_df <- rbind(test_df, test_df2)


# Tests: assignment
head(rankall("heart attack", 20), 10)
tail(rankall("pneumonia", "worst"), 3)
tail(rankall("heart failure"), 10)






# Plot
outcome <- read.csv(file = 'outcome-of-care-measures.csv',
                    colClasses = 'character',
                    header = TRUE)
ncol(outcome)
nrow(outcome)
names(outcome)
outcome[,11] <- as.numeric(outcome[,11])
hist(outcome[,11])
summary(outcome[,11])

















