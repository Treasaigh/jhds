library(shiny)

shinyUI(pageWithSidebar(
    headerPanel('Loan Payment Calculator'),
    sidebarPanel(
        numericInput('amount', 'Amount of Loan (Dollars)', 1000, min=1000, max=100000, step=100),
        numericInput('term_len', 'Length of Loan (Years)', 1, min=1, max=10, step=1),
        sliderInput('int_rate', 'Interest Rate (Percent)', value=5.0, min=0.0, max=20.0, step=0.1)
    ),
    mainPanel(
        h3('Documentation'),
        p('Calculate the monthly payment on a simple interest installment loan.'),
        p('Input the amount of the loan, the term in years, and see the effect of interest rate with the slider.'),
        p('Amount: must be rounded to the nearest $100, between $1,000 and $100,000.'),
        p('Length: must be in whole years, between 1 and 10.'),
        p('Output: monthly payment necessary to satisfy the loan.'),
        h3('Resulting Monthly Payment: Monthly Compounding'),
        verbatimTextOutput('payment_cm'),
        h3('Resulting Monthly Payment: Yearly Compounding'),
        verbatimTextOutput('payment_cy')
    )
))