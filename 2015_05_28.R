df <- read.csv("J:/R/working_file_20150528.csv")

library(dplyr)
library(ggplot2)
library(gridExtra)

dat <- tbl_df(df)
dat <- dat %>%
    mutate(earnofatt = earn_tot / attempt_tot) %>%
    filter(sex != "", type != "Transfer", pso1415 == 1)

##

# femhist <- ggplot(dat[dat$sex=="F",], aes(x = earnofatt, y = ..count.. / sum(..count..) )) + geom_histogram(bin=.025) + ylim(0.0,0.5) + labs(title = "Distribution of Credit Earn Rates by Gender", y = "% of Female Students", x="")
# malhist <- ggplot(dat[dat$sex=="M",], aes(x = earnofatt, y = ..count.. / sum(..count..) )) + geom_histogram(bin=.025) + ylim(0.0,0.5) + labs(y = "% of Male Students", x = "Credit Earn Rate")
ggplot(dat, aes(x = earnofatt)) + geom_histogram(bin=.025) + labs(y = "% of Students", x = "Credit Earn Rate") + theme_bw() + facet_grid(sex ~ .)

##

dat3 <- dat %>% 
    group_by(sex, eth) %>%
    summarise(avg = mean(earnofatt, na.rm=T))

# ggplot(dat3, aes(x = sex, y = avg / nlevels(eth), fill=factor(sex))) + geom_bar(stat="identity") + ylim(0,1) + theme_bw() + labs(title = "Credits Earned of Attempted by Gender", fill = "Gender",y = "Avg. Credit Earn Rate", x="Gender")
# ggplot(dat3, aes(x = eth, y = avg / (nlevels(sex) - 1), fill=factor(eth))) + geom_bar(stat="identity") + ylim(0,1) + theme_bw() + labs(title = "Credits Earned of Attempted by Gender", fill = "Ethnicity",y = "Avg. Credit Earn Rate", x="Ethnicity") + theme(axis.text.x = element_text(angle = 90, hjust = 1))

ggplot(dat3, aes(x = eth, y = avg, fill=factor(eth))) + geom_bar(stat="identity") + ylim(0,1) + theme_bw() + facet_grid(sex ~ .) + theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = .25))

##

dat2 <- dat %>%
    mutate(sexeth = interaction(sex,eth)) %>%
    group_by(termstructuresy1415, sexeth, classof) %>%
    summarise(avg = mean(attempt_tot, na.rm=T), num = n()) %>%
    filter(num >= 20, classof >= 2015 & classof <= 2018)

ggplot(dat2, aes(x = sexeth, y = avg)) + geom_bar(stat="identity") + labs(x = "Gender x Ethnicity (n >= 20)", y="Avg. Credits Attempted", title="Avg. Credits Attempted vs. Gender and Ethnicity by Term Structure and Cohort") + facet_grid(classof ~ termstructuresy1415, scales="free_y") + theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = .25))
