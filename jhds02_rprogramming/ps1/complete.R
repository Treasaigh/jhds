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