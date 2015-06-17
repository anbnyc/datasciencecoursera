###### How to Load an Excel File into R ######
##
## These instructions adapt the procedure the NV Data Scientists discussed on Friday 4/17/15
## 
##

## Install the XL Connect package -- you only need to do this ONCE, after which you can comment it out
install.packages("XLConnect")

## This you have to run every time
library(XLConnect)

## This is optional, but will show you the commands available in this library
ls("package:XLConnect")

## Load the workbook into R, saving it to the object wb. 
## If you havent set your working directory, provide the full file path, e.g. "J:/R_folder/test_workbook.xlsx"
wb <- loadWorkbook("<!!!CHANGE ME!!!>")

## Read the sheets into R by looping over the sheets in wb. Create a data.frame per sheet called myData_<sheetname>
numSheets <- length(getSheets(wb))
for (i in 1:numSheets){
    tempData <- readWorksheet(wb,sheet=i,header=TRUE)
    tempName <- paste("myData",getSheets(wb)[i],sep="_")
    assign(tempName,tempData)
}
rm(tempData, tempName, i, numSheets)
