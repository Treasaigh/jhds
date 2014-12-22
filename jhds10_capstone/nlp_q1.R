library(stringr)

clean_curse <- function(df) {
    curse_words <- scan(file = './data/curse_words.txt', what = 'character', sep = '\n')
    output <- subset(df, !v %in% curse_words)
    curse_sub <- c('fuck','shit','cunt','nigger')
    for (each in curse_sub) {
        output <- subset(output, (! str_detect(string = v, pattern = each)))
    }
    output
}


# Load int ref docs
ref_all1 <- read.table(file = './data/int_ref_all_n1.csv', 
                       header = TRUE, sep = '|', stringsAsFactors = FALSE)
ref_all1 <- clean_curse(ref_all1)


ref_all2 <- read.table(file = './data/int_ref_all_n2.csv', 
                       header = TRUE, sep = '|', stringsAsFactors = FALSE)
ref_all2 <- clean_curse(ref_all2)


ref_all3 <- read.table(file = './data/int_ref_all_n3.csv', 
                       header = TRUE, sep = '|', stringsAsFactors = FALSE)
ref_all3 <- clean_curse(ref_all3)


ref_wf_all <- read.table(file = './data/int_word_freq_all.csv', 
                         header = TRUE, sep = '|', stringsAsFactors = FALSE)
ref_wf_all <- clean_curse(ref_wf_all)



# Query for Quiz Questions
q1n3 <- subset(ref_all3, k1 == 'a' & k2 == 'case' & k3 == 'of')

q2n3 <- subset(ref_all3, k1 == 'would' & k2 == 'mean' & k3 == 'the')

q3n3 <- subset(ref_all3, k1 == 'make' & k2 == 'me' & k3 == 'the')

q4n3 <- subset(ref_all3, k1 == 'struggling' & k2 == 'but' & k3 == 'the')
q4n2 <- subset(ref_all2, k1 == 'but' & k2 == 'the')
q4n2_v <- subset(ref_all2, k1 == 'but' & k2 == 'the' & v %in% c('defense','players','crowd','referees'))

q5n3 <- subset(ref_all3, k1 == 'date' & k2 == 'at' & k3 == 'the')
q5n2 <- subset(ref_all2, k1 == 'at' & k2 == 'the')
q5n2_v <- subset(ref_all2, k1 == 'at' & k2 == 'the' & v %in% c('mall','beach','movies','grocery'))

q6n3 <- subset(ref_all3, k1 == 'be' & k2 == 'on' & k3 == 'my')

q7n3 <- subset(ref_all3, k1 == 'in' & k2 == 'quite' & k3 == 'some')

q8n3 <- subset(ref_all3, k1 == 'with' & k2 == 'his' & k3 == 'little')
q8n2 <- subset(ref_all2, k1 == 'his' & k2 == 'little')
q8n2_v <- subset(ref_all2, k1 == 'his' & k2 == 'little' & v %in% c('ears','eyes','toes','fingers'))

q9n3 <- subset(ref_all3, k1 == 'faith' & k2 == 'during' & k3 == 'the')
q9n2 <- subset(ref_all2, k1 == 'during' & k2 == 'the')

q10n3 <- subset(ref_all3, k1 == 'you' & k2 == 'must' & k3 == 'be')
q10n3_v <- subset(ref_all3, k1 == 'you' & k2 == 'must' & k3 == 'be' & v %in% c('asleep','insensitive','callous','insane'))
q10n2_v <- subset(ref_all2, k1 == 'must' & k2 == 'be' & v %in% c('asleep','insensitive','callous','insane'))

























