
.onAttach <- function(libname, pkgname) {
    packageStartupMessage("The littler package provides 'r' as a binary.")
    if (Sys.info()[["sysname"]] == "Linux") {
        if (unname(Sys.which("r")) == "") {
            packageStartupMessage("You could link to the 'r' binary installed in\n'",
                                  system.file("bin", "r", package="littler"),
                                  "' from '/usr/local/bin' in order to use 'r' for scripting.")
        }
    }
    if (Sys.info()[["sysname"]] == "Darwin") {
        packageStartupMessage("On OS X, 'r' and 'R' are the same so 'lr' is an alternate name for littler.")
        if (unname(Sys.which("lr")) == "") {
            packageStartupMessage("You could link to the 'r' binary installed in\n'",
                                  system.file("bin", "r", package="littler"),
                                  "' as '/usr/local/bin/lr' in order to use 'lr' for scripting.")
        }
    }
}
