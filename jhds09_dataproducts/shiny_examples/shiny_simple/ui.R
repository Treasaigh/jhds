library(shiny)
shinyUI(pageWithSidebar(
    headerPanel('Data Science! - Illustrating Markup'),
    sidebarPanel(
        h1('Sidebar text'),
        h1('H1 Text'),
        h2('H2 Text'),
        h3('H3 Text'),
        h4('H4 Text'),
        numericInput('id1', 'Numeric input labeled id1', 0, min=0, max=10, step=1),
        checkboxGroupInput('id2','Checkbox',
                           c('Value 1' = '1',
                             'Value 2' = '2',
                             'Value 3' = '3')),
        dateInput('date','Date:')
    ),
    mainPanel(
        h3('Main Panel Text'),
        code('some code'),
        p('some ordinary text'),
        p(''),
        h3('Illustrating outputs'),
        h4('You entered'),
        verbatimTextOutput('oid1'),
        h4('You entered'),
        verbatimTextOutput('oid2'),
        h4('You entered'),
        verbatimTextOutput('odate')
    )
))