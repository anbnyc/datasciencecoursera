setwd("J:/R/data")
outreach <- read.csv("outreach.csv")
ratr <- read.csv("ratr.csv")

#### This tells us the values of attd   "A" and "L"  = attended  = 1; "I"  = "Incomplete" we will drop; "R" does not count in denominator we will drop 
table(ratr$attd)
ratr <-ratr[which(ratr$attd!='R' & ratr$attd!='I'),] ##EDIT

###### Why does I and R still appear even if they don't have any values.
table(droplevels(ratr$attd)) ##EDIT
ratr$present <- ifelse(ratr$attd != "A", 1,0)
table(droplevels(ratr$attd), ratr$present) ##EDIT
names(outreach)
class(ratr$school.day)
head(ratr$school.day)
#install.packages("lubridate")
library(lubridate)
ratr$date <- mdy(ratr$school.day) ##EDIT
class(ratr$date)
head(ratr$date)

#### move to other data set
class(outreach$date.of.absence)
head(outreach$date.of.absence)
outreach$date <- ymd(outreach$date.of.absence) ##EDIT
class(outreach$date)
head(outreach$date) 
class(ratr$student.id)
class(outreach$student.id)
# mergedset <- merge(x = ratr, y = outreach, by=c("student.id","date"), all.x=TRUE)
mergedset2 <- merge(x = ratr, y = outreach, by=c("student.id","date"))
# mergedset$hasoutreach <- ifelse(!is.na(mergedset$username), 1,0)
mergedset2$hasoutreach <- ifelse(!is.na(mergedset2$username), 1,0)
table(mergedset$username, mergedset$hasoutreach, useNA="ifany") ##GroupEDIT
table(mergedset2$username, mergedset2$hasoutreach)

sum(grepl("[Ss][Ii][Cc][Kk]", mergedset$notes)) ##EDIT
sum(grepl("[Ss][Ii][Cc][Kk]", mergedset2$notes)) ##EDIT

mergedset$sick <- grepl("[Ss][Ii][Cc][Kk]", mergedset$notes)
#mergedset$sick2 <- grep("[Ss][Ii][Cc][Kk]", mergedset$notes) ##GroupEDIT Not actually useful
sicklist <- grep("[Ss][Ii][Cc][Kk]", mergedset$notes)
sick2list <- grep("[Ss][Ii][Cc][Kk]", mergedset2$notes)

#mergedset$notes <- tolower(mergedset$notes)    how would this code translate. 
table(mergedset$date)
library(dplyr)

### create a before and after intervention YTD attendance. 
beforeint <- mergedset[which(mergedset$date <"2015-02-09"), ]
afterint <- mergedset[which(mergedset$date >="2015-02-09"), ]
# ints <- c("beforeint", "afterint") ## not used

beforeint <- tbl_df(beforeint)
before <- group_by(beforeint, student.id) %>%
    summarise(attd = mean(present), outreach = sum(hasoutreach))

afterint <- tbl_df(afterint)
after <- group_by(afterint, student.id) %>%
    summarise(attd = mean(present), outreach = sum(hasoutreach), outbin = ceiling(sum(hasoutreach)/20))

# before <- tapply(beforeint$present, beforeint$student.id, mean)
# before <- data.frame(key=names(before), value=before)
# after <- tapply(afterint$present, afterint$student.id, mean)
# after <- data.frame(key=names(after), value=after)

mergeapply <- merge(x = before, y = after, by="student.id", all.x=TRUE)
mergeapply$change = (mergeapply$attd.y - mergeapply$attd.x) / mergeapply$attd.x

## These are poorly done summary stats
mean(beforeint$present, na.rm=T)
mean(afterint$present, na.rm=T)

summary(before$attd)
summary(after$attd)

## These are good summary stats
by(mergeapply$attd.x, mergeapply$outbin, function(x) summary(x))
by(mergeapply$attd.y, mergeapply$outbin, function(x) summary(x))
table(after$outbin)
table(as.factor(after$outreach))

library(ggplot2)

ggplot(data = mergeapply, aes(x = factor(outreach.y), y = change)) + geom_boxplot() + scale_y_continuous(limits=c(-1,1))
ggplot(data = mergeapply, aes(x = factor(outbin), y = change)) + geom_boxplot() + scale_y_continuous(limits=c(-1,1))

head(arrange(mergeapply, desc(change)))


