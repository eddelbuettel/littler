#!/usr/bin/env r 
#
# A simple example to update packages in /usr/local/lib/R/site-library
# Parameters are easily adjustable
#
# Copyright (C) 2006 - 2015  Dirk Eddelbuettel
#
# Released under GPL (>= 2)

## adjust as necessary, see help('download.packages')
## littler can now read ~/.littler.r and /etc/littler.r to set this
repos <- getOption("repos")

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
