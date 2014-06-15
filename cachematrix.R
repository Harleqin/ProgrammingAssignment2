## These functions implement a simple mechanism for caching the
## inverse of matrices.

## Creates a matrix wrapper object (actually a closure) that can cache
## its inverse.  Any modification of the wrapped matrix needs to be
## recorded through the set function in order to correctly invalidate
## the cache.

makeCacheMatrix <- function (x = matrix()) {
    inverse <- NULL
    get <- function () {
        x
    }
    set <- function (y) {
        x <<- y
        inverse <<- NULL
    }
    setinverse <- function (inv) {
        inverse <<- inv
    }
    getinverse <- function () {
        inverse
    }
    list (get = get,
          set = set,
          setinverse = setinverse,
          getinverse = getinverse)
}


## Given a cacheMatrix (see makeCacheMatrix above), returns its
## inverse.  If the inverse is already cached, the cached value
## is used, otherwise the inverse is calculated and cached before
## returning it.

cacheSolve <- function (x, ...) {
    cached <- x$getinverse ()
    if (is.null (cached)) {
        cached <- solve (x$get ())
        x$setinverse (cached)
    }
    cached
}
