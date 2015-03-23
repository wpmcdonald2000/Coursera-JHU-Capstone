library(tm)
library(RWeka)
library(tau)
library(SnowballC)
library(wordcloud)

# Load Data using readLines 
# Test for file encoding
is.utf8("/Users/williammcdonald/CourseraCapstoneData/twitter.txt")
is.ascii("/Users/williammcdonald/CourseraCapstoneData/swearWords.txt")
# All are ASCII encoded
setwd( "/Users/williammcdonald/CourseraCapstoneData/")
twitter <- readLines("twitter.txt", skipNul = TRUE)
naughty <- readLines("/Users/williammcdonald/CourseraCapstoneData/swearWords.txt", skipNul = TRUE)
# CLose connections
closeAllConnections()

# Save
save(twitter, file = '/Users/williammcdonald/CourseraCapstoneData/twitter.RData')

# Start here
load('/Users/williammcdonald/CourseraCapstoneData/twitter.RData')

# Word stats?
twitter.char <- sum(nchar(twitter))
twitter.lines <- length(twitter)

twitter.lines
twitter.char
twitter.char/ twitter.lines



# Sample @ 1%
twitter.smpl <- sample(twitter, size = round(length(twitter)/100))
rm(twitter)

# Prep sample
source("/Users/williammcdonald/Coursera-DataScienceCapstone/Capstone_helper.R")
hashtags <- "#[0-9][a-z][A-Z]+"
special <- c("®","™", "¥", "£", "¢", "€", "#", "_")

clean.twitter <- cleanText(twitter.smpl)
rm(twitter.smpl)

length <- sapply(clean.twitter, length)
length(clean.twitter)

boxplot(length)

twitter.corp<- VCorpus(VectorSource(clean.twitter))
rm(clean.twitter)

twitter.tdm <- TermDocumentMatrix(twitter.corp)

# frequent terms and associations
twitter.freq <- findFreqTerms(twitter.tdm, lowfreq = 30)
# twitter.assoc <- findAssocs(twitter.tdm, dimnames(twitter.tdm)$Terms[1:40], rep(.5, 40))
# Above call bogs down analysis, is it necessary??
# Use RWeka ngram tokenizer instead

# FreqTerm <- as.data.frame(rowSums(as.matrix(twitter.tdm)))
# FreqTerm$words <- row.names(FreqTerm)


wordcloud(twitter.corp, scale=c(8,0.3),
          min.freq=5, max.words=100, random.order=FALSE,
          rot.per=0.5, use.r.layout=FALSE,
          colors=brewer.pal(6, "Dark2"))


