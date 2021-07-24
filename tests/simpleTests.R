
## These tests were suggested by a user on OS X (in 2015), and then
## promptly failed on OS X per CRAN -- so we now make this conditional
## on Linux where it is known to work
##
## Until it doesn't as it appears to (in 2020) fail on Travis CI

if (unname(Sys.info()["sysname"]) == "Linux" &&
    Sys.getenv("TRAVIS", "false") != "true"  &&
    Sys.getenv("CI", "false") != "true") {
    stopifnot(file.exists(littler:::r()))
    stopifnot(length(system2(littler:::r(), "--version", stdout=TRUE)) > 10) # 14 lines
    stopifnot(identical(littler:::test(), "4"))   # default test is cat(2+2)
    stopifnot(as.numeric(littler:::test('cat(R.version$year)')) >= 2015)
}
