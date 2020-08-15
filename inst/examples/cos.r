#!/usr/bin/env r
#
# Minimal rhub(".", platform="solaris-x86-patched")
#
# Copyright (C) 2016 - 2020  Dirk Eddelbuettel
#
# Released under GPL (>= 2)

#checkargs <- "--no-manual --no-vignettes"
solaris <- "solaris-x86-patched"
checkfile <- function(f) if (file.exists(f)) rhub::check(f, platform=solaris)#, check_args=checkargs)
if (length(argv) == 0) argv <- "."
sapply(argv, checkfile)
