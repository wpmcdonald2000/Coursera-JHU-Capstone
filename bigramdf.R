# Data Science Capstone Project
# Bigram dataframe building

source("/Users/williammcdonald/Coursera-JHU-Capstone/Capstone_helper.R")
options(mc.cores=1)

load('/Users/williammcdonald/CourseraCapstoneData/allText.RData')
load('/Users/williammcdonald/CourseraCapstoneData/naughty.RData')

# Set seed for sampling
set.seed(1056)
# Function to create multiple saved samples 
bigramdf <- function(text){
        for (i in 1:10){
                name <- paste("/Users/williammcdonald/CourseraCapstoneData/df2gram", i, ".Rdata", sep = "")
                sampleText <- sample(text, size = 50000)
                clean <- cleanText(sampleText)
                rm(sampleText)
                text.corp <- createCorp(clean)
                rm(clean)
                corpus <- tm_map(text.corp, content_transformer(tolower))
                corpus <- tm_map(text.corp, content_transformer(removePunctuation))
                corpus <- tm_map(text.corp, content_transformer(removeNumbers))
                rm(text.corp)
                tdm2gram <- TermDocumentMatrix(corpus, control = list(tokenize = BigramTokenizer))
                rm(corpus)
                df2gram <- rollup(tdm2gram, 2, na.rm=TRUE, FUN = sum)
                df2gram <- as.data.frame(inspect(df2gram))
                df2gram$num <- rowSums(df2gram)
                df2gram <- subset(df2gram, num > 1)
                df2gram[c('predictor', 'prediction')] <- subset(str_match(row.names(df2gram), "(.*) ([^ ]*)"), select=c(2,3))
                df2gram <- subset(df2gram, select=c('predictor', 'prediction', 'num'))
                df2gram <- df2gram[order(df2gram$predictor,-df2gram$num),]
                row.names(df2gram) <- NULL
                assign(paste("df2gram", i, sep = ""), df2gram)
                save(df2gram, file = name)
        }        
}

# Create multiple trigram dataframes
bigramdf(allText)

# Clear environment
WS <- c(ls())
rm(list = WS)

#Load saved files
for (i in 1:10){
        name <- paste("/Users/williammcdonald/CourseraCapstoneData/df2gram", i, ".Rdata", sep = "")
        load(name)
        assign(paste("df2gram", i, sep = ""), df2gram)
}

# List of all dataframes
file <- list(df2gram1, df2gram2, df2gram3, df2gram4, df2gram5, df2gram6, 
             df2gram7, df2gram8, df2gram9, df2gram10)

# Merge
bigramMaster <- Reduce(function(x,y) merge(x, y, by = c("predictor", "prediction") , all = TRUE), file)
bigramMaster$num <- rowSums(bigramMaster[, 3:12], na.rm = TRUE)
bigramMaster <- bigramMaster[, c(1:2, 13)]
bigramMaster <- by(bigramMaster, bigramMaster$predictor, head, n = 3)
bigramMaster <- Reduce(rbind, bigramMaster)
save(bigramMaster, file = "/Users/williammcdonald/CourseraCapstoneData/df2Master.Rdata")


# Hash
load("/Users/williammcdonald/CourseraCapstoneData/df2Master.Rdata")
predict2hash <- Hash(bigramMaster)
save(predict2hash, file = '/Users/williammcdonald/CourseraCapstoneData/predict2hash.RData')
