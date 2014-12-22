library(shiny)

shinyUI(fluidPage(
  titlePanel("Text Predictor"),
  h4("Input some text, app will predict next word as the sentence progresses."),
  p(),
  p(),
  textInput('input_text', label = h3('Input sentence:'), value = "Enter text..."),
  hr(),
  fluidRow(column(3, verbatimTextOutput('rec1')))
))