library(shiny)
library(stringr)
library(tm)
library(RWeka)
source("triModel.R")

shinyServer(
        function(input, output) {
                y <- reactive(predictAll(input$text))
                output$text <- renderText(y()[1])
        }
)