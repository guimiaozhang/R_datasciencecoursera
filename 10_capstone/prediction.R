# setwd('C:/Users/T460p/Desktop/coursera/JHU/10')
# SwiftKey data: 
# https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip
# bad words: 
# https://gist.githubusercontent.com/ryanlewis/a37739d710ccdb4b406d/raw/3b70dd644cec678ddc43da88d30034add22897ef/google_twunter_lol


library(stringr)
library(dplyr)
library(tm)
library(sbo)

# load data & sample 40%
filepath <- list.files('data/en_US', full.names = T)

sampdata <- function(filepath, size, replace = F){
    file <- readLines(filepath, skipNul = T, warn = F)
    len <- NROW(file)
    sam <- sample(file, len * size, replace = replace)
    return(sam)
}

data <- c()
for(i in 1:length(filepath)) {
    data <- c(data, sampdata(filepath[i], 0.4))
}
rm(i)

# clean data
(delete <- content_transformer(function(x, pattern) gsub(pattern, " ", x)))
badwords <- read.csv('data/badwords.txt', sep = '\n')
cleaning <- function(dat) {
    # dat is the data achieved through readLines (or small portion of it)
    
    # subset original vector of words to exclude words with non-ASCII char
    nonlatin <- grep('nonlatinsss', iconv(dat, "latin1", "ASCII", sub = 'nonlatinsss'))
    dat <- dat[-nonlatin]
    
    clean <- dat %>% list %>% VectorSource %>% VCorpus %>% 
        tm_map(FUN = delete, "(f|ht)tp(s?)://(.*)[.][a-z]+") %>%  
        tm_map(FUN = delete, '@[^\\s]+') %>%                      
        tm_map(FUN = removeNumbers) %>%                           
        tm_map(FUN = removePunctuation) %>%                      
        tm_map(FUN = removeWords, c(stopwords('en'))) %>%        
        tm_map(FUN = removeWords, badwords[,1]) %>%                  
        tm_map(FUN = stripWhitespace) %>%                         
        tm_map(FUN = content_transformer(tolower)) %>%            
        tm_map(FUN = PlainTextDocument)                           
    return(clean)
}
cleaned <- cleaning(data)
rm(data)

# training & predicting
cleaned <- unlist(cleaned, use.names = F)
train <- sbo_predtable(object = cleaned, N = 5, # Train a 5-gram model
                       dict = target ~ 0.8, # coverage 80%
                       .preprocess = sbo::preprocess, # Preprocessing
                       EOS = ".?!:;", # End-Of-Sentence tokens
                       L = 3, # Number of predictions for input
)
model <- sbo_predictor(train)
predict(model, "You're the reason why I smile everyday. Can you follow me please? It would mean the")

save(train, file = 'traineddat.RData')


