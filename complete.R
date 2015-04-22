complete <- function(directory, id = 1:332) {
    setwd(directory)
    for (i in id) {
        if (i < 10) {
            temp <- read.csv(paste("00",i,".csv",sep=""))
        } else if (i >= 10 & i < 100) {
            temp <- read.csv(paste("0",i,".csv",sep=""))
        } else if (i >= 100) {
            temp <- read.csv(paste(i,".csv",sep=""))
        }
        subset <- temp[which( !is.na(temp$Date) & !is.na(temp$sulfate) & !is.na(temp$nitrate)), ]
        if (exists("results")) {
            results <- rbind(results, c(list(temp$ID[1],nrow(subset))))
        } else {
            results <- c(list(temp$ID[1],nrow(subset)))
        }
    }
    df <- data.frame(results, row.names = NULL)
    colnames(df) = make.names(c("id","nobs"), TRUE)
    df
}
