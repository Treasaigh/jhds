# Q2: twitter lines of text
twitter <- scan(file = './data/en_US.twitter.txt', what = 'character', sep = '\n', skipNul = TRUE)
length(twitter)

# Q3 longest line
news <- scan(file = './data/en_US.news.txt', what = 'character', sep = '\n')
blogs <- scan(file = './data/en_US.blogs.txt', what = 'character', sep = '\n')
twitter <- scan(file = './data/en_US.twitter.txt', what = 'character', sep = '\n', skipNul = TRUE)

max(nchar(news))
max(nchar(blogs))
max(nchar(twitter))


# Q4 Twitter love / hate
length(grep(pattern = "love", x = twitter))
length(grep(pattern = "hate", x = twitter))
length(grep(pattern = "love", x = twitter)) / length(grep(pattern = "hate", x = twitter))

# Q5 biostats
grep(pattern = "biostats", x = twitter)
twitter[grep(pattern = "biostats", x = twitter)]

# Q6 Computer beats chess
q6_pattern <- "A computer once beat me at chess, but it was no match for me at kickboxing"
grep(pattern = q6_pattern, x = twitter)
length(grep(pattern = q6_pattern, x = twitter))




