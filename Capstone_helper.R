# Helper functions for capstone project

libs <- c('tau', 'slam', 'SnowballC', 'wordcloud', 'stringi', "ggplot2", "stringr", "tm", "RWeka", "hash", "reshape")
lapply(libs, function(x){library(x, character.only = TRUE, quietly = TRUE)})

#load, save and sample data
setwd( "/Users/williammcdonald/CourseraCapstoneData/")

# Set variables
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
        x <- gsub("-", " ", x)
        x <- tolower(x)
        x <- stripWhitespace(x)
        x <- removePunctuation(x, preserve_intra_word_dashes = TRUE)
        x <= removeNumbers(x)
        # x <- strsplit(x, "\\W")
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

# Tokenizer functions
UnigramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 1, max = 1))
BigramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 2, max = 2))
TrigramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 3, max = 3))
QuadgramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 4, max = 4))

ngramdf <- function(text, x){
        for (i in 1:10){
                token <- paste("df", x, "gram", sep = "")
                name <- paste("/Users/williammcdonald/CourseraCapstoneData/", token, i, ".Rdata", sep = "")
                sampleText <- sample(text, size = 50000)
                clean <- cleanText(sampleText)
                rm(sampleText)
                text.corp <- createCorp(clean)
                rm(clean)
                corpus <- tm_map(text.corp, content_transformer(tolower))
                corpus <- tm_map(text.corp, content_transformer(removePunctuation))
                corpus <- tm_map(text.corp, content_transformer(removeNumbers))
                rm(text.corp)
                tdm.ngram <- TermDocumentMatrix(corpus, control = list(tokenize = TrigramTokenizer)) # ? pass the appropriate tokenizer
                rm(corpus)
                df.ngram <- rollup(tdm3gram, 2, na.rm=TRUE, FUN = sum)
                df.ngram <- as.data.frame(inspect(df.ngram))
                df.ngram$num <- rowSums(df.ngram)
                df.ngram <- subset(df.ngram, num > 1)
                df.ngram[c('predictor', 'prediction')] <- subset(str_match(row.names(df.ngram), "(.*) ([^ ]*)"), select=c(2,3))
                df.ngram <- subset(df.ngram, select=c('predictor', 'prediction', 'num'))
                df.ngram <- df.ngram[order(df3gram$predictor,-df3gram$num),]
                row.names(df.ngram) <- NULL
                assign(paste(token, i, sep = ""), df.ngram)
                save(df.ngram, file = name)
        }        
}

Hash <- function(df) {
        hash <- new.env(hash=TRUE, parent=emptyenv())
        for (ii in rev(seq(nrow(df)))) {
                key <- gsub(" ", "_", df[ii, 'predictor'])
                value <- df[ii, 'prediction']
                hash[[key]] <- value
        }
        hash
}

