#!/usr/bin/env r
#
# A simple example to do operations on files
#
# Copyright (C) 2014  Dirk Eddelbuettel
#
# Released under GPL (>= 2)

## read files
files <- dir("..", full.names=TRUE)

## creation time as Date
ctimes <- as.Date(file.info(files)$ctime)

## select based on time window -- something arbitrary
now <- Sys.Date()
## these are appromiximative, could be refined using DateTimeClasses
sixmon <- now - 365.25/2
twelvemon <- now - 365.2

ind <- ctimes >= twelvemon & ctimes <= sixmon

if (sum(ind) > 0) {
    cat("The following files are between six and twelve months old\n")
    print(files[ind])
}

## do something
##   print(files[ind])
## or rename / move to subdir
##   mkdir("newDir")
##   file.rename(files[ind], "newDir")
## can also use gsub() etc to rename
