# Helper functions for capstone project

#load, save and sample data
setwd( "/Users/williammcdonald/CourseraCapstoneData/")

# Function to clean and vectorize text files
cleanText <- function(text){
        # remove all hashtags, substitute for profanity, remove special characters 
        x <- gsub(hashtags, " ", text)
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

