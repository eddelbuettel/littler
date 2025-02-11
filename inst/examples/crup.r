#!/usr/bin/env -S r -t
#
# upload to cran
#
# Copyright (C) 2025  Dirk Eddelbuettel
#
# Inspired by devtools::upload_cran() from which it takes parts and remixes
# them here.  Released under the same license as that file (ie MIT) or under
# GPL (>= 2) like the rest of this package, at your chooosing.

if (!requireNamespace("httr", quietly=TRUE))
    stop("Please install 'httr' from CRAN.", call. = FALSE)
if (!requireNamespace("whoami", quietly=TRUE))
    stop("Please install 'whoami' from CRAN.", call. = FALSE)

## load docopt from CRAN
suppressMessages({
    library(docopt)               # we need docopt (>= 0.3) as on CRAN
})

## defaults
author <- whoami::fullname()
email <- whoami::email_address()

## configuration for docopt
doc <- paste0("Usage: crup.r [-h] [-x] [-a AU] [-e EM] [ARG]

-a --author AU      author name to use [default: ", author, "]
-e --email EM       email to use [default: ", email, "]
-h --help           show this help text
-x --usage          show help and short example usage")

opt <- docopt(doc)			# docopt parsing

if (opt$usage) {
    cat(doc, "\n\n")
    cat("where ARG is a (source) package.

Examples:
  crup.r abc_1.2-3.tar.gz             # upload package

crup.r is part of littler which brings 'r' to the command-line.
See https://dirk.eddelbuettel.com/code/littler.html for more information.\n")
    q("no")
}

if (is.null(opt$ARG)) {
    q("no")
}

if (!file.exists(opt$ARG)) {
    stop("No file '", opt$ARG, "' found. Existing.", call. = FALSE)
}


msg <- list(pkg_id = "",
            name = author,
            email = email,
            uploaded_file = httr::upload_file(argv[1], "application/x-gzip"),
            upload = "Upload package")

res <- httr::POST("https://xmpalantir.wu.ac.at/cransubmit/index2.php", body = msg)

httr::stop_for_status(res)
url <- httr::parse_url(res$url)

msg2 <- list(pkg_id = url$query$pkg_id,
             name = author,
             email = email,
             policy_check = "1/",
             submit = "Submit package")
res2 <- httr::POST("https://xmpalantir.wu.ac.at/cransubmit/index2.php", body = msg2)

httr::stop_for_status(res2)
url2 <- httr::parse_url(res2$url)

if (url2$query$submit == "1") {
    cat("Package submission complete. See incoming email for confirmation link.\n")
} else {
    stop("Upload failed.", call. = FALSE)
}
