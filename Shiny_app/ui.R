library(shiny)

shinyUI(navbarPage("Coursera Text Predictor",
        tabPanel("Predictor",
                 fluidPage(
                         sidebarPanel(
                                h3('INPUT SECTION'),
                                textInput(inputId = "text", label = 'Type your text here:', 
                                value = 'The Cat in the ')           
                                ),
                         mainPanel(
                                fluidRow(
                                        p('This is a shiny app text predictor for the Johns Hopkins Data Science Capstone Project.'),
                                        p('Type your text into the Input section text box to the left. As you type the predicted next word will show up below')
                                         ),
                                 verticalLayout(       
                                        h3('NEXT WORD PREDICTION'),
                                        h4(textOutput('text')))
                                ) 
                         )
                 ),
                 
        tabPanel("Methods",
                 fluidPage(
                         titlePanel(HTML("<h3>Natural Langauge Processing and Text Prediction</h3>")),
                         fluidRow(
                                h4('Basics'),
                                p('The process started with an analysis of the supplied corpora of texts, samples of Twitter "Tweets", Blog Posts, and News Feeds 
                                in 4 different languages (English, German, Russian, and Finnish). Initial examination showed us how many lines of text, total words, 
                                the number of sentences, and the number of unique words that were supplied in each separate sample'),
                                p("In addition to the straighforward frequency analysis, we also discovered other issues that may have to be dealt with in order to fulfill
                                  our assignment. These included quesstions of how to handle profanity, how to deal with a host of special characters such as hashtags and 
                                  words from other languages, and the frequent use of acronyms and abbreviations, epecially in Tweets"),
                                p("Using a variety of available packages in R (see Resources), we broke up, or 'tokenized' the texts into combinations of multi word 
                                  phrases or n-grams. After removing the sparse or infrequently occurring patterns, we grouped and sorted the results by frequency. In order to create
                                  a predictive model, the last word of each phrase was split off as a 'predicted' word from the beginning of the phrase, to be used as a 'predictor'"),
                                p("A number of different methods of creating a Prediction algrorithm were explored, but in the end, I decided to limit my n-grams to 2, 3, and 4 word length
                                  and use a 'Simple' (see Resources)  backoff model that would predict the next word in order of decreasing phrase length. The table of frequencies was stored 
                                  as an environment in a Hash table stored along with the model"),
                                h4('Things I wished I had more time to incorporate!'),
                                p("Throughout the process, there were a number of different thoughts I had that I either did not have the time to invesitgate thoroughly, or I 
                                  simply did not have the prgramming skills to add to the model. These include:"),
                                HTML("
                                     <ol>
                                        <li>A 'Fuzzy' spell checker. This n-gram predictor is completely dependent on exact word or phrase matches. Unfortunately, most people are not so exact.</li>
                                        <li>My feeble programming skills were not up to the task of developing a predictor that could learn from the user. </li>
                                        <li>A means of 'sentence mapping' to improve prediction when complex prepositional phrases are injected between the subject and the desired prediction</li> 
                                     </ol>")
                                 )
                        )
                ),
        
        tabPanel("Resources",
                 fluidPage(                                                                            
                        fluidRow(
                                HTML("
<p> In addition to using the discussion forums in the course, the following resources were used to varying degrees to accomplish this goal.</p>
<ol>
<li><a href='http://cran.r-project.org/web/packages/tm/tm.pdf'>http://cran.r-project.org/web/packages/tm/tm.pdf</a></li>
<li><a href='http://cran.r-project.org/web/packages/hash/hash.pdf'>http://cran.r-project.org/web/packages/hash/hash.pdf</a></li>
<li><a href='http://cran.r-project.org/web/packages/RWeka/RWeka.pdf'>http://cran.r-project.org/web/packages/RWeka/RWeka.pdf</a></li>
<li><a href='http://cran.r-project.org/web/packages/slam/slam.pdf'>http://cran.r-project.org/web/packages/slam/slam.pdf</a></li>
<li><a href='http://cran.r-project.org/web/packages/openNLP/openNLP.pdf'>http://cran.r-project.org/web/packages/openNLP/openNLP.pdf</a></li>
<li><a href='http://shiny.rstudio.com/articles/layout-guide.html'>http://shiny.rstudio.com/articles/layout-guide.html</a></li>
<li><a href='http://storage.googleapis.com/books/ngrams/books/datasetsv2.html'>http://storage.googleapis.com/books/ngrams/books/datasetsv2.html</a></li>
<li><a href='http://www.cs.columbia.edu/~smaskey/CS6998-0412/supportmaterial/langmodel_mapreduce.pdf'>http://www.cs.columbia.edu/~smaskey/CS6998-0412/supportmaterial/langmodel_mapreduce.pdf</a></li>
</ol> "
                                        ) 
                                )
                        )
                )
                )
)
