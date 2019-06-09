#!/usr/bin/env r
#
# Minimal rhub::check_for_cran() wrapper
#
# Copyright (C) 2016 - 2019  Dirk Eddelbuettel
#
# Released under GPL (>= 2)

rhub::check_for_cran(check_args="--no-manual --no-vignettes")
