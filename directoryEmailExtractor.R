library(XML)
setwd("J:/R")
data <- htmlTreeParse("directoryUrls.html", useInternal=T)

data.names = unlist(xpathApply(data, '//tr', xmlValue))
data.urls = unlist(xpathApply(data, "//tr/td/a[@class='lnk']", xmlGetAttr, '_e_onclick'))

startchar <- nchar("openItmRdFm(\"AD.RecipientType.User\",\"")+1
stopchar <- regexpr("==",data.urls)-1
VAR <- substr(data.urls,startchar,stopchar)

library(httr)

for (i in VAR){
    tempi <- URLencode(i)
    tempurl <- paste0("https://mail.nycboe.net/owa/?ae=Item&a=Open&t=AD.RecipientType.User&id=",tempi,"%3d%3d","&pspid=_1435159383854_73335102")
    tempdat <- GET(tempurl,authenticate("bgunton","jul2015!"))
    page <- htmlTreeParse(tempdat, useInternal=T)
}

# i <- VAR[100]
setInternet2(use = TRUE)
tempurl2 <- paste0("http://","bgunton",":","jul2015!","@","mail.nycboe.net/owa/?ae=Item&a=Open&t=AD.RecipientType.User&id=",tempi,"%3d%3d","&pspid=_1435159383854_73335102")
page <- htmlTreeParse(tempurl2, useInternal=T)
handle <- handle(tempurl)
login <- list(username='bgunton', password  = 'jul2015!')
response <- POST(handle = handle, body = login)


