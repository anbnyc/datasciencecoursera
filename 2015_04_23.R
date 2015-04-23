# TASK 1: "What does this do?"

setwd("J:/R")
prData <- read.csv("pr_hs_201314bg3.csv")

selectSchools <- function(varname, threshold, network = "all") {
    colNum <- which(colnames(prData)==varname)
    subset <- if (network == "nv") {
        prData[which( prData[,colNum] > threshold & prData$nv == "Yes") ,]
    } else if (network == "nonnv") {
        prData[which( prData[,colNum] > threshold & prData$nv == "No") ,]
    } else if (network == "all") {
        prData[which( prData[,colNum] > threshold) ,]
    }
    nr <- nrow(subset)
    for (i in 1:nr) {
        temp <- c(list(as.character(subset[i, 'school']), subset[i,colNum], as.character(subset[i,'nv'])))
        schools <- if (!exists("schools")) {
            temp
        } else {
            rbind(schools, temp)
        }
    }
    df <- data.frame(schools, row.names=1)
    colnames(df) = make.names(c(varname,"NV"),TRUE)
    df
}

# DISCUSSION QUESTIONS
# if you're not sure what "colnames" (line 7) does, how can you find out?
# what's with the lonely commas in line 9?
# how many times will this loop in line 10 run?
# what does the test on line 12 do?
# bonus: why do we assign only one column name instead of two (line 19)? hint: see line 18

# USEFUL FUNCTIONS/CONCEPTS
# which: eqiuvalent to Stata's "if"
# rbind: merge on row (i.e., append)

################################################################################

# TASK 2: Coursera Programming Assignment

setwd("specdata")
file1 <- read.csv("010.csv")
View(file1)

# ANSWER FOR YOURSELF
# what variables do we have?
# how many records are there in this file?
# if I wanted to get a subset of all the complete records (w/o NAs), how would I do that?

# DISCUSSION QUESTIONS
# For each of the three parts of Programming Assignment 1:
# 1. What arguments does our function need to take, and what should our function do with them?
# 2. What does our output look like?
# 3. Are there any R functions that we already KNOW we are going to need to use?
# 4. For parts two and three, how can we use the functions we've already written?