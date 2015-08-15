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

  my_vector <- 1:20
// now change it to matrix format with 4 rows , 5 cols
dim(my_vector) <- c(4, 5)
dim(my_vector)
4 5

> attributes(my_vector)
$dim
[1] 4 5

> my_vector
[,1] [,2] [,3] [,4] [,5]
[1,]    1    5    9   13   17
[2,]    2    6   10   14   18
[3,]    3    7   11   15   19
[4,]    4    8   12   16   20

class(my_vector)
matrix

matrix(1:20, 4, 5)
///////
  patients <- c(Bill, "Gina", "Kelly", "Sean")

  cbind() function to 'combine columns'

> cbind(patients, my_matrix)
patients                       
[1,] "Bill"   "1" "5" "9"  "13" "17"
[2,] "Gina"   "2" "6" "10" "14" "18"
[3,] "Kelly"  "3" "7" "11" "15" "19"
[4,] "Sean"   "4" "8" "12" "16" "20"

This means we're left with a matrix of character strings, which is no
| good.
////////////////
  >>  matrices can only contain ONE class of data.
  my_data <- data.frame(patients, my_matrix)

how to include the names of our patients in the table without destroying the integrity of our numeric data
/////

cnames <- c("patient", "age", "weight", "bp", "rating", "test")
colnames(my_data) <- cnames

object.size(plants)

head(plants, 10)

summary()
/// generaate sample data  :

four six-sided dice: sample(1:6, 4, replace = TRUE)

sample 4 numbers between 1 to 6

//// 100 flips of unfair 2-sided coins .... 0.3 for tails, 0.7 for heads 
flips <- sample(c(0,1), 100, replace = TRUE, prob = c(0.3, 0.7))

sum(flips)

A coin flip is a binary outcome (0 or 1) and we are performing 100
| independent trials (coin flips), so we can use use rbinom() to simulate a
| binomial random variable.

the number of heads in 100 flips of our unfair coin 
=>  rbinom(1, size = 100, prob = 0.7)  ~  71

flips2 <- rbinom(100, size = 1, prob = 0.7)

If ‘mean’ or ‘sd’ are not specified they assume the default values of ‘0’ and ‘1’, respectively.

The normal distribution has density  f(x) = 1/(sqrt(2 pi) sigma) e^-((x - mu)^2/(2 sigma^2)) 

>>>>  rnorm(10, mean = 100, sd = 25)

my_pois <- replicate(100, rpois(5, 10))
cm <- colMeans(my_pois)
Looks like our column means are almost normally distributed, right? That's
| the Central Limit Theorem at work

exponential (rexp()), chi-squared (rchisq()), gamma (rgamma())


/// Simulation
lattice, ggplo
