# Data Science Capstone Project
# Task 1: Tokenization and Profanity Filtering

require(tm)
require(RWeka)
require(tau)
require(SnowballC)
require(compiler)
require(wordcloud)
require(slam)

load('/Users/williammcdonald/CourseraCapstoneData/twittersample.RData')
load('/Users/williammcdonald/CourseraCapstoneData/newssample.RData')
load('/Users/williammcdonald/CourseraCapstoneData/blogssample.RData')

# Combine
sampleText <- c(twitter.smpl, news.smpl, blogs.smpl)
cleanedText <- data.frame(text=unlist(sapply(sampleText, '[', "content")), stringsAsFactors=FALSE)

# Create Corpus
sample.corp <- VCorpus(VectorSource(sampleText))

# Create term document matrix
text.tdm <- TermDocumentMatrix(sample.corp)

text.freq <- findFreqTerms(text.tdm, lowfreq = 30)
text.freq <- sort(row_sums(text.tdm),decreasing=TRUE)

# Remove sparse terms
text.tdm_ns <- removeSparseTerms(text.tdm, 0.995)

# plot
barplot(text.freq[1:25], ylab = "Frequency", las = 2 )

# N-Grams
unigrams <- NGramTokenizer(cleanedText, Weka_control(min=1, max=1))
bigrams <- NGramTokenizer(cleanedText, Weka_control(min = 2, max = 2, delimiters = " \\r\\n\\t.,;:\"()?!"))
trigrams <- NGramTokenizer(cleanedText, Weka_control(min = 3, max = 3, delimiters = " \\r\\n\\t.,;:\"()?!"))
