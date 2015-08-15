meanCalculator <- function(x) {
  y <- rnorm(100)
  mean(y)
}

noisy <- function(x) {
   x + rnorm(length(x))
}

vectorAnalysis <- function(x) {
 y <- c(1.7, "a")
 y <- c(TRUE, 2)
 y <- c("a", TRUE)
}

test1 <- function(x) {
  x <- c("a","b","c")
  x
  y <- 0:6
  y
  z <- list(1,"a",TRUE, 1+4i)
  z
}

matrixTest <- function() {
  m1 <- matrix(nrow = 2, ncol = 3)
  m1
  dim(m1)
  attributes(m1)
  ## matrix created column-wise
  m <- matrix(1:6, nrow = 2, ncol = 3)
  m
}

transformVector2Matrix <- function() {
  m1 <- 1:10
  m1
  dim(m1) <- c(2,5)
  m1
}
