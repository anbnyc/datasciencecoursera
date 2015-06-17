rankhospital <- function(state, outcome, num){
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
    
    hospitals <- data[which (data$State == state),]
    hospitals <- hospitals[order(hospitals[,colNum]),]
    
    rank <- if (num == "best"){
        1
    } else if (num == "worst"){
        nrow(hospitals)
    } else {
        num
    }
    
    winner <- hospitals[rank,"Hospital.Name"]
    winner
}