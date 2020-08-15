#!/usr/bin/env r
#
# Minimal rhub::check_on_macos() wrapper
#
# Copyright (C) 2016 - 2020  Dirk Eddelbuettel
#
# Released under GPL (>= 2)

##rhub::check_on_macos(check_args="--no-manual --no-vignettes")
## cf https://github.com/r-hub/rhub/issues/368
macos <- "macos-highsierra-release-cran"
checkfile <- function(f) if (file.exists(f)) rhub::check(f, platform=macos)
if (length(argv) == 0) argv <- "."
sapply(argv, checkfile)
