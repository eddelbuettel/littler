#!/usr/bin/env r
#
# A downloader for Pandoc's amd64 .deb
#
# Copyright (C) 2021  Dirk Eddelbuettel
#
# Released under GPL (>= 2)
#
# TODO: Maybe make the .deb filter an option

library(RcppSimdJson)

url <- "https://api.github.com/repos/jgm/pandoc/releases/latest"
res <- RcppSimdJson::fload(url)
files <- res$assets[, "browser_download_url"]
deb <- files[grepl("-amd64\\.deb$", files)]
tgt <- file.path("/tmp", basename(deb))
download.file(deb, tgt, quiet=TRUE)
cat("Downloaded '", deb, "' as '", tgt, "'\n", sep="")
