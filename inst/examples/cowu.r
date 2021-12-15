#!/usr/bin/env r
#
# Minimal rhub windown UCRT check wrapper
#
# Copyright (C) 2016 - 2021  Dirk Eddelbuettel
#
# Released under GPL (>= 2)

checkargs <- "--no-manual --no-vignettes"
checkfile <- function(f) if (file.exists(f)) rhub::check(f, platform="windows-x86_64-devel-ucrt", check_args=checkargs)
if (length(argv) == 0) argv <- "."
sapply(argv, checkfile)
