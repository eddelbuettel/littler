#!/usr/bin/env r
#
# Minimal 'Deadline' field printer from CRAN db
#
# Copyright (C) 2024  Dirk Eddelbuettel
#
# Released under GPL (>= 2)

db <- as.data.frame(tools::CRAN_package_db())
dd <- with(db, db[!is.na(Deadline), c("Package", "Version", "Deadline")])
dd <- with(dd, dd[order(Deadline, Package), ])
print(dd, row.names=FALSE)
