setwd("J:/R")
outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
head(outcome)

outcome[,11] <- as.numeric(outcome[,11])
hist(outcome[,11])

best <- function(state, outcome){
    colNum <- if (outcome = "heart attack") {
        11
    } else if (outcome = "heart failure") {
        17
    } else if (outcome = "pneumonia") {
        23
    } else {
        NA
    }
    
    outcome[,colNum] <- as.numeric(outcome[,colNum])
    
    mins <- tapply(outcome[,colNum], outcome$State, min, na.rm = TRUE, simplify=FALSE) ## mins is an array
    mins <- as.matrix(mins) ## mins is a matrix
    statemin <- as.numeric(mins[state,])
}
