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

q01n3 <- subset(ref_all3, k1 == 'live' & k2 == 'and' & k3 == 'id')
q01n2 <- subset(ref_all2, k1 == 'and' & k2 == 'id')
q01n2_v <- subset(ref_all2, k1 == 'and' & k2 == 'id' &
                    v %in% c('sleep','give','die','eat'))

q02n3 <- subset(ref_all3, k1 == 'me' & k2 == 'about' & k3 == 'his')
q02n2 <- subset(ref_all2, k1 == 'about' & k2 == 'his')
q02n2_v <- subset(ref_all2, k1 == 'about' & k2 == 'his' &
                    v %in% c('financial','spiritual','marital','horticultural'))

q03n2 <- subset(ref_all2, k2 == 'this' &
                  v %in% c('weekend','month','decade','morning'))
q03n1 <- subset(ref_all1, k1 == 'this' &
                  v %in% c('weekend','month','decade','morning'))

q04n3 <- subset(ref_all3, k1 == 'helps' & k2 == 'reduce' & k3 == 'your')
q04n3 <- subset(ref_all3, k1 == 'help' & k2 == 'reduce')
q04n2 <- subset(ref_all2, k1 == 'reduce' & k2 == 'your')

q05n3 <- subset(ref_all3, k1 == 'to' & k2 == 'take' & k3 == 'a')

q06n3 <- subset(ref_all3, k1 == 'to' & k2 == 'settle' & k3 == 'the')

q07n3 <- subset(ref_all3, k1 == 'groceries' & k2 == 'in' & k3 == 'each')
q07n2 <- subset(ref_all2, k1 == 'in' & k2 == 'each')
q07n2_v <- subset(ref_all2, k1 == 'in' & k2 == 'each' &
                    v %in% c('finger','toe','hand','arm'))

q08n3 <- subset(ref_all3, k1 == 'bottom' & k2 == 'to' & k3 == 'the')

q09n3 <- subset(ref_all3, k1 == 'bruises' & k2 == 'from' & k3 == 'playing')
q09n2 <- subset(ref_all2, k1 == 'from' & k2 == 'playing')
q09n1 <- subset(ref_all1, k1 == 'playing' &
                  v %in% c('outside','weekly','inside','daily'))





















