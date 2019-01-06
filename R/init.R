
.onAttach <- function(libname, pkgname) {
    packageStartupMessage("The littler package provides 'r' as a binary.")
    packageStartupMessage("See 'vignette(\"littler-examples\") for several usage illustrations,")
    packageStartupMessage("and see 'vignette(\"littler-faq\") for some basic questions.")
    if (Sys.info()[["sysname"]] == "Linux") {
        if (unname(Sys.which("r")) == "") { # nocov start
            packageStartupMessage("You could link to the 'r' binary installed in\n'",
                                  system.file("bin", "r", package="littler"), "'\n",
                                  "from '/usr/local/bin' in order to use 'r' for scripting.")
        } # nocov end
    }
    if (Sys.info()[["sysname"]] == "Darwin") { # nocov start
        packageStartupMessage("On OS X, 'r' and 'R' are the same so 'lr' is an alternate name for littler.")
        if (unname(Sys.which("lr")) == "") {
            packageStartupMessage("You could link to the 'r' binary installed in\n'",
                                  system.file("bin", "r", package="littler"), "'\n",
                                  "as '/usr/local/bin/lr' in order to use 'lr' for scripting.")
        }
    } # nocov end
}
