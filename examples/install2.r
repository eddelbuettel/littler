#!/usr/bin/env r
#
# a simple example to install one or more packages

## load getopt package from CRAN, or stop if getopt not available
suppressWarnings(stopifnot(require(getopt, quietly=TRUE)))

## default values
repos <- "http://cran.rstudio.com"		# RStudio CDN, "local everywhere"
lib.loc <- "/usr/local/lib/R/site-library"	# on Debian where no packages touch /usr/local
package <- ""

## option specification
options <- matrix(c('repos',   'r', 1, "character",
                    paste0("repository to install from, default is '", repos, "'"),
                    'libloc',  'l', 1, "character",
                    paste0("library location to use, default is '", lib.loc, "'"),
                    'help'   , 'h', 0, "logical", "help on options",
                    'package', 'p', 1, "character",
                    "mandatory argument for package to install"),
                  ncol=5,
                  byrow=TRUE)

## parse argv
opt <- getopt(options, opt=argv)

if (!is.null(opt$help)) {
    ## use default text
    cat(getopt(options, opt=argv, command="install.r", usage=TRUE))
    q(status=100)
}

repos   <- ifelse(is.null(opt$repos), repos, opt$repos)
lib.loc <- ifelse(is.null(opt$libloc), lib.loc, opt$libloc)
package <- ifelse(is.null(opt$package), package, opt$package)

if (nchar(package)==0) {
    cat("No package argument supplied, exitiing.  See 'install.r -h|--help' for usage.\n")
    q(status=101)
}

install.packages(package, lib.loc, repos, dependencies=TRUE)
q(status=0)
