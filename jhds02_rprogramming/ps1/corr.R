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