## Generic Fucntion
myplot <- function(x,y, mytype = "1" , ....) {
  plot(x,y,type = mytype, ...)
}
######
lm <- function(x) { x * x }
lm
######
g <- function(x) {
  x*y
}
y <- 10
f <- function(x) {
  y <- 2
  y^2 + g(x)
}
######## 
f <- function(x) {
  g <- function(y) {
    y + z
  }
  z <- 4
  x + g(x)
}
f(3) will return 10
#######
find.power <- function(n){
    pow <- function(x) {
      x^n
    }
    pow
}
#######
make.NetLogLH <- function(data, fixed=c(FALSE,FALSE)) {
  params <- fixed
  function(p){
     params[!fixed] <- p
     mu <- params[1]
     sigma <- params[2]
     a <- -0.5*length(data)*log(2*pi*sigma^2)
     b <- -0.5*length(data-mu)^2 / (sigma^2)
     -(a+b)
  }
}
######
set.seed(1); normals <- rnorm(100, 1, 2)
nLL <- make.NetLogLH(normals)

//// plotting likelihood
nLL <- make.NetLogLH(normals, c(1, FALSE))
x <- seq(1.7, 1.9, len = 100)
y <- sapply(x, nLL)
plot(x, exp(-(y - min(y))), type = "l")

nLL <- make.NetLogLH(normals, c(FALSE, 2))
x <- seq(0.5, 1.5, len = 100)
y <- sapply(x, nLL)
plot(x, exp(-(y - min(y))), type = "l")
######
# Problem 2.
x <- 1:10
if(x > 5) {
    x <- 0
} # warning
# Problem 3.
f <- function(x) {
    g <- function(y) {
        y + z
    }
    z <- 4
    x + g(x)
}
z <- 10
f(3) # 10
# Problem 4.
x <- 5
y <- if(x < 3) {
    NA
} else {
    10
}
y # 10
# Problem 5.
h <- function(x, y = NULL, d = 3L) {
    z <- cbind(x, d)
    if(!is.null(y))
        z <- z + y
    else
        z <- z + f
    g <- x + y / z
    if(d == 3L)
        return(g)
    g <- g + 10
    g
}
# free variable: f
f <- function(x, y) {
    x^2 + y / z
} # free variable: z
# Problem 6.
# environment: a collection of symbol/value pair.
# Problem 7.
# type of scoping rule for resolving free variables: Lexical scoping
# Problem 8.
# free variables in R functions are resolved by:
# The values of free variables are searched for in the environment 
# in which the function was defined.
# Problem 9.
# one of the consequences of the scoping rules used in R:
# All objects must be stored in memory.
# Problem 10.
# parent theme: it is the environment in which a function was called.
