install.packages("swirl")
## Provide a makeCacheMatrix to create a cacheableMatrix
## cacheableMatrix <-  makeCacheMatrix(square_matrix_input)

makeCacheMatrix <- function(input = matrix()) {
  m <- NULL
  set <- function(x) {
    input <<- x
    m <<- NULL
  }
  get <- function() input
  setInverse <- function(inverse) m <<- inverse
  getInverse <- function() m
  list(set = set, get = get,
       setInverse = setInverse,
       getInverse = getInverse)
}


## Provide cacheSolve to fetch the Inverse of cachebaleMatrix

cacheSolve <- function(input, ...) {
  m <- input$getInverse()
  if(!is.null(m)) {
    message("fetch cached data")
    return(m)
  }
  # Create the inverted matrix when the cached matrix is not available.
  data <- input$get()
  m <- solve(data, ...)
  input$setInverse(m)
  m
}
