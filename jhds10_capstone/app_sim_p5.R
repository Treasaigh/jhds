library(stringr)

load(file = './data/app_data_ref.RData')

clean_string <- function(corpus) {
  output <- tolower(corpus)
  output <- str_replace_all(output, pattern = "'", replacement = "")
  output <- str_replace_all(output, pattern = "[^[:print:]]", replacement = "")
  output <- str_replace_all(output, pattern = "[^[:alpha:] | [:space:]]", replacement = "")
  output <- str_trim(output, side = 'both')
  output <- str_replace_all(output, pattern = " {2,}", replacement = " ")
  output <- str_split(output, pattern = "[[:space:]]")
  output <- unlist(output)
  output
}

make_prediction_vector <- function(user_input) {
  string_input <- clean_string(user_input)
  string_len <- length(string_input)
  word_e1 <- string_input[string_len]
  word_e2 <- string_input[(string_len - 1)]
  word_e3 <- string_input[(string_len - 2)]
  rec_queue <- c()
  if (exists('ref_list')) {
    rec_n3 <- subset(ref_list[['n3']], k1 == word_e3 & k2 == word_e2 & k3 == word_e1)
    rec_n2 <- subset(ref_list[['n2']], k1 == word_e2 & k2 == word_e1)
    rec_n1 <- subset(ref_list[['n1']], k1 == word_e1)
    rec_wf <- sample(x = ref_list[['wf']]$v, size=10, replace=FALSE)
    rec_queue <- c(rec_n3$v, rec_n2$v, rec_n1$v, rec_wf)
  }
  last_resort <- sample(x = c('the','a','and','of','in','for'), size=6, replace=FALSE)
  rec_queue <- c(rec_queue, last_resort)
  rec_queue <- unique(rec_queue)
  rec_queue <- rec_queue[rec_queue != word_e1]
  rec_queue[1:5]
}




# Test Cases
make_prediction_vector("What she want's is")
make_prediction_vector("I would like")
make_prediction_vector("where wo")
make_prediction_vector("Where is the cat")


sample(x = ref_list[['wf']]$v, size=10, replace=FALSE)
exists('ref_list')

if (exists('ref_list')) {
  1
} else {
  2
}




# Simulate App


input_string <- "for the first"

rec_n3 <- subset(ref_list[['n3']], k1 == 'the' & k2 == 'next' & k3 == 'time')
rec_n2 <- subset(ref_list[['n2']], k1 == 'next' & k2 == 'time')
rec_n1 <- subset(ref_list[['n1']], k1 == 'time')
rec_wf <- ref_list[['wf']]$v[1:15]
rec_queue <- c(rec_n3$v, rec_n2$v, rec_n1$v, rec_wf)
rec_queue <- unique(rec_queue)
rec_queue <- rec_queue[rec_queue != 'for']
rec_queue[1:5]














