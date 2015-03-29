# Data Science Capstone Project
# Task 1: Tokenization and Profanity Filtering

require(tm)
require(RWeka)
require(tau)
require(SnowballC)
require(compiler)
require(wordcloud)
require(slam)
require(ggplot2)

is.utf8("/Users/williammcdonald/CourseraCapstoneData/twitter.txt")
is.ascii("/Users/williammcdonald/CourseraCapstoneData/twitter.txt")
is.utf8("/Users/williammcdonald/CourseraCapstoneData/blogs.txt")
is.ascii("/Users/williammcdonald/CourseraCapstoneData/blogs.txt")
is.utf8("/Users/williammcdonald/CourseraCapstoneData/news.txt")
is.ascii("/Users/williammcdonald/CourseraCapstoneData/news.txt")

setwd( "/Users/williammcdonald/CourseraCapstoneData/")
twitter <- readLines("twitter.txt", skipNul = TRUE)
news <- readLines("news.txt", skipNul = TRUE)
blogs <- readLines("blogs.txt", skipNul = TRUE)
# Include Profanity file
naughty <- readLines("/Users/williammcdonald/CourseraCapstoneData/swearWords.txt", skipNul = TRUE)
# CLose connections
closeAllConnections()

# Sample
twitter.smpl <- sample(twitter, size = 10000)
rm(twitter)
blogs.smpl <- sample(blogs, size = 10000)
rm(blogs)
news.smpl <- sample(news, size = 10000)
rm(news)

# Combine
sampleText <- c(twitter.smpl, news.smpl, blogs.smpl)
# cleanedText <- data.frame(text=unlist(sapply(sampleText, '[', "content")), stringsAsFactors=FALSE)
save(sample, file = '/Users/williammcdonald/CourseraCapstoneData/sample.RData')

hashtags <- "#[0-9][a-z][A-Z]+"
special <- c("®","™", "¥", "£", "¢", "€", "#", "_")
unicode <- "[^[:print:]]"

cleanText <- function(text){
        # remove all hashtags, substitute for profanity, remove special characters 
        x <- gsub(unicode, " ", text)
        x <- gsub(hashtags, " ", x)
        x <- gsub(paste0('\\<', naughty , '\\>', collapse = '|'), '!$?%', x)
        x <- gsub(paste0(special, collapse = '|'), " ", x) 
        x <- tolower(x)
        # x <- stripWhitespace(x)
        x <- removePunctuation(x, preserve_intra_word_dashes = TRUE)
        x <= removeNumbers(x)
        # x <- strsplit(x, "\\W")
        return(x)
}

clean.text <- cleanText(sampleText)

# Create Corpus
sample.corp <- Corpus(VectorSource(clean.text))

options(mc.cores=1)

bigram <- function(x) NGramTokenizer(x, Weka_control(min = 2, max = 2))
bigram.tdm <- TermDocumentMatrix(sample.corp, control = list(tokenize = bigram))
bigramRowTotal <- row_sums(bigram.tdm)
bigram2.tdm <- bigram.tdm[which(bigramRowTotal > 500),]
bigramFreq <- as.data.frame(rowSums(as.matrix(bigram2.tdm)))
colnames(bigramFreq) <- c("Freq")

ggplot(bigramFreq) + geom_bar(aes(x=row.names(bigramFreq), y = Freq), stat = "identity") + labs(x = "Terms", y = "Frequency", title = "Frequency of 2-grams") +coord_flip()

trigram <- function(x) NGramTokenizer(x, Weka_control(min = 3, max = 3))
trigram.tdm <- TermDocumentMatrix(sample.corp, control = list(tokenize = trigram))
trigramRowTotal <- row_sums(trigram.tdm)
trigram2.tdm <- trigram.tdm[which(trigramRowTotal > 40),]
trigramFreq <- as.data.frame(rowSums(as.matrix(trigram2.tdm)))
colnames(trigramFreq) <- c("Freq")
ggplot(trigramFreq) + geom_bar(aes(x=row.names(trigramFreq), y = Freq), stat = "identity") + labs(x = "Terms", y = "Frequency", title = "Term Frequency of 3-gram") +coord_flip()