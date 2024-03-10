
.onAttach <- function(libname, pkgname) {
    packageStartupMessage("The littler package provides 'r' as a binary.")
    packageStartupMessage("See 'vignette(\"littler-examples\") for several usage illustrations,")
    packageStartupMessage("and see 'vignette(\"littler-faq\") for some basic questions.")
    if (Sys.info()[["sysname"]] %in% c("Linux", "Darwin")) { # nocov start
        if (unname(Sys.which("r")) == "") {
            loc <- system.file(if (nzchar(.Platform$r_arch)) file.path("bin", .Platform$r_arch) else "bin", "r", package="littler")
            packageStartupMessage("You could link to the 'r' binary installed in\n'", loc, "'\n",
                                  "from '/usr/local/bin' in order to use 'r' for scripting.",
                                  "See the 'vignette(\"littler-faq\")' for more details.")
        if (Sys.info()[["sysname"]] == "Darwin")
            packageStartupMessage("On OS X, 'r' and 'R' are the same so 'lr' is a possible alternate name for littler.")
        } # nocov end
    }
}
