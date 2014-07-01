rankall <- function(outcome, num = 'best') {
    outcome_align <- data.frame(outcome_list = c('heart attack', 'heart failure', 'pneumonia'),
                                col_reference = c(11,17,23))
    outcome_care <- read.csv(file = 'outcome-of-care-measures.csv',
                             colClasses = 'character',
                             header = TRUE)
    if (!outcome %in% outcome_align$outcome_list) stop('invalid outcome')
    for (i in c(11,17,23)) {outcome_care[,i] <- as.numeric(outcome_care[,i])}
    col_align <- outcome_align[outcome_align$outcome_list == outcome,2]
    outcome_care <- subset(outcome_care, !is.na(outcome_care[,col_align]))
    
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
    output
}
