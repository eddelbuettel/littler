
## These tests were suggested by a user on OS X, and then promptly
## failed on OS X per CRAN -- so we now make this conditional on Linux
## where it is known to work

if (unname(Sys.info()["sysname"]) == "Linux") {
    library(littler)
    stopifnot(identical(littler:::test(), "4"))   # default test is cat(2+2)
    stopifnot(as.numeric(littler:::test('cat(R.version$year)')) >= 2015)  
}
