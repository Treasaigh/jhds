complete <- function(directory="specdata", id=1:332) {
    
    complete.data <- data.frame(id=rep(""), nobs=rep(1), stringsAsFactors=FALSE)
    n <- 1
    
    for (i in id) {
        ii   <- fileNumber(i)
        dir  <- gsub(" ", "", paste(directory, "/", ii, ".csv"))
        data <- read.csv(dir, header=TRUE, sep="," )
        nobs <- getNobs(data)
        complete.data[n, ] <- c(i, nobs)
        n    <- n+1
    }
    print(complete.data)
}

fileNumber <- function(i) {
    if (nchar(i) == 1) {
        i <- gsub(' ', '', paste("00", i))
    } else if (nchar(i) == 2) {
        i <- gsub(' ', '', paste("0", i))
    } else if (nchar(i) == 3 ) {
        i <- gsub(' ', '', paste("", i))
    }
    i
}

getNobs <- function(data) {
    good.obs    <- complete.cases(data$sulfate, data$nitrate)
    sulfate.obs <- length(data$sulfate[good.obs])
    nitrate.obs <- length(data$nitrate[good.obs])
    
    if (sulfate.obs < nitrate.obs) {
        nobs <- sulfate.obs
    } else {
        nobs <- nitrate.obs
    }
    nobs
}