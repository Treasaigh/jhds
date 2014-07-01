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