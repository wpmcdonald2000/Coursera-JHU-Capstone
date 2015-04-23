library(shiny)

shinyUI(
        fluidPage(
                
                titlePanel("Coursera Text Prediction Capstone Project"),
                
                fluidRow(
                        p('This is a shiny app text predictor for the Johns Hopkins Data Science Capstone Project'),
                        p('Type your text into the Input section text box, as you type the predicted next word will show up in the Main Panel area'),
                        p('The sources files can be found in my Github Repository located here:', a("Github", href ="https://github.com/wpmcdonald2000/Coursera-JHU-Capstone")),
                        p("A short R Presentation file explaining some of the methodology can be located on my RPubs site here:", a("RPubs", href= "https://rpubs.com/wpmcdonald2000/73886") )
                        
                ), 
                               
                sidebarPanel(
                        h3('INPUT SECTION'),
                        textInput(inputId = "text", 
                                  label = 'Type your text here:', 
                                  value = 'The Cat in the ')           
                ),
                      
                mainPanel(
                        h3('NEXT WORD PREDICTION'),
                        h4(textOutput('text'))
                                                
                )
        )
)