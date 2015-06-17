rankall <- function(outcome, num = "best") {
    data <- .GlobalEnv$outcome
    
    colNum <- if (outcome == "heart attack") {
        11
    } else if (outcome == "heart failure") {
        17
    } else if (outcome == "pneumonia") {
        23
    } else {
        stop("invalid outcome")
    }
    
    data <- data[which((data[,colNum])!="Not Available"),]
    data[,colNum] <- as.numeric(data[,colNum])
    data <- data[order(data$State, data[,colNum], data$Hospital.Name),]
    statenames <- unique(data$State)
    
    if (num == "best"){
        hospnames <- tapply(data$Hospital.Name, data$State, function(x) head(x,1))
    } else if (num == "worst"){
        hospnames <- tapply(data$Hospital.Name, data$State, function(x) tail(x,1))
    } else {
        hospnames <- tapply(data$Hospital.Name, data$State, function(x) x[num])
    }

    df <- data.frame(hospnames)
    df[,2]<- statenames
    names(df) <- c("hospital", "state")
    df
}