#### BE CAREFUL ABOUT RUNNING LINE 3 - you can de-comment it as you see fit.  
### re: line 3  -  what does this do?  And why or why wouldn't you want to run this?
# rm(list=ls())
# if(!file.exists("J:/Credits_boxplot")){
#     dir.create("J:/Credits_boxplot")
# }
##Set working directory you might need to change
setwd("J:/R/")
### used stata to outsheet variables into a .csv file  - download from Drive to that directory see "File to download"
masterFile <- read.csv("credits_20150519.csv", header = TRUE, sep =",")
ls(masterFile)
### explore the file a bit  - what questions do you have?  - We will pause here as a group. 
uxtype <-unique(masterFile$type)
masterFile$newTerm <- ifelse(masterFile$type == "Transfer", "trnsfr", masterFile$termstructuresy1415)
masterFile$schTerm <- interaction(masterFile$newTerm,masterFile$sn) 
### What does this do?  
masterFileHS <- masterFile[which(!is.na(masterFile$classof) & masterFile$pso1415==1 & masterFile$flag_101== 1 &  masterFile$flag_rdes== 1 & masterFile$classof>=2015 & masterFile$classof <=2018), ]
print(uxtype)
uxclassof <-unique(masterFileHS$classof)
## install.packages("ggplot2")
library("ggplot2")
masterFileHS2018 <- masterFileHS[which(masterFileHS$classof == 2018), ]
#### aes in the below function stands for aesthetics, what does reorder() do here?   try running without reorder. 
c2018 <- ggplot(masterFileHS2018, aes( y=current_tot, x=reorder(schTerm,current_tot,median), fill=factor(newTerm))) + geom_boxplot() + coord_flip()

c2018 + labs(title = "Cohort 2018 - Current Enrolled Credits Box Plot", x = "Terms.School Name", y = "Current Enrolled Total Credits", fill = "# of Terms") + theme(panel.background = element_rect(colour = "black"),legend.key = element_rect(fill = "light gray"))
ggsave(file = "c_2018.pdf")

### Challenge  - write a loop that saves one per cohort for cohorts 2015, 2016, 2017 and 2018. 
for (i in uxclassof){
    nowDf <- masterFileHS[which(masterFileHS$classof == i), ]
    nowPlot <- ggplot(nowDf, aes( y=current_tot, x=reorder(schTerm,current_tot,median), fill=factor(newTerm))) + geom_boxplot() + coord_flip()
    nowPlot + labs(title = paste("Cohort",i,"- Current Enrolled Credits Box Plot",sep=" "), x = "Terms.School Name", y = "Current Enrolled Total Credits", fill = "# of Terms") + theme(panel.background = element_rect(colour = "black"),legend.key = element_rect(fill = "light gray"))
    # ggsave(file = paste("Class",i,".pdf",sep=""))
}

# install.packages("gridExtra")
library(gridExtra)
for (i in uxclassof){
    nowDf <- masterFileHS[which(masterFileHS$classof == i), ]
    nowPlot <- ggplot(nowDf, aes( y=current_tot, x=reorder(schTerm,current_tot,median), fill=factor(newTerm))) + geom_boxplot() + coord_flip()
    nowPlot <- nowPlot + labs(title = paste("Cohort",i,"- Current Enrolled Credits Box Plot",sep=" "), y = "Current Enrolled Total Credits") + theme(panel.background = element_rect(colour = "black"))
    if (i == uxclassof[1]) { 
        nowPlot <- nowPlot + labs(fill = "# of Terms", x = "") + theme(legend.key = element_rect(fill = "light gray"))
    } else if (i == max(uxclassof)) {
        nowPlot <- nowPlot + guides(fill=FALSE) + labs(x = "Terms.School Name")
    } else {
        nowPlot <- nowPlot + guides(fill=FALSE) + labs(x = "")
    }
    assign(paste("nowPlot",i,sep=""), nowPlot)
}
allclasses <- arrangeGrob(nowPlot2018, nowPlot2017, nowPlot2016, nowPlot2015, ncol = 4, nrow = 1)
ggsave(file = "allClasses.pdf", plot = allclasses, width=34, height = 11, limitsize=F)

### Challenge 2 - How can you change the appearance of the box plot, perhaps changing the visual format (see theme() arguments for example.