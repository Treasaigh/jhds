# Overall function: given a square matrix, this will create an object that stores the
# original matrix, computes its inverse matrix, and stores the inverse matrix to be
# accessible without needing to compute it repeatedly from the original square matrix.

# Create a special matrix object that holds the passed matrix, its computed inverse,
# and enclosed functions to access the enclosed data computed.
makeCacheMatrix <- function(x = matrix()) {
    mi <- NULL
    set <- function(y) {
        x <<- y
        mi <<- NULL
    }
    get <- function() x
    setinv <- function(matinv) mi <<- matinv
    getinv <- function() mi
    list(set = set, get = get,
         setinv = setinv,
         getinv = getinv)
}

# returns the inverse of the cached matrix-like object instantiated above.
# If the inverse has already been computed, that value is accessed and returned.
# If the inverse has not yet been computed: it is computed, stored in the 
# cache object, and then returned.
cacheSolve <- function(x, ...) {
    mi <- x$getinv()
    if(!is.null(mi)) {
        message("getting cached data")
        return(mi)
    }
    data <- x$get()
    mi <- solve(data, ...)
    x$setinv(mi)
    mi
}

