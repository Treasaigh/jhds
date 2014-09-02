library(shiny)

am_calc_cm <- function(amount, term_len, int_rate) {
    term_mon <- term_len * 12
    ir_per <- int_rate / (100 * 12)
    output_payment <- amount * 
        (((ir_per * (1+ir_per)^term_mon) / 
              (((1+ir_per)^term_mon) - 1)))
    output_payment
}
am_calc_cy <- function(amount, term_len, int_rate) {
    ir_per <- int_rate / 100
    output_payment <- amount * 
        (((ir_per * (1+ir_per)^term_len) / 
              (((1+ir_per)^term_len) - 1)))
    output_payment / 12
}

shinyServer(
    function(input,output) {
        output$payment_cm <- renderPrint({am_calc_cm(input$amount, input$term_len, input$int_rate)})
        output$payment_cy <- renderPrint({am_calc_cy(input$amount, input$term_len, input$int_rate)})
    }
)