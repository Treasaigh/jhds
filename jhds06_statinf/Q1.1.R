# Quiz code
x <- 1:4
p <- x/sum(x)
temp <- rbind(x, p)
rownames(temp) <- c("X", "Prob")
temp

# Mine
mean(p)
sum(p)

sum(x * p)  # right









