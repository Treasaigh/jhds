setwd("~/Dropbox/Education/JHDS 2 - R Programming/ps1")
dir_base <- "~/Dropbox/Education/JHDS 2 - R Programming/ps1"
dir_end <- "specdata"
paste(dir_base, dir_end, sep='/')
setwd(paste(dir_base, dir_end, sep='/'))
getwd()
paste(1, '.csv', sep='')
test1 <- read.table('001.csv', header=TRUE, sep=',')
test2 <- read.table('002.csv', header=TRUE, sep=',')
test3 <- read.table('159.csv', header=TRUE, sep=',')
testc <- rbind(test1, test2, test3)

list.files()[3]
class(list.files())
test <- sapply(list.files(), read.csv)

for (i in 1:4) {print(i)}
for (i in list.files()) {print(i)}
testc2 <- data.frame()
testc2 <- rbind(testc2,test1)
testc2 <- rbind(testc2,test2)

pm_pollution <- data.frame()
for (i in list.files()) {
    dfa <- read.table(file=i, sep=',', header=TRUE)
    pm_pollution <- rbind(pm_pollution, dfa)
}

pm_pollution <- data.frame()
for (i in 1:10) {
    list_files <- list.files()
    dfa <- read.table(file=list_files[i], sep=',', header=TRUE)
    pm_pollution <- rbind(pm_pollution, dfa)
}

head(subset(x=pm_pollution, !is.na(pm_pollution$sulfate)))
length(subset(x=pm_pollution, !is.na(pm_pollution$sulfate)))
length(subset(x=pm_pollution, is.na(pm_pollution$sulfate)))
mean(pm_pollution$nitrate)
mean(pm_pollution$nitrate[!is.na(pm_pollution$nitrate)])

pollutant <- 'Frank'
if (pollutant == 'sulfate') {
    mean(pm_pollution$sulfate[!is.na(pm_pollution$sulfate)])
} else if (pollutant == 'nitrate') {
    mean(pm_pollution$nitrate[!is.na(pm_pollution$nitrate)])
} else {
    NA
}


# part 1

# Sample output
# https://d396qusza40orc.cloudfront.net/rprog%2Fdoc%2Fpollutantmean-demo.html
pollutantmean <- function(directory, pollutant, id = 1:332) {
    dir_base <- "~/Dropbox/Education/JHDS 2 - R Programming/ps1"
    setwd(paste(dir_base, directory, sep='/'))
    pm_pollution <- data.frame()
    for (i in id) {
        list_files <- list.files()
        dfa <- read.table(file=list_files[i], sep=',', header=TRUE)
        pm_pollution <- rbind(pm_pollution, dfa)
    }
    
    if (pollutant == 'sulfate') {
        mean(pm_pollution$sulfate[!is.na(pm_pollution$sulfate)])
    } else if (pollutant == 'nitrate') {
        mean(pm_pollution$nitrate[!is.na(pm_pollution$nitrate)])
    } else {
        NA
    }
}

# Unit Tests
pollutantmean("specdata", "sulfate", 1:10)
pollutantmean("specdata", "nitrate", 70:72)
pollutantmean("specdata", "nitrate", 23)



pm_pollution <- data.frame()
for (i in 332:1) {
    list_files <- list.files()
    dfa <- read.table(file=list_files[i], sep=',', header=TRUE)
    pm_pollution <- rbind(pm_pollution, dfa)
}
pm_pollution <- pm_pollution[complete.cases(pm_pollution),]
# pm_pollution$n <- 1
# as.data.frame(tapply(pm_pollution$n, pm_pollution$ID, sum))
# pm_agg <- as.data.frame(xtabs(data=pm_pollution, formula = n ~ ID))
pm_agg <- as.data.frame(table(pm_pollution$ID))
names(pm_agg) <- c('id','nobs')
len_save <- length(pm_agg$id)
pm_agg2 <- data.frame(pm_agg, row.names=c(len_save:1))
pm_agg2 <- data.frame(pm_agg2[order(id),])


id <- 332:1
pm_agg[order(id),]
len_save <- length(pm_agg$id)
pm_agg <- data.frame(pm_agg[order(id),])

tail(pm_agg$id)
class(pm_agg$id)
length(pm_agg$id)
summary(pm_agg$id)
length(332:1)
length(30:25)
length(25:30)
length(c(1:323))


# part 2

