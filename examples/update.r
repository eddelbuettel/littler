#!/usr/bin/env r
#
# a simple example to update packages in /usr/local/lib/R/site-library
# parameters are easily adjustable

## adjust as necessary, see help('download.packages')
repos <- "http://cran.r-project.org"  
#stopifnot(require(methods, quiet=TRUE))        ## S4 methods needed for Biobase
#repos <- Biobase:::biocReposList()

# Always re-generate the available.packages() cache
cache <- file.path(tempdir(),
                   paste("repos_", URLencode(repos, TRUE), "*.rds", sep=""))
unlink(cache)

## this makes sense on Debian where no package touch /usr/local
lib.loc <- "/usr/local/lib/R/site-library"

# Always re-generate the available.packages() cache
cache <- file.path(tempdir(),
                   paste("repos_", URLencode(repos, TRUE), "*.rds", sep=""))
unlink(cache)

## r use requires non-interactive use
update.packages(repos=repos, ask=FALSE, lib.loc=lib.loc)
