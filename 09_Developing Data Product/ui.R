library(shiny)
shinyUI(
    navbarPage(
        'Harry Potter Collection',
        tabPanel(
            'Movies',
            strong('Plot parameters'),
            sidebarPanel(
                #Set parameters for varirables
                p('Select tree id numbers you are interested'),
                p(''),
                
                actionButton('clearall', 'Clear selection', icon('square-o')),
                actionButton('selectall', 'Select all', icon('check-square-o')),
                uiOutput('treeids'),
                actionButton('gobutton', 'Go!'),
                sliderInput('ages', 'Select age ranges you are interested', min = min(Orange$age)-2,
                            max = max(Orange$age)+2, value = (min(Orange$age)-1, max(Orange$age)+1),
                            p(''), 
                            
                )
            ),
            mainPanel(
                h4('You have selected: '),
                textOutput('text1')
            )
        ),
        
        tabPanel(
            'Characters'
        )
        
    )
)