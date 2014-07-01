testid <- matrix(data=rep(1,9), nrow=3, ncol=3)
testid
testid_c <- makeCacheMatrix(testid)
cacheSolve(testid_c)

testid_c$get()
testid_c$getinv()



testrand <- matrix(data=rnorm(9), nrow=3, ncol=3)
testrand
solve(testrand)
testrand_c <- makeCacheMatrix(testrand)
cacheSolve(testrand_c)
testrand_c$get()
testrand_c$getinv()


testbig <- matrix(data=rnorm(10000), nrow=100, ncol=100)
testbig
solve(testbig)
testbig_c <- makeCacheMatrix(testbig)
cacheSolve(testbig_c)
identical(cacheSolve(testbig_c), solve(testbig))
identical(testbig_c$getinv(), solve(testbig))
identical(testbig, testbig_c$get())











