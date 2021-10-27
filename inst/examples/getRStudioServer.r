#!/usr/bin/env r
#
# A simple example to install RStudio Desktop
#
# Copyright (C) 2014 - 2021  Carl Boettiger and Dirk Eddelbuettel
#
# Released under GPL (>= 2)
#
# based on earlier https://raw.githubusercontent.com/rocker-org/rstudio-daily/master/latest.R
#
# todo: cmdline options for different download options

#suppressMessages(library(rvest))

setwd("/tmp")                           # go to /tmp

#url <- "https://dailies.rstudio.com/rstudioserver/oss/ubuntu/amd64/"
#url <- "https://dailies.rstudio.com/rstudioserver/oss/ubuntu/x86_64/"
url <- "https://dailies.rstudio.com/rstudio/latest/index.json"
#pg <- read_html(url(url))
#tb <- html_table(html_nodes(pg, "table"))[[1]]
js <- jsonlite::fromJSON(url)
#file <- tb[[1,1]]
#s3url <- "https://s3.amazonaws.com/rstudio-ide-build/server/bionic/amd64/"
#s3url <- "https://s3.amazonaws.com/rstudio-ide-build/server%2Fbionic%2Famd64%2F"
#fileurl <- paste0(s3url, file)
#fileurl <- paste0(s3url, gsub("\\+","%2B", file))
#cat("'", fileurl, "' -> '", file, "'\n", sep="")
fileurl <- js$products$server$platforms$bionic$link
file <- basename(fileurl)
cat("'", url, "' -> '", file, "'\n", sep="")
download.file(fileurl, file) #, method="wget")

## possibly simpler
## cf https://support.rstudio.com/hc/en-us/articles/203842428-Getting-the-newest-RStudio-builds
## fileurl <- "https://www.rstudio.org/download/latest/stable/server/ubuntu64/rstudio-server-latest-amd64.deb"
#download.file(fileurl, "rstudio-server-latest-amd64.deb", method="wget")
