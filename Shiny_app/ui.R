library(shiny)

shinyUI(
        fluidPage(
                
                titlePanel(HTML("Coursera Capstone Project
                           <h3>Natural Langauge Processing and Text Prediction</h3>")),
                
                fluidRow(
                        p('This is a shiny app text predictor for the Johns Hopkins Data Science Capstone Project'),
                        p('Type your text into the Input section text box, as you type the predicted next word will show up in the Main Panel area'),
                        p('The source files can be found in my Github Repository located here:', a("Github", href ="https://github.com/wpmcdonald2000/Coursera-JHU-Capstone")),
                        p("A short R Presentation file explaining some of the methodology can be located on my RPubs site here:", a("RPubs", href= "https://rpubs.com/wpmcdonald2000/73886")),                       
                        p('and finally, more information about the project as a whole can be located on "The Story" tab below'),
                        br()
                ), 
                               
                sidebarPanel(
                        h3('INPUT SECTION'),
                        textInput(inputId = "text", 
                                  label = 'Type your text here:', 
                                  value = 'The Cat in the ')           
                ),
                      
                mainPanel(
                        tabsetPanel(
                                tabPanel("Predictor", verticalLayout(
                                        h3('NEXT WORD PREDICTION'),
                                        h4(textOutput('text')))
                                                
                                ),
                                tabPanel("The Story", HTML("
                                        <p>The goal of this project was to introduce us to the world of Natural Language Processing, to sharpen our R programming 
skills, and to work out the details of creating an App, firstly, here as a Shiny
app, but to also keep in mind the limitations of other platforms where predictive keyboards might be most useful</p>
<p>To reach that goal, we needed to become familiar with manipulating large sets of text inputs (Tweets, News, and Blogs), to learn about the different methodologies 
used to break up text into meaningful blocks or units, formulate a plan for our own implementation, and then ... actually implement it in the chosen platform, here.</p>
<p>This 
                                                           "))
                        )
                )
        )
)