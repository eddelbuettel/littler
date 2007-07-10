#!/usr/bin/env r
#
# a simple example to update packages in /usr/local/lib/R/site-library
# parameters are easily adjustable

## adjust as necessary, see help('download.packages')
repos <- "http://cran.r-project.org"  

## this makes sense on Debian where no package touch /usr/local
lib.loc <- "/usr/local/lib/R/site-library"

# Always clear available.packages() cache of remote and local files
clearCache <- function(repos, lib.loc) {
  remotecf <- file.path(tempdir(),
                        paste("repos_", URLencode(contrib.url(repos), TRUE),
                              ".rds", sep=""))
  if (file.exists(remotecf)) {
    #cat("Removing remote cache file\n")
    unlink(remotecf)
  }
  localcf <- file.path(tempdir(),
                       paste("libloc_", URLencode(lib.loc, TRUE),
                             "Version,Priority,Bundle,Contains,",
                             "Depends,Imports,Suggests,Built.rds",
                             sep=""))
  if (file.exists(localcf)) {
    ##cat("Removing local cache file\n")
    unlink(localcf)
  }
}

## Always clear caches of remote and local packages
clearCache(repos, lib.loc)

## r use requires non-interactive use
update.packages(repos=repos, ask=FALSE, lib.loc=lib.loc)

## Always clear caches of remote and local packages
clearCache(repos, lib.loc)
