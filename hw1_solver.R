## prereq for Questions 11-20
hw1 <- read.csv("J:/R/hw1_data.csv")

## 11
hw1[0,]

## 12
hw1[1:2,]

## 13
## look at Environment tab/window

## 14
hw1[152:153,]

## 15
ozone <- hw1[,1]
ozone[47]

## alt 15
ozone1 <- list(hw1[1:153,1])
ozone1[[1]][47]

ozone2 <- hw1[1]
ozone2$Ozone[47]

## 16
bad <- is.na(ozone)
sum(bad)

## 17
mean(ozone[!bad])

## 18
subset <- hw1[ which(hw1$Ozone > 31 & hw1$Temp > 90),]
mean(subset$Solar.R)

## 19 - this uses a similar method to 18 but combines the steps by referring to the Temp column by its number (4)
mean(hw1[ which(hw1$Month == 6),4])

## 20
max(hw1[ which(hw1$Month == 5 & is.na(hw1$Ozone) == FALSE),1])