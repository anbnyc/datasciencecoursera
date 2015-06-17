setwd("J:/R")

prData <- read.csv("pr_hs_201314bg3.csv")
nvData <- read.csv("NewVisionsSchools.csv")
colnames(nvData)[colnames(nvData)=="dbn"] <- "DBN"
mergeData <- merge(prData,nvData,by="DBN",all=T)

# input: breakdown category, metric, operation

# output: portfolio owner, rank, metric value

ranker <- function(grouper, metric, measure){
    data <- mergeData
    data <- data[which( !is.na(data[,grouper]) & data[,grouper] != "#N/A" & data[,grouper] != "") , ]
    rank <- tapply(data[,metric], data[,grouper], measure, simplify = TRUE, na.rm=TRUE)
    rank <- rank[which ( !is.na(rank))]
    df <- data.frame(cbind(row.names(rank),rank), row.names=NULL)
    colnames(df) <- make.names(c(grouper,metric), TRUE)
    df <- df[order(df[,metric]),]
    df
}