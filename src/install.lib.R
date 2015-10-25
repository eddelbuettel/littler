
#files <- Sys.glob(paste0("*", SHLIB_EXT))
#dest <- file.path(R_PACKAGE_DIR, paste0('libs', R_ARCH))
#dir.create(dest, recursive = TRUE, showWarnings = FALSE)
#file.copy(files, dest, overwrite = TRUE)
#if(file.exists("symbols.rds"))
#    file.copy("symbols.rds", dest, overwrite = TRUE)

## #execs <- c("one", "two", "three")
## execs <- c("r")
## # if (WINDOWS) execs <- paste0(execs, ".exe")
## if (any(file.exists(execs))) {
##     dest <- file.path(R_PACKAGE_DIR,  paste0('bin', R_ARCH))
##     dir.create(dest, recursive = TRUE, showWarnings = FALSE)
##     file.copy(execs, dest, overwrite = TRUE)
## }

## #shlib <- file.path(R_PACKAGE_DIR, paste0('libs', R_ARCH))
## #if (dir.exists(shlib)) {
## #    cat("Removing ", shlib)
## #    unlink(shlib, recursive=TRUE, force=TRUE)
## #}

    
