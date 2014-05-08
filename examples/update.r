#!/usr/bin/env r 
#
# a simple example to update packages in /usr/local/lib/R/site-library
# parameters are easily adjustable

## adjust as necessary, see help('download.packages')
repos <- "http://cran.rstudio.com" 

## or use BioC's repo list if Biobase is installed:
#suppressMessages(rc <- require(Biobase))
#if (rc) {
#  repos <- Biobase:::biocReposList()
#}

## this makes sense on Debian where no package touch /usr/local
lib.loc <- "/usr/local/lib/R/site-library"

## simply unrolling of all unlink over all files 'repos*' in $TMP
clearCache <- function() {
  sapply(list.files(path=tempdir(), pattern="*rds$", full.names=TRUE), unlink)
}

## Always clear caches of remote and local packages
clearCache()

## r use requires non-interactive use
update.packages(repos=repos, ask=FALSE, lib.loc=lib.loc)

## Always clear caches of remote and local packages
clearCache()
