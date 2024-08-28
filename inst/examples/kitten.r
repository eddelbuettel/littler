#!/usr/bin/env r

library(docopt)

## configuration for docopt
doc <- "Usage: kitten.r [-t TYPE] [-b] [-p] [-h] [-x] PACKAGE

-t --type TYPE      type of kitten: plain, rcpp, arma, eigen. [default: plain]
-b --bunny	    install roxygen2 documentation example and roxygenize (only for plain)
-p --puppy	    invoke tinytest::puppy to set up testing (only for plain)
-h --help           show this help text
-x --usage          show help and short example usage"

opt <- docopt(doc)			# docopt parsing

if (opt$usage) {
    cat(doc, "\n\n")
    cat("Examples:
  kitten.r

kitten.r is part of littler which brings 'r' to the command-line.
See http://dirk.eddelbuettel.com/code/littler.html for more information.\n")
    q("no")
}

haswhoami <- requireNamespace("whoami", quietly=TRUE)
author <- if (haswhoami) whoami::fullname("Your Name") else "Your Name"
email <- if (haswhoami) whoami::email_address("your@email.com") else "your@email.com"

## maybe support path, author, maintainer, email, license, ...
ign <- switch(opt$type,
              plain = pkgKitten::kitten(opt$PACKAGE, author=author, email=email,
                                        puppy=opt$puppy, bunny=opt$bunny),
              rcpp = Rcpp::Rcpp.package.skeleton(opt$PACKAGE, author=author, email=email),
              arma = RcppArmadillo::RcppArmadillo.package.skeleton(opt$PACKAGE),
              eigen = RcppEigen::RcppEigen.package.skeleton(opt$PACKAGE))

if (opt$puppy) {
    stopifnot(requireNamespace("tinytest", quietly=TRUE))
    tinytest::puppy(opt$PACKAGE)
}
