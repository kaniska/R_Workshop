# R_Workshop
Learning R through examples

## Example 1 :
The zip file contains 332 comma-separated-value (CSV) files containing pollution monitoring data for fine particulate matter (PM) air pollution at 332 locations in the United States. Each file contains data from a single monitor and the ID number for each monitor is contained in the file name. For example, data for monitor 200 is contained in the file "200.csv". Each file contains three variables:
Date: the date of the observation in YYYY-MM-DD format (year-month-day)
sulfate: the level of sulfate PM in the air on that date (measured in micrograms per cubic meter)
nitrate: the level of nitrate PM in the air on that date (measured in micrograms per cubic meter)

## Example 2 :

### Caching the Mean of a Vector
<<- operator  can be used to assign a value to an object in an environment that is different from the current environment. we have to write two functions that are used to create a special object that stores a numeric vector and cache's its mean.

source()
1. create a square matrix
> seq1 <- seq(1:4)
> m1 <- matrix(seq1,2)
> m1
     [,1] [,2]
[1,]    1    3
[2,]    2    4

2. create a cacheable matrix
> cm1 <- makeCacheMatrix(m1)

3. fetch the inverse matrix from cache
> im1 <- cacheSolve(cm1)
> im1
     [,1] [,2]
[1,]   -2  1.5
[2,]    1 -0.5

4. verify if result is correct
> im2 <- solve(m1)
> im2
     [,1] [,2]
[1,]   -2  1.5
[2,]    1 -0.5
> 

## Example 3 :
"loop functions"  , "system functions" , "simulation functions"
