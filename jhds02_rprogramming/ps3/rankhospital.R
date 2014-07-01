rankhospital <- function(state, outcome, num = 'best') {
    outcome_align <- data.frame(outcome_list = c('heart attack','heart failure','pneumonia'),
                                col_reference = c(11,17,23))
    outcome_care <- read.csv(file = 'outcome-of-care-measures.csv',
                             colClasses = 'character',
                             header = TRUE)
    if (!state %in% outcome_care$State) stop('invalid state')
    if (!outcome %in% outcome_align$outcome_list) stop('invalid outcome')
    for (i in c(11,17,23)) {outcome_care[,i] <- as.numeric(outcome_care[,i])}
    col_align <- outcome_align[outcome_align$outcome_list == outcome,2]
    outcome_care <- subset(outcome_care, State == state)
    outcome_care <- subset(outcome_care, !is.na(outcome_care[,col_align]))
    outcome_care <- outcome_care[order(outcome_care[,col_align], outcome_care$Hospital.Name),]
    
    if (num == 'best') num = 1
    if (num == 'worst') num = length(outcome_care$Hospital.Name)
    if (num > length(outcome_care$Hospital.Name)) return(NA)
    outcome_care$Hospital.Name[num]
}