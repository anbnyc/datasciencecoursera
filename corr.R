corr <- function(directory, threshold = 0) {
    setwd("J:/R")
    source("complete.R")
    list <- complete(directory)
    list <- list[which (list$nobs > threshold),]
    
    if (dim(list)[1] > 0){
        for (i in list$id) {
            if (i < 10) {
                temp <- read.csv(paste("00",i,".csv",sep=""))
            } else if (i >= 10 & i < 100) {
                temp <- read.csv(paste("0",i,".csv",sep=""))
            } else if (i >= 100) {
                temp <- read.csv(paste(i,".csv",sep=""))
            }
            
            temp <- temp[which( !is.na(temp$Date) & !is.na(temp$sulfate) & !is.na(temp$nitrate)), ]
    
            if (exists("corrs")) {
                j <- length(corrs)+1
                corrs[j] <- cor(temp$sulfate, temp$nitrate)
            } else {
                corrs <- cor(temp$sulfate, temp$nitrate)
            }
        }
    } else {
        corrs <- vector()
    }
    corrs
}