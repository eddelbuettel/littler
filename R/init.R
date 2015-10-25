
.onAttach <- function(libname, pkgname) {
    packageStartupMessage("The littler package provides 'r' as a binary.")
    if (unname(Sys.info()["sysname"]) == "Linux") {
        if (unname(Sys.which("r")) == "") {
            packageStartupMessage("You could link to the 'r' binary installed in\n'",
                                  system.file("bin", "r", package="littler"),
                                  "' from '/usr/local/bin' in order to use 'r' for scripting.")
        }
    }
}
