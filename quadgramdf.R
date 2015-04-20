# Data Science Capstone Project
# Quadgram dataframe building

source("/Users/williammcdonald/Coursera-JHU-Capstone/Capstone_helper.R")
options(mc.cores=1)

load('/Users/williammcdonald/CourseraCapstoneData/allText.RData')
load('/Users/williammcdonald/CourseraCapstoneData/naughty.RData')

# Set seed for sampling
set.seed(1056)
# Function to create multiple saved samples 
quadgramdf <- function(text){
        for (i in 1:10){
                name <- paste("/Users/williammcdonald/CourseraCapstoneData/df4gram", i, ".Rdata", sep = "")
                sampleText <- sample(text, size = 50000)
                clean <- cleanText(sampleText)
                rm(sampleText)
                text.corp <- createCorp(clean)
                rm(clean)
                corpus <- tm_map(text.corp, content_transformer(tolower))
                corpus <- tm_map(text.corp, content_transformer(removePunctuation))
                corpus <- tm_map(text.corp, content_transformer(removeNumbers))
                rm(text.corp)
                tdm4gram <- TermDocumentMatrix(corpus, control = list(tokenize = QuadgramTokenizer))
                rm(corpus)
                df4gram <- rollup(tdm4gram, 2, na.rm=TRUE, FUN = sum)
                df4gram <- as.data.frame(inspect(df4gram))
                df4gram$num <- rowSums(df4gram)
                df4gram <- subset(df4gram, num > 1)
                df4gram[c('predictor', 'prediction')] <- subset(str_match(row.names(df4gram), 
                                                                          "(.*) ([^ ]*)"), select=c(2,3))
                df4gram <- subset(df4gram, select=c('predictor', 'prediction', 'num'))
                df4gram <- df4gram[order(df4gram$predictor,-df4gram$num),]
                row.names(df4gram) <- NULL
                assign(paste("df4gram", i, sep = ""), df4gram)
                save(df4gram, file = name)
        }        
}

# Create multiple quadgram dataframes
quadgramdf(allText)

# Clear environment
WS <- c(ls())
rm(list = WS)

# Load saved files
for (i in 1:10){
        file <- list()
        name <- paste("/Users/williammcdonald/CourseraCapstoneData/df4gram", i, ".Rdata", sep = "")
        load(name)
        assign(paste("df4gram", i, sep = ""), df4gram)
        # file <- append(file, assign(paste("df4gram", i, sep = ""), df4gram)
}

# List of all dataframes
file <- list(df4gram1, df4gram2, df4gram3, df4gram4 ,df4gram5, df4gram6, 
             df4gram7, df4gram8, df4gram9, df4gram10)


# Merge
quadgramMaster <- Reduce(function(x,y) merge(x, y, by = c("predictor", "prediction") , all = TRUE), file)
quadgramMaster$num <- rowSums(quadgramMaster[, 3:12], na.rm = TRUE)
quadgramMaster <- quadgramMaster[, c(1:2, 13)]
quadgramMaster <- by(quadgramMaster, quadgramMaster$predictor, head, n = 3)
quadgramMaster <- Reduce(rbind, quadgramMaster)
save(quadgramMaster, file = "/Users/williammcdonald/CourseraCapstoneData/df4Master.Rdata")

# Hash
load("/Users/williammcdonald/CourseraCapstoneData/df4Master.Rdata")
predict4hash <- Hash(quadgramMaster)
save(predict4hash, file = '/Users/williammcdonald/CourseraCapstoneData/predict4hash.RData')
