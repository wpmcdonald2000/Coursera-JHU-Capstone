setwd("/Users/williammcdonald/CourseraCapstoneData/")
# source("BuildModel.R")
load('hash2.RData')
load('hash3.RData')
load('hash4.RData')


# First Model
bigramPrediction <- function(x) {
        clean <- removeNumbers(removePunctuation(tolower(x)))
        f <- tail(strsplit(clean, " ")[[1]], 1)
        predict2hash[[f]]
}

trigramPrediction <- function(x) {
        clean <- removeNumbers(removePunctuation(tolower(x)))
        f <- tail(strsplit(clean, " ")[[1]], 2)
        predict3hash[[paste(f, sep="_", collapse='_')]]
}

quadgramPrediction <- function(x) {
        clean <- removeNumbers(removePunctuation(tolower(x)))
        f <- tail(strsplit(clean, " ")[[1]], 3)
        predict4hash[[paste(f, sep="_", collapse='_')]]
}

predictAll <- function(x) {
        p4 <- quadgramPrediction(x)
        if (!is.null(p4)) {
                p4
        } 
        else {
                p3 <- trigramPrediction(x)
                if (!is.null(p3)) {
                        p3
                } else {
                        p2 <- bigramPrediction(x)
                        if (!is.null(p2)) {
                                p2
                        } else {
                                'the'
                        }
                }
        }
}
