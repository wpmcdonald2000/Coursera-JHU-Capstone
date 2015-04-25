#setwd("/Users/williammcdonald/CourseraCapstoneData/")
load('predictHash.RData')

# First Model
bigramPrediction <- function(x) {
        clean <- removeNumbers(removePunctuation(tolower(x)))
        f <- tail(strsplit(clean, " ")[[1]], 1)
        predictHash[[f]]
}

trigramPrediction <- function(x) {
        clean <- removeNumbers(removePunctuation(tolower(x)))
        f <- tail(strsplit(clean, " ")[[1]], 2)
        predictHash[[paste(f, sep="_", collapse='_')]]
}

quadgramPrediction <- function(x) {
        clean <- removeNumbers(removePunctuation(tolower(x)))
        f <- tail(strsplit(clean, " ")[[1]], 3)
        if (length(f > 0)){
                predictHash[[paste(f, sep="_", collapse='_')]]
        }
        else{
                'Feed me! I need input'
        }
}

predictAll <- function(x) {
        if (is.null(x)){
                "the"
        }
        else{
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
                                        'sorry, i have no idea what you are saying'
                        }
                }
        }
}
}
