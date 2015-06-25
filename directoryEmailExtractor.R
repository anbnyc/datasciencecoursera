library(XML)
setwd("J:/R")
data <- htmlTreeParse("directoryUrls.html", useInternal=T)

data.names = unlist(xpathApply(data, '//tr', xmlValue))
data.urls = unlist(xpathApply(data, "//tr/td/a[@class='lnk']", xmlGetAttr, '_e_onclick'))

startchar <- nchar("openItmRdFm(\"AD.RecipientType.User\",\"")+1
stopchar <- regexpr("==",data.urls)-1
VAR <- substr(data.urls,startchar,stopchar)

library(httr)

data <- vector()
for (i in VAR){
    tempi <- paste0("https://mail.nycboe.net/owa/?ae=Item&a=Open&t=AD.RecipientType.User&id=",i,"%3d%3d","&pspid=_1435159383854_73335102")
    tempurl <- URLencode(tempi)
    temppage <- htmlTreeParse(tempurl, useInternal=T)
    tempdata = unlist(xpathApply(temppage,"//div[@class='fld']",xmlValue))
    data <- rbind(data,tempdata)
}
# i <- VAR[100]

## Following this example: http://stackoverflow.com/questions/24723606/scrape-password-protected-website-in-r
handle <- handle("https://mail.nycboe.net/")
path <- "owa/auth.owa"
login <- list(
    username = "#"
    ,password = "#"
    ,destination = "https://mail.nycboe.net/owa/auth.owa"
)
response <- POST(handle = handle, path = path, body = login)
page <- htmlTreeParse(response, useInternal=T)
page

## Following the documentation:
response <- POST("https://mail.nycboe.net/owa/auth.owa", authenticate("#","#"), encode = "form", verbose())
page <- htmlTreeParse(response, useInternal=T)
page
