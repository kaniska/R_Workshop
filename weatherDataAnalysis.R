#  Analysis for R Quiz 1 -- Coursera R course

x <- read.csv("hw1_data.csv")
head(x)
print(x[1:2,])
dim(x)
print(x[152:153,])
print(x$Ozone[47])
summary(x$Ozone)
# What is the mean of the Ozone column in this dataset? Exclude missing values (coded as NA) from this calculation.
mean(na.exclude(x$Ozone))
# How many missing values are in the Ozone column of this data frame?

y <- x[x$Ozone > 31 & x$Temp > 90, ]
mean(na.exclude(y$Solar.R))
# Extract the subset of rows of the data frame where Ozone values are above 31 and Temp values are above 90. What is the mean of Solar.R in this subset?
mean(na.exclude(x$Solar.R[x$Ozone > 31 & x$Temp > 90]))
# What is the mean of "Temp" when "Month" is equal to 6?
mean(na.exclude(x$Temp[x$Month == 6]))
# What was the maximum ozone value in the month of May (i.e. Month = 5)?
max(na.exclude(x$Ozone[x$Month == 5]))
x <- 1:4
y <- 2:3
z <- x + y
#
factors <- function(x) {
  colMeans(x)
  x <- subset(data, Ozone > 1 & Temp > 90)
}
