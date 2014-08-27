#!/usr/bin/env r

## read files
files <- dir("/some/directory", full.names=TRUE)

## creation time as Date
ctimes <- as.Date(file.info(files)$ctime)

## select based on time window
ind <- ctimes >= as.Date("2013-01-01") & ctimes <= as.Date("2013-01-31")

## do something
##   print(files[ind])
## or rename / move to subdir
##   mkdir("newDir")
##   file.rename(files[ind], "newDir")
## can also use gsub() etc to rename
