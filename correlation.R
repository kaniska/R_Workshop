correlation <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations
  ## NOTE: Do not round the result!
  files_list <- list.files(directory, full.names=TRUE)  #creates a list of files
  dat <- data.frame()  #creates an empty dataframe for csv files
  d2 <- data.frame()  #creates an empty dataframe for current csv file
  x <- 1   # sets my vector variable to so it counts every time the if is TRUE
  corobs <- c()  #creates an empty vector for all correlated observations
  for (i in 1:332) {
    #loops trhough the files, rbinding them together
    d2 <-  read.csv(files_list[i]) #reads the csv with the current value in "id"
    comp_obs <- d2[complete.cases(d2[2:3]),] #removes rows with NA in 2nd or 3rd columns
    nobs <- nrow(comp_obs) # counts the rows of complete observations
    if ((nobs != 0) && (nobs >= threshold)) {   # checks if threshold is met
      corobs[x] <- cor(comp_obs[2], comp_obs[3]) #correlate sulfate and nitrate
      x <- (x+1) # variable to go to next element in vector
    }
  }
  return(corobs)
}
