library(shiny)
library(stringr)

load(file = './app_data_ref.RData')

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
  output <- rec_queue[1]
  as.character(output)
}


shinyServer(
    function(input,output) {
        output$rec1 <- renderPrint({make_prediction_vector(input$input_text)})
    }
)












