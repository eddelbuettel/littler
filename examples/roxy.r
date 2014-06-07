#!/usr/bin/r
suppressMessages(library(roxygen2))
roxygenize(".", roclets="rd")
