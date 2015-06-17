pollutantmean <- function(directory, pollutant, id = 1:332) {
    setwd(directory)
    for (i in id) {
        if (i < 10) {
          if (exists("pollution")) {
            temp <- read.csv(paste("00",i,".csv",sep=""))
            pollution <- rbind(pollution, temp)
          } else {
            pollution <- read.csv(paste("00",i,".csv",sep=""))
          }
        } else if (i >= 10 & i < 100) {
          if (exists("pollution")) {
            temp <- read.csv(paste("0",i,".csv",sep=""))
            pollution <- rbind(pollution, temp)            
          } else {
            pollution <- read.csv(paste("0",i,".csv",sep=""))
          }
        } else if (i >= 100) {
          if (exists("pollution")) {
            temp <- read.csv(paste(i,".csv",sep=""))
            pollution <- rbind(pollution, temp)            
          } else {
            pollution <- read.csv(paste(i,".csv",sep=""))
          }
        }
    }
    colNum = if(pollutant == "sulfate"){ 2 } else if (pollutant == "nitrate") { 3 } else NA
    polMean <- mean(pollution[,colNum], na.rm = TRUE)
    polMean
}