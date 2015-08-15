# Loop Char sequence
x <- c(“a” , “b” , “c” , “d” )
for(i in seq_along(x)) {
    print(x)
}
# Loop 2
for(i in 1:4) {
  print(x[i])
}
# Loop Matrix
x <- matrix(1:6, 2 , 3)
for(i in seq_len(nrow(x))) {
     for(j in seq_len(ncol(x))) {
            print(x[i,j])
     }
}
# Loop random binomials
while(z >= 3 && z <= 10) {
  coin <- rbinom(1,1, 0.5)
  if (coin == 1) {
     z <- z + 1
  } else {
      z <- z - 1
  }
}
# Loop 4
x0 <- 1
t01  <-  le - 8
repeat {
   x1 <- computeEstimate()
   if(abs(x1 - x0) < t01)  {
       break
   } else {
       x0 <-  x1
   }
}
#
columnmean <- function(y) {
  nc <- ncol(y)
  means <- numeric(nc)
  for(i in 1:nc) {
    means[i] <- mean(y[,i], na.rm = removeNA)
  }
  means
}
#
