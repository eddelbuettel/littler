#!/usr/bin/env r 
##
##  Retrieve R_HOME information
##
##  See help(R.home) for details, use arguments "bin", "lib", "etc", ...
##
##
##  Note that in shell scripts you may want something like
##
##     ## Set R_HOME, respecting an environment variable if set
##     : ${R_HOME=$(R RHOME)}
##
##  after which expansions use as in   ${R_HOME}/bin/Rscript   works
##
##  In Makefiles you want a similar use via a shell call:
##
##     ${R_HOME}/bin/Rscript
##
##  as R_HOME is already set with an 'R CMD ...' call (!!). On Windows
##  do something like
##
##     PKG_LIBS = $(shell "${R_HOME}/bin${R_ARCH_BIN}/Rscript.exe" -e "RcppGSL:::LdFlags()")
##
##  to pick up the architecture flag
##
##
##  Copyright (C) 2015         Dirk Eddelbuettel
##
##  Released under GPL (>= 2)

if (is.null(argv) | length(argv) < 1) argv <- "home"

cat(sapply(argv, R.home)))
