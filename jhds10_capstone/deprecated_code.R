# Deprecated: too inefficient
word_count <- function(corpus_list) {
    output <- data.frame(word = '', count = 0)
    for (i in c(1:length(corpus_list))) {
        for (t in c(1:length(corpus_list[[i]]))) {
            output <- rbind(output,
                            data.frame(word = corpus_list[[i]][t], count = 1))
        }
    }
    output <- aggregate(count ~ word, data = output, FUN = sum)
    output$word[output$word == ''] <- NA
    output <- subset(output, complete.cases(output))
    output <- output[order(output$count, decreasing = TRUE),]
    output$probability <- (output$count / length(output$word))
    output
}

shingle_set1 <- function(char_vector) {
    output <- data.frame(k1 = '', v = '')
    itr_len <- length(char_vector) - 1
    if (itr_len <= 0) return(output)
    for (i in c(1:itr_len)) {
        output <- rbind(output,
                        data.frame(k1 = char_vector[i],
                                   v = char_vector[i+1]))
    }
    output
}

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


# Migrated loop to lapply
agg_set3 <- function(corpus_list) {
    final_df <- data.frame()
    for (i in c(1:length(corpus_list))) {
        final_df <- rbind(final_df, shingle_set3(corpus_list[[i]]))
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

# Migrated loop to unlist()
word_count <- function(corpus_list) {
    output <- c()
    for (i in c(1:length(corpus_list))) {
        output <- c(output, corpus_list[[i]])
    }
    output <- data.frame(word = output, stringsAsFactors = FALSE)
    output$count <- 1
    output <- aggregate(count ~ word, data = output, FUN = sum)
    output$word[output$word == ''] <- NA
    output <- subset(output, complete.cases(output))
    output <- output[order(output$count, decreasing = TRUE),]
    output$probability <- (output$count / sum(output$count))
    output
}
