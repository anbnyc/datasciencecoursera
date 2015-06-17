setwd("J:/R")
resi <- read.csv("fakeRESI.csv")
d114 <- read.csv("fake_114_20150601.csv")
library(dplyr)

resi <- tbl_df(resi)
d114 <- tbl_df(d114)

fulldata <- inner_join(resi,d114,by="StudentID")
fulldata <- tbl_df(fulldata)
subset <- filter(fulldata, CO.YR=="R") %>%
    mutate(subject = substr(Course,1,2)) %>%
    filter(subject == "HG") %>%
    arrange(desc(Year), desc(Term)) %>%
    rename(CourseCode = Course) %>%
    mutate(flag = ifelse(Credits >= 0.5,"Pass","Fail")) %>%
    group_by(flag)

summarize(subset, num = n(), avg = mean(Mark))

table(droplevels(subset$CourseCode))

head(subset, 6)
tail(subset, 6)

