library(stringr)










# Clean Curse words
clean_curse <- function(df) {
    curse_words <- scan(file = './data/curse_words.txt', what = 'character', sep = '\n')
    output <- subset(df, !v %in% curse_words)
    curse_sub <- c('fuck','shit','cunt','nigger')
    for (each in curse_sub) {
        output <- subset(output, (! str_detect(string = v, pattern = each)))
    }
    output
}

ref_all2 <- read.table(file = './data/int_ref_all_n2.csv', 
                       header = TRUE, sep = '|', stringsAsFactors = FALSE)
ref_all2 <- clean_curse(ref_all2)




curse_sub <- c('fuck','shit','cunt','nigger')
curse_words <- scan(file = './data/curse_words.txt', what = 'character', sep = '\n')
ref_all2 <- read.table(file = './data/int_ref_all_n2.csv', 
                       header = TRUE, sep = '|', stringsAsFactors = FALSE)
nrow(ref_all2)
head(subset(ref_all2, v == 'fuck'))
ref_all2 <- subset(ref_all2, !v %in% curse_words)
nrow(ref_all2)
for (each in curse_sub) {
    ref_all2 <- subset(ref_all2, (! str_detect(string = v, pattern = each)))
}
ref_all2 <- subset(ref_all2, (! str_detect(string = v, pattern = 'fuck')) & 
                       (! str_detect(string = v, pattern = 'shit')))
nrow(ref_all2)
head(subset(ref_all2, ! str_detect(string = v, pattern = 'fuck')))








# Read data


news <- scan(file = './data/en_US.news.txt', what = 'character', sep = '\n')
blogs <- scan(file = './data/en_US.blogs.txt', what = 'character', sep = '\n')
twitter <- scan(file = './data/en_US.twitter.txt', what = 'character', sep = '\n', skipNul = TRUE)

length(news); length(blogs); length(twitter)








clean_corpus <- function(corpus) {
    output <- tolower(corpus)
    output <- str_replace_all(output, pattern = "'", replacement = "")
    output <- str_replace_all(output, pattern = "[^[:print:]]", replacement = "")
    output <- str_replace_all(output, pattern = "[^[:alpha:]|[:space:]]", replacement = "")
    
    output = str_split(output, pattern = "[[:space:]]")
    output
}




news_test <- scan(file = './data/en_US.news_subtest.txt', what = 'character', sep = '\n')
news_test <- tolower(news_test)
news_test <- str_replace_all(news_test, pattern = "'", replacement = "")
news_test <- str_replace_all(news_test, pattern = "[^[:print:]]", replacement = "")
news_test <- str_replace_all(news_test, pattern = "[^[:alpha:]|[:space:]]", replacement = "")
# news_test <- str_replace_all(news_test, pattern = "^ *", replacement = "")
news_test <- str_trim(news_test, side = 'both')
news_test <- str_replace_all(news_test, pattern = " {2,}", replacement = " ")
news_test <- str_split(news_test, pattern = "[[:space:]]")
news_test[2]

grep(pattern = "the", x = news_test)
length(grep(pattern = "the", x = news_test))
length(grep(pattern = "the", x = news))







shingle_set3 <- function(char_vector) {
    output <- data.frame(k1 = '', k2 = '', k3 = '', v = '')
    itr_len <- length(char_vector) - 3
    if (itr_len <= 0) return(output)
    for (i in c(1:itr_len)) {
        output <- rbind(output,
                        data.frame(k1 = char_vector[i],
                                   k2 = char_vector[i+1],
                                   k3 = char_vector[i+2],
                                   v = char_vector[i+3]))
    }
    output
}


agg_set3 <- function(corpus_list) {
    final_df <- data.frame()
    for (i in c(1:length(corpus_list))) {
        final_df <- rbind(final_df, shingle_set3(news_test[[i]]))
    }
    final_df$k1[final_df$k1 == ''] <- NA
    final_df$k2[final_df$k2 == ''] <- NA
    final_df$k3[final_df$k3 == ''] <- NA
    final_df$v[final_df$v == ''] <- NA
    final_df <- subset(final_df, complete.cases(final_df))
    final_df$count <- 1
    agg_df <- aggregate(count ~ k1 + k2 + k3 + v, data = final_df, FUN = sum)
    agg_df <- subset(agg_df, count > 1)
    agg_df
}





test_df <- data.frame()
test_df <- shingle_set3(news_test[[4]])
test_df <- rbind(test_df,
                 shingle_set3(news_test[[5]]))
test_df$k1[test_df$k1 == ''] <- NA
test_df$k2[test_df$k2 == ''] <- NA
test_df$k3[test_df$k3 == ''] <- NA
test_df$v[test_df$v == ''] <- NA
test_df <- subset(test_df, complete.cases(test_df))



length(news_test)
news_test[[7]]


# Notify when done running code
library(beepr)
library(audio)
while(TRUE){wait(beep(1))}



# Test: bind list vectors to make dataframe
test_corpus <- c('this','is','the','way','of','the','dragon','slayer')
len_bound <- length(test_corpus) - 2 + 1
test_corpus[3:5]
test_df <- data.frame(k1 = test_corpus[1:(len_bound + 0)],
                      v = test_corpus[2:(len_bound + 1)])

df1 <- data.frame(k1 = test_corpus[1:3], v = test_corpus[2:4], stringsAsFactors = FALSE)
df2 <- data.frame(k1 = test_corpus[2:4], v = test_corpus[3:5], stringsAsFactors = FALSE)
dflist <- list(df1, df2)
dfall <- rbind(dflist)




# Completed Test Cases
test_list <- shingle_set3(char_vector = c('1','2','3','b','5','6'))
test_list



testout <- list()
testout[[1]] <- c(1,2,3,4)
testout[[2]] <- c(2,3,4,5)
testout
testout <- data.frame(testout)

