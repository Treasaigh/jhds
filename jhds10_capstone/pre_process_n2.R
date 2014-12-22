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


shingle_set2 <- function(char_vector) {
    itr_len <- length(char_vector) - 2
    if (itr_len <= 0) return(data.frame(k1 = '', k2 = '', v = '', stringsAsFactors = FALSE))
    output <- data.frame(k1 = char_vector[1:(itr_len + 0)],
                         k2 = char_vector[2:(itr_len + 1)],
                         v = char_vector[3:(itr_len + 2)],
                         stringsAsFactors = FALSE)
    output
}


agg_set2 <- function(corpus_list) {
    list_df <- lapply(corpus_list, shingle_set2)
    df_names <- names(list_df[[1]])
    list_full <- lapply(df_names, function(x) unlist(lapply(list_df, `[[`, x)))
    names(list_full) <- df_names
    final_df <- as.data.frame(list_full)
    final_df$k1[final_df$k1 == ''] <- NA
    final_df$k2[final_df$k2 == ''] <- NA
    final_df$v[final_df$v == ''] <- NA
    final_df <- subset(final_df, complete.cases(final_df))
    final_df$count <- 1
    agg_df <- aggregate(count ~ k1 + k2 + v, data = final_df, FUN = sum)
    agg_df <- subset(agg_df, count > 1)
    agg_df
}


news <- scan(file = './data/en_US.news.txt', what = 'character', sep = '\n')
ref_news2 <- clean_corpus(news)
ref_news2 <- agg_set2(ref_news2)
write.table(x = ref_news2,
            file = './data/int_ref_news_n2.csv',
            col.names = TRUE, row.names = FALSE, sep = '|')
rm(news)


blogs <- scan(file = './data/en_US.blogs.txt', what = 'character', sep = '\n')
ref_blogs2 <- clean_corpus(blogs)
ref_blogs2 <- agg_set2(ref_blogs2)
write.table(x = ref_blogs2,
            file = './data/int_ref_blogs_n2.csv',
            col.names = TRUE, row.names = FALSE, sep = '|')
rm(blogs)


twitter <- scan(file = './data/en_US.twitter.txt', what = 'character', sep = '\n', skipNul = TRUE)
ref_twitter2 <- clean_corpus(twitter)
ref_twitter2 <- agg_set2(ref_twitter2)
write.table(x = ref_twitter2,
            file = './data/int_ref_twitter_n2.csv',
            col.names = TRUE, row.names = FALSE, sep = '|')
rm(twitter)


# Load components
ref_news2 <- read.table(file = './data/int_ref_news_n2.csv', 
                        header = TRUE, sep = '|', stringsAsFactors = FALSE)
ref_blogs2 <- read.table(file = './data/int_ref_blogs_n2.csv', 
                         header = TRUE, sep = '|', stringsAsFactors = FALSE)
ref_twitter2 <- read.table(file = './data/int_ref_twitter_n2.csv', 
                           header = TRUE, sep = '|', stringsAsFactors = FALSE)


ref_all_n2 <- rbind(ref_news2, ref_blogs2, ref_twitter2)
ref_all_n2 <- aggregate(count ~ k1 + k2 + v, data = ref_all_n2, FUN = sum)
ref_all_n2$probability <- (ref_all_n2$count / sum(ref_all_n2$count))
ref_all_n2 <- ref_all_n2[order(ref_all_n2$count, decreasing = TRUE),]
write.table(x = ref_all_n2,
            file = './data/int_ref_all_n2.csv',
            col.names = TRUE, row.names = FALSE, sep = '|')











