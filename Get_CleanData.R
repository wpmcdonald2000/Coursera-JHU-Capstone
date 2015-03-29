# Data Science Capstone Project
# Task 1: Tokenization and Profanity Filtering

library(tm)
library(RWeka)
library(tau)
library(SnowballC)
library(compiler)
library(wordcloud)
library(slam)

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

# Pre-cleaning stats?
twitter.size <- object.size(twitter)
twitter.char <- sum(nchar(twitter))
twitter.lines <- length(twitter)
blogs.size <- object.size(blogs)
blogs.char <- sum(nchar(blogs))
blogs.lines <- length(blogs)
news.size <- object.size(news)
news.char <- sum(nchar(news))
news.lines <- length(news)


# mean characters per line
twitter.char/ twitter.lines
blogs.char/ blogs.lines
news.char/ news.lines

source("/Users/williammcdonald/Coursera-JHU-Capstone/Capstone_helper.R")
hashtags <- "#[0-9][a-z][A-Z]+"
special <- c("®","™", "¥", "£", "¢", "€", "#")

twitter <- cleanText(twitter)
news <- cleanText(news)
blogs <- cleanText(blogs)

# Save the cleaned files to disk
# save files to RData, remove from memory, call for later use.
save(twitter, file = '/Users/williammcdonald/CourseraCapstoneData/twitter.RData')
save(blogs, file = '/Users/williammcdonald/CourseraCapstoneData/blogs.RData')
save(news, file = '/Users/williammcdonald/CourseraCapstoneData/news.RData')
save(naughty, file = '/Users/williammcdonald/CourseraCapstoneData/naughty.RData')

# Start here for after cleaning result.
load('/Users/williammcdonald/CourseraCapstoneData/twitter.RData')
load('/Users/williammcdonald/CourseraCapstoneData/news.RData')
load('/Users/williammcdonald/CourseraCapstoneData/blogs.RData')

twit.char <- sapply(twitter, nchar)
twit.charlen <- sapply(twit.char, sum)
twit.wordlen <- sapply(twit.char, length)

news.char <- sapply(news, nchar)
news.charlen <- sapply(news.char, sum)
news.wordlen <- sapply(news.char, length)

blogs.char <- sapply(blogs, nchar)
blogs.charlen <- sapply(blogs.char, sum)
blogs.wordlen <- sapply(blogs.char, length)

par(mfcol = c(2,3))
boxplot(twit.wordlen, main = "Words per Tweet")
boxplot(twit.charlen, main = "Characters per Tweet")
boxplot(news.wordlen, main = "Words per News Item")
boxplot(news.charlen, main = "Characters per News Item")
boxplot(blogs.wordlen, main = "Words per Blogs Item")
boxplot(blogs.charlen, main = "Characters per Blog Item")


# 1% Sampling
twitter.smpl <- sample(twitter, size = 10000)
rm(twitter)
blogs.smpl <- sample(blogs, size = 10000)
rm(blogs)
news.smpl <- sample(news, size = 10000)
rm(news)

# unlist

# Save sampled files to disk
save(twitter.smpl, file = '/Users/williammcdonald/CourseraCapstoneData/twittersample.RData')
save(blogs.smpl, file = '/Users/williammcdonald/CourseraCapstoneData/blogssample.RData')
save(news.smpl, file = '/Users/williammcdonald/CourseraCapstoneData/newssample.RData')

# Start here for sampled files
load('/Users/williammcdonald/CourseraCapstoneData/twittersample.RData')
load('/Users/williammcdonald/CourseraCapstoneData/newssample.RData')
load('/Users/williammcdonald/CourseraCapstoneData/blogssample.RData')


# len.twit <- sapply(clean.twitter, length)
# len.news <- sapply(clean.news, length)
# len.blog <- sapply(clean.blogs, length)

# summary(len.twit)
# summary(len.news)
# summary(len.blog)

# rm(text.smpl)
# rm(blogs.smpl)
# rm(news.smpl)
# rm(twitter.smpl)

# Number of lines per sample file
# length(clean.blogs)
# length(clean.news)
# length(clean.twitter)

# Analyze a corpus of each indivdually to check for differences
createCorp <- function(text){       
        x <- VCorpus(VectorSource(text))
        return(x)        
}

# Combine samples
sampleText <- c(twitter.smpl, news.smpl, blogs.smpl)
blogs.corp <- createCorp(blogs.smpl)
news.corp <- createCorp(news.smpl)
twitter.corp <- createCorp(twitter.smpl)
text.corp <- createCorp(sampleText)

rm(blogs.smpl)
rm(news.smpl)
rm(twitter.smpl)

par(mfrow = c(1,1))

wordcloud(twitter.corp, scale=c(8,0.3),
          min.freq=5, max.words=100, random.order=FALSE,
          rot.per=0.5, use.r.layout=FALSE,
          colors=brewer.pal(6, "Dark2"))

wordcloud(news.corp, scale=c(8,0.3),
          min.freq=5, max.words=100, random.order=FALSE,
          rot.per=0.5, use.r.layout=FALSE,
          colors=brewer.pal(6, "Dark2"))

wordcloud(blogs.corp, scale=c(8,0.3),
          min.freq=5, max.words=100, random.order=FALSE,
          rot.per=0.5, use.r.layout=FALSE,
          colors=brewer.pal(6, "Dark2"))

wordcloud(text.corp, scale=c(8,0.3),
          min.freq=5, max.words=100, random.order=FALSE,
          rot.per=0.5, use.r.layout=FALSE,
          colors=brewer.pal(6, "Dark2"))

# Create document matrix 
# Note some seem to be converting to a dataframe?
twitter.tdm <- TermDocumentMatrix(twitter.corp)
news.tdm <- TermDocumentMatrix(news.corp)
blogs.tdm <- TermDocumentMatrix(blogs.corp)
text.tdm <- TermDocumentMatrix(text.corp)

# frequent terms and associations
twitter.freq <- findFreqTerms(twitter.tdm, lowfreq = 30)
news.freq <- findFreqTerms(news.tdm, lowfreq = 30)
blogs.freq <- findFreqTerms(blogs.tdm, lowfreq = 30)
text.freq <- findFreqTerms(text.tdm, lowfreq = 30)

# Remove sparse terms
text.tdm_ns <- removeSparseTerms(text.tdm, 0.995)

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

" |><^{}~&@\\]\\[=+\\r\\n\\t.,;:\\()?!-/"
unigramTokenizer <- function(x) NGramTokenizer(
        x, Weka_control(min = 1, max = 1, delimiters = delimiters))