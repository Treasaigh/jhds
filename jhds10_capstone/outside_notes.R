# Load libraries
# Includes doSNOW intialized to 3 cores
library(tm)
library(doSNOW)
c1 <- makeCluster(3, type = "SOCK")
registerDoSNOW(c1)

# Initialize local variables
corpFile <- "./data/corpora/corpus0.db1"
corpSave <- "./data/corpora/corpus0.rdata"
sourceFiles <- DirSource("./data/source/en_US")

# Determine if corpus file present
# Load if found
# Reads source files into new corpus otherwise
ifelse(sum(file.exists(c(corpFile, corpSave))) == 2,
       load(corpSave),
       corp <- PCorpus(sourceFiles, dbControl = list(dbName = corpFile, dbType = "DB1")))

##
## Quiz 1 Question 2
##
# The en_US.twitter.txt has how many lines of text?
length(corp[["en_US.twitter.txt"]]$content)

##
## Q1Q3
##
# What is the length of the longest line seen in any of the three en_US data sets?
# Evaluates in a single pass
longLine <- data.frame(doc = 0, line = 0, length = 0)

# Iterate along documents
for(d in seq_along(corp)) {

    # Temporarily load document content into memory (from permanent corpus)
    content <- corp[[d]]$content
    
    # Iterate along lines
    for(l in seq_along(content)) {
        len <- nchar(content[l])
        if(len > longLine$length) longLine[1, ] <- c(d, l, len)
    }
}

# Cleanup local variables
rm(d, l, len, content)

# Print results
longLine

##
## Q1Q4
##
# In the en_US twitter data set, if you divide the number of lines where the
# word "love" (all lowercase) occurs by the number of lines the word "hate"
# (all lowercase) occurs, about what do you get?

# Transform corpus to lower case (one time only b/c PCorpus)
# tm_map(corp, content_transformer(tolower))

# Build DocumentTermMatrix for "love" and "hate" in en_US.twitter.txt
# FAILED Run time too long
# dtmLoveHate <- DocumentTermMatrix(corp[grep("en_US.twitter.txt", names(corp))],
#                                   list(dictionary = c("love", "hate")))

# INSTEAD Evaluate with sapply
# Temporarily load document content into memory (from permanent corpus)
content <- corp[[grep("en_US.twitter.txt", names(corp))]]$content

# Search for "love" with word boundaries
searchText <- "\\blove\\b"
countLove <- sum(grepl(searchText, content))

# Search for "hate" with word boundaries
searchText <- "\\bhate\\b"
countHate <- sum(grepl(searchText, content)

# Print ratio of love:hate
countLove / countHate # No answer matches quiz

# Search for "love" WITHOUT word boundaries
searchText <- "love"
countLove <- sum(grepl(searchText, content))

# Search for "hate" WITHOUT word boundaries
searchText <- "hate"
countHate <- sum(grepl(searchText, content))

# Print ratio of love:hate
countLove / countHate # Answer approximately matches quiz

##
## Q1Q5
##
# The one tweet in the en_US twitter data set that matches the word "biostats" says what?
searchText <- "biostats"
biostatsQuote <- content[grep(searchText, content)]

# Print results
biostatsQuote

##
## Q1Q6
##
# How many tweets have the exact characters "A computer once beat me at chess,
# but it was no match for me at kickboxing". (I.e. the line matches those
# characters exactly.)
searchText <- "A computer once beat me at chess, but it was no match for me at kickboxing"
kickboxingCount <- sum(grepl(searchText, content))

# Print results
kickboxingCount

# Cleanup local variables
rm(searchText, content)

# Save R data file for 'corp' object
save(corp, file = corpSave)

# Stop DoSNOW cluster
stopCluster(c1)