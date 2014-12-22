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


# hangout tip: map strings to integers to make more efficient


# Subset
n_rows <- 500000
ref_list <- list(n1 = ref_all1[1:n_rows,],
                 n2 = ref_all2[1:n_rows,],
                 n3 = ref_all3[1:n_rows,],
                 wf = ref_wf_all[2:25,])
save(ref_list, file = './data/app_data_ref.RData')