# sample output
# https://d396qusza40orc.cloudfront.net/rprog%2Fdoc%2Fcomplete-demo.html
complete <- function(directory, id = 1:332) {
    dir_base <- "~/Dropbox/Education/JHDS 2 - R Programming/ps1"
    setwd(paste(dir_base, directory, sep='/'))
    pm_pollution <- data.frame()
    for (i in id) {
        list_files <- list.files()
        dfa <- read.table(file=list_files[i], sep=',', header=TRUE)
        pm_pollution <- rbind(pm_pollution, dfa)
    }
    setwd(dir_base)
    pm_pollution <- pm_pollution[complete.cases(pm_pollution),]
    pm_agg <- as.data.frame(table(pm_pollution$ID), row.names=NULL)
    names(pm_agg) <- c('id','nobs')
    pm_agg <- data.frame(pm_agg[order(id),], row.names=c(1:(length(pm_agg$id))))
    pm_agg
}

complete <- function(directory, id = 1:332) {
    dir_base <- "~/Dropbox/Education/JHDS 2 - R Programming/ps1"
    setwd(paste(dir_base, directory, sep='/'))
    pm_pollution <- data.frame()
    for (i in id) {
        list_files <- list.files()
        dfa <- read.table(file=list_files[i], sep=',', header=TRUE)
        pm_pollution <- rbind(pm_pollution, dfa)
    }
    setwd(dir_base)
    pm_pollution <- pm_pollution[complete.cases(pm_pollution),]
    pm_agg <- as.data.frame(table(pm_pollution$ID))
    names(pm_agg) <- c('id','nobs')
    len_save <- length(pm_agg$id)
    pm_agg2 <- data.frame(pm_agg, row.names=c(len_save:1))
    pm_agg2 <- data.frame(pm_agg2[order(id),])
    pm_agg2
}


# Unit Tests
complete("specdata", 1)
complete("specdata", c(2, 4, 8, 10, 12))
complete("specdata", 30:25)
complete("specdata", 3)

complete("specdata", 332:1)
complete("specdata", 270:280)





# part 3
directory = 'specdata'
threshold = 150

dir_base <- "~/Dropbox/Education/JHDS 2 - R Programming/ps1"
setwd(paste(dir_base, directory, sep='/'))
pm_pollution <- data.frame()
for (i in 1:332) {
    list_files <- list.files()
    dfa <- read.table(file=list_files[i], sep=',', header=TRUE)
    pm_pollution <- rbind(pm_pollution, dfa)
}
setwd(dir_base)
pm_pollution <- pm_pollution[complete.cases(pm_pollution),]
pm_agg <- as.data.frame(table(pm_pollution$ID))
names(pm_agg) <- c('id','nobs')

pm_agg <- subset(pm_agg, pm_agg$nobs > threshold)
pm_poll <- subset(pm_pollution, pm_pollution$ID %in% pm_agg$id)
cor(pm_poll$sulfate, pm_poll$nitrate)

output <- vector()
for (i in pm_agg$id) {
    sub <- subset(pm_poll, pm_poll$ID == i)
    cor_act <- cor(sub$sulfate, sub$nitrate)
    output <- append(x=output, values=cor_act)
}
output

summary(tapply(pm_poll$sulfate, pm_poll$ID, mean))
by(pm_poll$ID ,pm_poll[,c(2,3)], cor)




# Sample output
# https://d396qusza40orc.cloudfront.net/rprog%2Fdoc%2Fcorr-demo.html
corr <- function(directory, threshold = 0) {
    dir_base <- "~/Dropbox/Education/JHDS 2 - R Programming/ps1"
    setwd(paste(dir_base, directory, sep='/'))
    pm_pollution <- data.frame()
    for (i in 1:332) {
        list_files <- list.files()
        dfa <- read.table(file=list_files[i], sep=',', header=TRUE)
        pm_pollution <- rbind(pm_pollution, dfa)
    }
    setwd(dir_base)
    pm_pollution <- pm_pollution[complete.cases(pm_pollution),]
    pm_agg <- as.data.frame(table(pm_pollution$ID))
    names(pm_agg) <- c('id','nobs')
    
    pm_agg <- subset(pm_agg, pm_agg$nobs > threshold)
    pm_poll <- subset(pm_pollution, pm_pollution$ID %in% pm_agg$id)
    cor(pm_poll$sulfate, pm_poll$nitrate)
    
    output <- vector()
    for (i in pm_agg$id) {
        sub <- subset(pm_poll, pm_poll$ID == i)
        cor_act <- cor(sub$sulfate, sub$nitrate)
        output <- append(x=output, values=cor_act)
    }
    output
}


# Unit Tests

cr <- corr("specdata", 150)
head(cr)
summary(cr)

cr <- corr("specdata", 400)
head(cr)
summary(cr)

cr <- corr("specdata", 5000)
summary(cr)
length(cr)

cr <- corr("specdata")
summary(cr)
length(cr)






# Submission Script
source("http://d396qusza40orc.cloudfront.net/rprog%2Fscripts%2Fsubmitscript1.R")
submit()

























