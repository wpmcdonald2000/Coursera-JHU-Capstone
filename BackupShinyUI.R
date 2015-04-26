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
                        p('and finally, more information about the project as a whole can be located on Background tab below'),
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
                                tabPanel("Background", HTML("
                                        <p>The goal of this project was to introduce us to the world of Natural Language Processing, to sharpen our R programming 
skills, and to work out the details of creating an App, firstly, here as a Shiny
app, but to also keep in mind the limitations of other platforms where predictive keyboards might be most useful</p>
<p> In addition to using the discussion forums in the course he following resources were used to accomplish this goal</p>
<ol>
<li><a href='http://cran.r-project.org/web/packages/tm/tm.pdf'>http://cran.r-project.org/web/packages/tm/tm.pdf</a></li>
<li><a href='http://cran.r-project.org/web/packages/hash/hash.pdf'>http://cran.r-project.org/web/packages/hash/hash.pdf</a></li>
<li><a href='http://cran.r-project.org/web/packages/RWeka/RWeka.pdf'>http://cran.r-project.org/web/packages/RWeka/RWeka.pdf</a></li>
<li><a href='http://cran.r-project.org/web/packages/slam/slam.pdf'>http://cran.r-project.org/web/packages/slam/slam.pdf</a></li>
<li><a href='http://cran.r-project.org/web/packages/openNLP/openNLP.pdf'>http://cran.r-project.org/web/packages/openNLP/openNLP.pdf</a></li>
<li><a href='http://shiny.rstudio.com/articles/layout-guide.html'>http://shiny.rstudio.com/articles/layout-guide.html</a></li>
</ol>
                                                           "))
                        )
                )
                )
)