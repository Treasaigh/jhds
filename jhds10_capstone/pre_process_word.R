library(stringr)

clean_corpus <- function(corpus) {
    output <- tolower(corpus)
    output <- str_replace_all(output, pattern = "'", replacement = "")
    output <- str_replace_all(output, pattern = "[^[:print:]]", replacement = "")
    output <- str_replace_all(output, pattern = "[^[:alpha:] | [:space:]]", replacement = "")
    output <- str_trim(output, side = 'both')
    output <- str_replace_all(output, pattern = " {2,}", replacement = " ")
    output <- str_split(output, pattern = "[[:space:]]")
    output
}


word_count <- function(corpus_list) {
    output <- data.frame(word = unlist(corpus_list), stringsAsFactors = FALSE)
    output$count <- 1
    output <- aggregate(count ~ word, data = output, FUN = sum)
    output$word[output$word == ''] <- NA
    output <- subset(output, complete.cases(output))
    output <- output[order(output$count, decreasing = TRUE),]
    output$probability <- (output$count / sum(output$count))
    output
}



news <- scan(file = './data/en_US.news.txt', what = 'character', sep = '\n')
ref_news <- clean_corpus(news)
word_freq_news <- word_count(ref_news)
write.table(x = word_freq_news,
            file = './data/int_word_freq_news.csv',
            col.names = TRUE, row.names = FALSE, sep = '|')
rm(news, ref_news)


blogs <- scan(file = './data/en_US.blogs.txt', what = 'character', sep = '\n')
ref_blogs <- clean_corpus(blogs)
word_freq_blogs <- word_count(ref_blogs)
write.table(x = word_freq_blogs,
            file = './data/int_word_freq_blogs.csv',
            col.names = TRUE, row.names = FALSE, sep = '|')
rm(blogs, ref_blogs)


twitter <- scan(file = './data/en_US.twitter.txt', what = 'character', sep = '\n', skipNul = TRUE)
ref_twitter <- clean_corpus(twitter)
word_freq_twitter <- word_count(ref_twitter)
write.table(x = word_freq_twitter,
            file = './data/int_word_freq_twitter.csv',
            col.names = TRUE, row.names = FALSE, sep = '|')
rm(twitter, ref_twitter)


word_freq_all <- rbind(word_freq_news, word_freq_blogs, word_freq_twitter)
word_freq_all <- aggregate(count ~ word, data = word_freq_all, FUN = sum)
word_freq_all$probability <- (word_freq_all$count / sum(word_freq_all$count))
word_freq_all <- word_freq_all[order(word_freq_all$count, decreasing = TRUE),]
write.table(x = word_freq_all,
            file = './data/int_word_freq_all.csv',
            col.names = TRUE, row.names = FALSE, sep = '|')
#rm(word_freq_all, word_freq_news, word_freq_blogs, word_freq_twitter)



# Checks
sum(word_freq_news$probability)
sum(word_freq_blogs$probability)
sum(word_freq_twitter$probability)
sum(word_freq_all$probability)

# plot(word_freq_all$probability)


