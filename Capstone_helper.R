# Helper functions for capstone project

#load, save and sample data
setwd( "/Users/williammcdonald/CourseraCapstoneData/")


hashtags <- "#[0-9][a-z][A-Z]+"
special <- c("®","™", "¥", "£", "¢", "€", "#", "_")
unicode <- "[^[:print:]]"

# Function to clean and vectorize text files
cleanText <- function(text){
        # remove all hashtags, substitute for profanity, remove special characters 
        x <- gsub(unicode, " ", text)
        x <- gsub(hashtags, " ", x)
        x <- gsub(paste0('\\<', naughty , '\\>', collapse = '|'), '!$?%', x)
        x <- gsub(paste0(special, collapse = '|'), " ", x) 
        # Clean text
        x <- tolower(x)
        x <- stripWhitespace(x)
        x <- removePunctuation(x, preserve_intra_word_dashes = TRUE)
        x <= removeNumbers(x)
        x <- strsplit(x, "\\W")
        return(x)
}

# Create a corpus from a vectorized text file
createCorp <- function(text){       
        x <- VCorpus(VectorSource(text))
        return(x)        
}

# Cleanup function: Need to figure out stemming!
cleanCorp <- function(x){
        x <- tm_map(x, removeNumbers)
        x <- tm_map(x, removePunctuation, preserve_intra_word_dashes = TRUE)
        x <- tm_map(x, content_transformer(tolower))
        x <- tm_map(x, stripWhitespace)
        # x < tm_map(x, content_transformer(stemDocument))
        return(x)
}

