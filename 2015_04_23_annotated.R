## This version has been updated an annotated since the 2015_04_23 meeting
# TASK 1: "What does this do?"

## Change your working directory to where the PR data is saved
setwd("J:/R")
## Load the PR data into a data frame in your global environment
prData <- read.csv("pr_hs_201314bg3.csv")

## Create a function called selectSchools with 3 arguments
selectSchools <- function(varname, threshold, network = "all") {
    
    ## Identify the column of PR in which the selected variable lives
    colNum <- which(colnames(prData)==varname)
    
    ## Create a data frame with the subset of schools that meet threshold AND...
    subset <- if (network == "nv") {
        ## ...that are NV schools if the 3rd argument was nv
        prData[which( prData[,colNum] > threshold & prData$nv == "Yes") ,]
    } else if (network == "nonnv") {
        ## ...that are not NV schools if the 3rd argument was nonnv
        prData[which( prData[,colNum] > threshold & prData$nv == "No") ,]
    } else if (network == "all") {
        ## ...all schools based on default argument
        prData[which( prData[,colNum] > threshold) ,]
    }
    
    ## Count the number of rows in the subset
    nr <- nrow(subset)
    
    ## Iterate once for each row
    for (i in 1:nr) {
        ## Create a temporary object with school name, selected variable, and NV status
        temp <- c(list(as.character(subset[i, 'school']), subset[i,colNum], as.character(subset[i,'nv'])))
        
        schools <- if (!exists("schools")) {
            ## Save the temporary object to schools if schools doesn't exist...
            temp
        } else {
            ## ...otherwise, append the temporary object to schools
            rbind(schools, temp)
        }
    }
    
    ## Save the appended objects as a dataframe with School as the name of each row
    df <- data.frame(schools, row.names=1)
    
    ## Name the columns for the selected variable and NV
    colnames(df) = make.names(c(varname,"NV"),TRUE)
    
    ## Return the dataframe
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