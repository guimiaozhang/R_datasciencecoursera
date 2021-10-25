library(shiny)
library(shinythemes)

# Define UI for application that draws a histogram
shinyUI(
    fluidPage(
        theme = shinytheme('sandstone'),
        titlePanel(h2('Predicting Text using Ngrams & Stupid Backoff Model', align = 'center')),
        sidebarPanel(
            h4('Instructions:'),
            p('Start typing any words in the box to see your predictions.')
            ),
        mainPanel(
            textAreaInput('text_input', '', value='', width = '200%', height = '200px'),
            h3('Predictions'),
            verbatimTextOutput('predicted')
            ),
    )
)