library(shiny)

shinyUI(
        pageWithSidebar(
                
                headerPanel("Data Science Capstone Project"),
                
                sidebarPanel(
                        h3('INPUT SECTION'),
                        textInput(inputId = "text", 
                                  label = 'Enter your text here:', 
                                  value = NULL)
                        
                ),
                
                mainPanel(
                        h3('NEXT WORD PREDICTION'),
                        textOutput('text')
                                                
                )
        )
)