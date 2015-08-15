best <- function(state, outcome) {
  #Invalid outcome input type
  if (!outcome %in% c("heart attack", "heart failure", "pneumonia")) {
    stop("invalid outcome")
  }
  
  #Get index for our given outcome string.
  index <- ifelse(outcome == "heart attack", 11, ifelse(outcome == "heart failure", 17, 23))
  
  #Read and coerce our dataset while suppressing warnings and removing NA's.
  data <- read.csv("outcome-of-care-measures.csv", colClasses="character")
  data[,index] <- suppressWarnings(as.numeric(data[,index]))
  data <- na.omit(data)
  
  #Invalid state input or no observations
  states <- table(data$State)
  if (!state %in% names(states)) { 
    stop("invalid state")
  }
  
  #Slice our data by the given state and sort it by outcome and hospital name.
  slice <- subset(data, State==state)
  slice <- slice[order(slice[,index], na.last=TRUE),2]
  slice <- na.omit(slice)
  
  #Get hospital name with the lowest 30-day mortality rate.
  slice[1]
}