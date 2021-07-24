## Internal, not exported, function used by unit tests
test <- function(src = "cat(2 + 2)") {
    system2(r(), paste("-e", shQuote(src)), stdout = TRUE)
}


##' Return the path of the install \code{r} binary.
##'
##' The test for Windows is of course superfluous as we have no binary for Windows.
##' Maybe one day...
##' @title Return Path to \code{r} Binary
##' @param usecat Optional toggle to request output to stdout (useful in Makefiles)
##' @return The path is returned as character variable. If the \code{usecat} option is
##' set the character variable is displayed via \code{\link{cat}} instead.
##' @author Dirk Eddelbuettel
r <- function(usecat=FALSE) {
    p <- file.path(system.file(package="littler"),
                   "bin",
                   paste0("r", ifelse(.Platform$OS.type=="windows", ".exe", "")))
    if (usecat) return(cat(p)) # nocov
    p
}
