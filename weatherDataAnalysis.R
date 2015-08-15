#  Analysis for R Quiz 1 -- Coursera R course

x <- read.csv("hw1_data.csv")
head(x)
print(x[1:2,])
dim(x)
print(x[152:153,])
print(x$Ozone[47])
summary(x$Ozone)
mean(na.exclude(x$Ozone))
y <- x[x$Ozone > 31 & x$Temp > 90, ]
mean(na.exclude(y$Solar.R))
mean(na.exclude(x$Solar.R[x$Ozone > 31 & x$Temp > 90]))
mean(na.exclude(x$Temp[x$Month == 6]))
max(na.exclude(x$Ozone[x$Month == 5]))
x <- 1:4
y <- 2:3
z <- x + y
