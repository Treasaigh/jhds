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


shingle_set1 <- function(char_vector) {
    itr_len <- length(char_vector) - 1
    if (itr_len <= 0) return(data.frame(k1 = '', v = '', stringsAsFactors = FALSE))
    output <- data.frame(k1 = char_vector[1:(itr_len + 0)],
                         v = char_vector[2:(itr_len + 1)],
                         stringsAsFactors = FALSE)
    output
}


agg_set1 <- function(corpus_list) {
    list_df <- lapply(corpus_list, shingle_set1)
    df_names <- names(list_df[[1]])
    list_full <- lapply(df_names, function(x) unlist(lapply(list_df, `[[`, x)))
    names(list_full) <- df_names
    final_df <- as.data.frame(list_full)
    final_df$k1[final_df$k1 == ''] <- NA
    final_df$v[final_df$v == ''] <- NA
    final_df <- subset(final_df, complete.cases(final_df))
    final_df$count <- 1
    agg_df <- aggregate(count ~ k1 + v, data = final_df, FUN = sum)
    agg_df <- subset(agg_df, count > 1)
    agg_df
}


news <- scan(file = './data/en_US.news.txt', what = 'character', sep = '\n')
ref_news1 <- clean_corpus(news)
ref_news1 <- agg_set1(ref_news1)
write.table(x = ref_news1,
            file = './data/int_ref_news_n1.csv',
            col.names = TRUE, row.names = FALSE, sep = '|')
rm(news)


blogs <- scan(file = './data/en_US.blogs.txt', what = 'character', sep = '\n')
ref_blogs1 <- clean_corpus(blogs)
ref_blogs1 <- agg_set1(ref_blogs1)
write.table(x = ref_blogs1,
            file = './data/int_ref_blogs_n1.csv',
            col.names = TRUE, row.names = FALSE, sep = '|')
rm(blogs)


twitter <- scan(file = './data/en_US.twitter.txt', what = 'character', sep = '\n', skipNul = TRUE)
ref_twitter1 <- clean_corpus(twitter)
ref_twitter1 <- agg_set1(ref_twitter1)
write.table(x = ref_twitter1,
            file = './data/int_ref_twitter_n1.csv',
            col.names = TRUE, row.names = FALSE, sep = '|')
rm(twitter)


ref_all_n1 <- rbind(ref_news1, ref_blogs1, ref_twitter1)
ref_all_n1 <- aggregate(count ~ k1 + v, data = ref_all_n1, FUN = sum)
ref_all_n1$probability <- (ref_all_n1$count / sum(ref_all_n1$count))
ref_all_n1 <- ref_all_n1[order(ref_all_n1$count, decreasing = TRUE),]
write.table(x = ref_all_n1,
            file = './data/int_ref_all_n1.csv',
            col.names = TRUE, row.names = FALSE, sep = '|')




