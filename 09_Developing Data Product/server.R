library(shiny)
data(Orange)

ids <- unique(Orange$Tree)

shinyServer(
    function(input, output, session) {
        values <- reactiveValues()
        values$ids <- ids
        observe({
            if(input$clearall > 0) {
                updateCheckboxGroupInput(session = session, inputId = 'ids', 
                                         choices = ids, selected = NULL)
                values$ids <- c()
            }
        })
        observe({
            if(input$selectall > 0) {
                updateCheckboxGroupInput(session = session, inputId = 'ids',
                                         choices =ids, selected = ids)
                values$ids <- ids
            }
        })
        output$treeids <- renderUI({
            checkboxGroupInput('ids', 'Tree ids:',  ids, selected = values$ids)
        })
    }
)