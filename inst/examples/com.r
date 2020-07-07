#!/usr/bin/env r
#
# Minimal rhub::check_on_macos() wrapper
#
# Copyright (C) 2016 - 2020  Dirk Eddelbuettel
#
# Released under GPL (>= 2)

##rhub::check_on_macos(check_args="--no-manual --no-vignettes")
## cf https://github.com/r-hub/rhub/issues/368
rhub::check(path=".", platform="macos-highsierra-release-cran")
            #check_args=c("--no-manual", "--no-vignettes"))
