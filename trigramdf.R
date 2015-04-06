# Data Science Capstone Project
# Trigram dataframe building

source("/Users/williammcdonald/Coursera-JHU-Capstone/Capstone_helper.R")
options(mc.cores=1)

load('/Users/williammcdonald/CourseraCapstoneData/allText.RData')
load('/Users/williammcdonald/CourseraCapstoneData/naughty.RData')

# Set seed for sampling
set.seed(1056)
# Function to create multiple saved samples 
trigramdf <- function(text){
        for (i in 1:10){
                name <- paste("/Users/williammcdonald/CourseraCapstoneData/df3gram", i, ".Rdata", sep = "")
                sampleText <- sample(text, size = 50000)
                clean <- cleanText(sampleText)
                rm(sampleText)
                text.corp <- createCorp(clean)
                rm(clean)
                corpus <- tm_map(text.corp, content_transformer(tolower))
                corpus <- tm_map(text.corp, content_transformer(removePunctuation))
                corpus <- tm_map(text.corp, content_transformer(removeNumbers))
                rm(text.corp)
                tdm3gram <- TermDocumentMatrix(corpus, control = list(tokenize = TrigramTokenizer))
                rm(corpus)
                df3gram <- rollup(tdm3gram, 2, na.rm=TRUE, FUN = sum)
                df3gram <- as.data.frame(inspect(df3gram))
                df3gram$num <- rowSums(df3gram)
                df3gram <- subset(df3gram, num > 1)
                df3gram[c('predictor', 'prediction')] <- subset(str_match(row.names(df3gram), "(.*) ([^ ]*)"), select=c(2,3))
                df3gram <- subset(df3gram, select=c('predictor', 'prediction', 'num'))
                df3gram <- df3gram[order(df3gram$predictor,-df3gram$num),]
                row.names(df3gram) <- NULL
                assign(paste("df3gram", i, sep = ""), df3gram)
                save(df3gram, file = name)
        }        
}

# Create multiple trigram dataframes
trigramdf(allText)

# Clear environment
WS <- c(ls())
rm(list = WS)

Load saved files
for (i in 1:10){
        name <- paste("/Users/williammcdonald/CourseraCapstoneData/df3gram", i, ".Rdata", sep = "")
        load(name)
        assign(paste("df3gram", i, sep = ""), df3gram)
}

# List of all dataframes
file <- list(df3gram1, df3gram2, df3gram3, df3gram4, df3gram5, df3gram6, 
             df3gram7, df3gram8, df3gram9, df3gram10)


# Merge
trigramMaster <- Reduce(function(x,y) merge(x, y, by = c("predictor", "prediction") , all = TRUE), file)
trigramMaster$num <- rowSums(trigramMaster[, 3:12], na.rm = TRUE)
trigramMaster <- trigramMaster[, c(1:2, 13)]

# Hash
predict3hash <- Hash(trigramMaster)
save(predict3hash, file = '/Users/williammcdonald/CourseraCapstoneData/predict3hash.RData')


