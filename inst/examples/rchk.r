#!/usr/bin/env r
#
# Minimal rhub::check() wrapper using rchk()
#
# Copyright (C) 2016 - 2019  Dirk Eddelbuettel
#
# Released under GPL (>= 2)

rhub::check(".", "ubuntu-rchk", check_args="--no-manual --no-vignettes")
