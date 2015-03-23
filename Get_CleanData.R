# Data Science Capstone Project
# Task 1: Tokenization and Profanity Filtering

library(tm)
library(RWeka)
library(tau)
library(SnowballC)
library(compiler)

# Load Data using readLines 
# Test for file encoding
is.utf8("/Users/williammcdonald/CourseraCapstoneData/twitter.txt")
is.ascii("/Users/williammcdonald/CourseraCapstoneData/swearWords.txt")
# All are ASCII encoded

# The whole thing - moved English files to separate data directory
setwd( "/Users/williammcdonald/CourseraCapstoneData/")
twitter <- readLines("twitter.txt", skipNul = TRUE)
news <- readLines("news.txt", skipNul = TRUE)
blogs <- readLines("blogs.txt", skipNul = TRUE)
# Include Profanity file
naughty <- readLines("/Users/williammcdonald/CourseraCapstoneData/swearWords.txt", skipNul = TRUE)
# CLose connections
closeAllConnections()

# save files to RData, remove from memory, call for later use.
save(twitter, file = '/Users/williammcdonald/CourseraCapstoneData/twitter.RData')
save(blogs, file = '/Users/williammcdonald/CourseraCapstoneData/blogs.RData')
save(news, file = '/Users/williammcdonald/CourseraCapstoneData/news.RData')

# Word stats?
twitter.char <- sum(nchar(twitter))
twitter.lines <- length(twitter)
blogs.char <- sum(nchar(blogs))
blogs.lines <- length(blogs)
news.char <- sum(nchar(news))
news.lines <- length(news)
twitter.lines
twitter.char
blogs.lines
blogs.char
news.lines
news.char
# mean characters per line
twitter.char/ twitter.lines
blogs.char/ blogs.lines
news.char/ news.lines

# 1% Sampling
twitter.smpl <- sample(twitter, size = round(length(twitter)/100))
blogs.smpl <- sample(blogs, size = round(length(blogs)/100))
news.smpl <- sample(blogs, size = round(length(news)/100))

# Combine
# text.smpl <- c(blogs.smpl, news.smpl, twitter.smpl)

rm(twitter)
rm(blogs)
rm(news)

# Clean samples
source("/Users/williammcdonald/Coursera-DataScienceCapstone/Capstone_helper.R")

hashtags <- "#[0-9][a-z][A-Z]+"
special <- c("®","™", "¥", "£", "¢", "€", "#")

# clean.text <- cleanText(text.smpl)
clean.blogs <- cleanText(blogs.smpl)
clean.news <- cleanText(news.smpl)
clean.twitter <- cleanText(twitter.smpl)

len.twit <- sapply(clean.twitter, length)
len.news <- sapply(clean.news, length)
len.blog <- sapply(clean.blogs, length)

summary(len.twit)
summary(len.news)
summary(len.blog)

boxplot(len.twit)
boxplot(len.news)
boxplot(len.bolg)

# rm(text.smpl)
rm(blogs.smpl)
rm(news.smpl)
rm(twitter.smpl)

# Number of words per sample
length(clean.blogs)
length(clean.news)
length(clean.twitter)

# Analyze a corpus of each indivdually to check for differences
createCorp <- function(text){       
        x <- VCorpus(VectorSource(text))
        return(x)        
}

blogs.corp <- createCorp(clean.blogs)
news.corp <- createCorp(clean.news)
twitter.corp <- createCorp(clean.twitter)

rm(clean.blogs)
rm(clean.news)
rm(clean.twitter)

wordcloud(twitter.corp, scale=c(8,0.3),
          min.freq=5, max.words=100, random.order=FALSE,
          rot.per=0.5, use.r.layout=FALSE,
          colors=brewer.pal(6, "Dark2"))

wordcloud(news.corp, scale=c(8,0.3),
          min.freq=5, max.words=100, random.order=FALSE,
          rot.per=0.5, use.r.layout=FALSE,
          colors=brewer.pal(6, "Dark2"))

wordcloud(blog.corp, scale=c(8,0.3),
          min.freq=5, max.words=100, random.order=FALSE,
          rot.per=0.5, use.r.layout=FALSE,
          colors=brewer.pal(6, "Dark2"))


# Create document matrix 
# Note some seem to be converting to a dataframe?
twitter.tdm <- TermDocumentMatrix(twitter.corp)
news.tdm <- TermDocumentMatrix(news.corp)
blogs.tdm <- TermDocumentMatrix(blogs.corp)

# frequent terms and associations
twitter.freq <- findFreqTerms(twitter.tdm, lowfreq = 30)
news.freq <- findFreqTerms(news.tdm, lowfreq = 30)
blogs.freq <- findFreqTerms(blogs.tdm, lowfreq = 30)

# cleancorp.assoc <- findAssocs(textcorp.tdm, dimnames(textcorp.tdm)$Terms[1:40], rep(.5, 40))

countTermFreq <- function(tdm) {
        term.freq <- sort(row_sums(tdm),decreasing=TRUE)
        return(term.freq)
}

FreqTerm <- as.data.frame(rowSums(as.matrix(textcorp.tdm)))
FreqTerm$words <- row.names(FreqTerm)

# Construct data frame of top
df <- data.frame(twitter.freq, FreqTerm$totalFreq[1:54])
names(df) <- c("Terms", "Freq")

ggplot(df, aes(x = Terms, y = Freq)) + geom_bar(stat = 'identity', color = 'white', fill = 'red') + coord_flip()

