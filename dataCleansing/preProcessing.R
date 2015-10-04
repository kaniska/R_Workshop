getItemVals <- function() {
  
  print('a1')
  
  if(!file.exists("data")) {
    dir.create("data")
  }
  print('a2')

  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
  download.file(fileUrl, destfile = "./data/community.csv", method = "curl")
  data <- read.csv("./data/community.csv")
  property_values <- data[,"VAL"]
  
  return(property_values[!is.na(property_values)])
}


main <- function() {
  vals <- getItemVals()
  print(sum(vals > 23))
}
