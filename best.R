# setwd("~/Desktop/R")
# outcome <- read.csv("rprog-data-ProgAssignment3-data/outcome-of-care-measures.csv", colClasses = "character")

# head(outcome)
# outcome[,11] <- as.numeric(outcome[,11])
# hist(outcome[,11])

best <- function(state, outcome) {    
    
    data <- .GlobalEnv$outcome
    
    if (!(state %in% data$State)) {
        stop("invalid state")
    }
    
    colNum <- if (outcome == "heart attack") {
        11
    } else if (outcome == "heart failure") {
        17
    } else if (outcome == "pneumonia") {
        23
    } else {
        stop("invalid outcome")
    }
    
    data <- data[order(data$Hospital.Name),]
    data <- data[which((data[,colNum])!="Not Available"),]
    data[,colNum] <- as.numeric(data[,colNum])
    
    mins <- tapply(data[,colNum], data$State, min, na.rm = TRUE, simplify=FALSE) ## mins is an array
    mins <- as.matrix(mins)                                                      ## mins is a matrix
    statemin <- mins[state,]

    hospitals <- data[which (data[,colNum] == statemin & data$State == state),]
 
    thebest <- hospitals[1, "Hospital.Name"]
    thebest
}
