##      Argument:  x
##      Return:  list

createVector <- function(x = numeric()) {          
        #  Argument x is a numeric vector
        m <- NULL  #  Assigns m the value NULL in the local environment
        set <- function(y) {
                x <<- y  #  Assigns the numeric vector x the value of the argument y in the parent environment
                m <<- NULL  #  Assigns m the value NULL in the parent environment -- if set is called, m is NULL
        }
        get <- function() x  #  If get() is called, the value of x the numeric vector is returned
        setmean <- function(vm) {
                m <<- vm  #  If setmean() is called, m is assigned the value of argument vm from the parent environment
        }
        getmean <- function() m  #  If getmean() is called, m is returned
        list(set = set, get = get,  #  Puts all 4 functions in a list; returns the list
             setmean = setmean,
             getmean = getmean)
}

cachemean <- function(x, ...) {
        #  cachemean() returns mean of vector created above in makeVector
        #  if mean was already calculated, it returns the cached mean
        #  if mean wasn't already calculated, this function will calculate and return it
        #  argument x is the vector created by makeVector()   
        m <- x$getmean()  #  Assigns the value of m from makeVector function to q; either NULL or non-NULL
        if(!is.null(m)) {
                message("getting cached data")
                return(m)  #  If q is not null, i.e., mean already exists, q is returned along with text
        }
        data <- x$get()  #  Gets the data, i.e., the x argument to makeVector(x)
        m <- mean(data, ...)  #  Calculates the mean of the x argument to makeVector(x)
        x$setmean(m)  #  This is the cache step; assigns the value of q to m
        m  #  Returns m
}

v <- createVector(1:60)
ls(environment(v$setmean))
t <- cachemean(v)
t
