#!/usr/bin/env r
#
# Minimal rhub::check_for_cran() wrapper
#
# Copyright (C) 2016 - 2020  Dirk Eddelbuettel
#
# Released under GPL (>= 2)

checkargs <- "--no-manual --no-vignettes"
checkfile <- function(f) if (file.exists(f)) rhub::check_for_cran(f, check_args=checkargs)
if (length(argv) == 0) argv <- "."
sapply(argv, checkfile)
