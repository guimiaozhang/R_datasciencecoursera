library(shiny)
library(sbo)

load('traineddat.Rda')
model <- sbo_predictor(train)

# Define server logic required to draw a histogram
shinyServer(
    function(input, output, session) {
        observe({
            prediction <- predict(model, input$text_input)
            output$predicted <- renderPrint(cat(prediction))
        })
    })
