### Version 0.3.12 (2020-10-04)

-   Changes in examples

    -   Updates to scripts `tt.r`, `cos.r`, `cow.r`, `c4r.r`, `com.r`

    -   New script `installDeps.r` to install dependencies

    -   Several updates tp script `check.r`

    -   New script `installBSPM.r` and `installRSPM.r` for binary
        package installation (Dirk and Iñaki in
        [\#81](https://github.com/eddelbuettel/littler/pull/81))

    -   New script `cranIncoming.r` to check in Incoming

    -   New script `urlUpdate.r` validate URLs as R does

-   Changes in package

    -   Travis CI now uses BSPM

    -   A package documentation website was added

    -   Vignettes now use `minidown` resulting in *much* reduced
        filesizes: from over 800kb to under 50kb (Dirk in
        [\#83](https://github.com/eddelbuettel/littler/pull/83))

### Version 0.3.11 (2020-06-26)

-   Changes in examples

    -   Scripts `check.r` and `rcc.r` updated to reflect updated
        `docopt` 0.7.0 behaviour of quoted arguments

    -   The `roxy.r` script has a new ease-of-use option `-f | --full`
        regrouping two other options.

### Version 0.3.10 (2020-06-02)

-   Changes in examples

    -   The `update.r` script only considers writeable directories.

    -   The `rcc.r` script tries to report full logs by setting
        `_R_CHECK_TESTS_NLINES_=0`.

    -   The `tt.r` script has an improved `ncpu` fallback.

    -   Several installation and updating scripts set `_R_SHLIB_STRIP_`
        to `TRUE`.

    -   A new script `installBioc.r` was added.

    -   The `--error` option to `install2.r` was generalized (Sergio
        Oller in
        [\#78](https://github.com/eddelbuettel/littler/pull/78)).

    -   The `roxy.r` script was extended a little.

-   Changes in package

    -   Travis CI now uses R 4.0.0 and the bionic distro

### Version 0.3.9 (2019-10-27)

-   Changes in examples

    -   The use of `call.` in `stop()` was corrected (Stefan Widgren in
        [\#72](https://github.com/eddelbuettel/littler/pull/72)).

    -   New script `cos.r` to check (at rhub) on Solaris.

    -   New script `compactpdf.r` to compact pdf files.

    -   The `build.r` script now compacts vignettes and resaves data.

    -   The `tt.r` script now supports parallel tests and side effects.

    -   The `rcc.r` script can now report error codes.

    -   The \'--libloc\' option to `update.r` was updated.

    -   The `render.r` script can optionally compact pdfs.

    -   New script `sweave.r` to render (and compact) pdfs.

    -   New script `pkg2bibtex.r` to show bibtex entries.

    -   The `kitten.r` script has a new option `--puppy` to add
        `tinytest` support in purring packages.

### Version 0.3.8 (2019-06-09)

-   Changes in examples

    -   The `install.r` and `install2.r` scripts now use parallel
        installation using `options{Ncpu}` on remote packages.

    -   The `install.r` script has an expanded help text mentioning the
        environment variables it considers.

    -   A new script `tt.r` was added to support `tinytest`.

    -   The rhub checking scripts now all suppress builds of manual and
        vignettes as asking for working latex appears to be too much.

-   Changes in package

    -   On startup checks if `r` is in `PATH` and if not references new
        FAQ entry; text from `Makevars` mentions it too.

-   Changes in documentation

    -   The FAQ vignette now details setting `r` to `PATH`.

### Version 0.3.7 (2019-03-15)

-   Changes in examples

    -   The scripts `installGithub.r` and `install2.r` get a new option
        `-r | --repos` (Gergely Daroczi in
        [\#67](https://github.com/eddelbuettel/littler/pull/67))

-   Changes in build system

    -   The `AC_DEFINE` macro use rewritten to please R CMD check.

### Version 0.3.6 (2019-01-26)

-   Changes in examples

    -   The scripts `install.r` and `install2.r` now support argument
        `"."`, and add it if called in a source directory.

    -   The script `install2.r` can set `Ncpus` for `install.packages()`
        (Colin Gillespie in
        [\#63](https://github.com/eddelbuettel/littler/pull/63) fixing
        [\#62](https://github.com/eddelbuettel/littler/pull/62))

    -   The script `update.r` can also set `Ncpus` for
        `install.packages()`.

    -   A new vignette \"litter-faq\" was added.

### Version 0.3.5 (2018-10-04)

-   Changes in examples

    -   The script `roxy.r` now uses a cached copy of `roxygen2` version
        6.0.1 (if available) as the current version 6.1.0 changed
        behaviour.

    -   The script `rcc.r` was updated as the underlying `rcmdcheck`
        changed parameter order.

    -   A new simpler wrapper `rchk.r` was added to use RHub with the
        `rchk` image.

-   Changes in package

    -   Travis CI now uses the R 3.5 PPA

### Version 0.3.4 (2018-08-24)

-   Changes in examples

    -   The shebang line is now `#!/usr/bin/env r` to work with either
        `/usr/local/bin/r` or `/usr/bin/r`.

    -   New example script to only install packages not yet installed
        (Brandon Bertelsen in
        [\#59](https://github.com/eddelbuettel/littler/pull/59)); later
        added into `install2.r`.

    -   Functions `getRStudioDesktop.r` and `getRStudioServer.r` updated
        their internal URLs.

    -   Several minor enhancements were made to example scripts.

### Version 0.3.3 (2017-12-17)

-   Changes in examples

    -   The script `installGithub.r` now correctly uses the `upgrade`
        argument (Carl Boettiger in
        [\#49](https://github.com/eddelbuettel/littler/pull/49)).

    -   New script `pnrrs.r` to call the package-native registration
        helper function added in R 3.4.0

    -   The script `install2.r` now has more robust error handling (Carl
        Boettiger in
        [\#50](https://github.com/eddelbuettel/littler/pull/50)).

    -   New script `cow.r` to use R Hub\'s `check_on_windows`

    -   Scripts `cow.r` and `c4c.r` use `#!/usr/bin/env r`

    -   New option `--fast` (or `-f`) for scripts `build.r` and `rcc.r`
        for faster package build and check

    -   The `build.r` script now defaults to using the current directory
        if no argument is provided.

    -   The RStudio getters now use the `rvest` package to parse the
        webpage with available versions.

-   Changes in package

    -   Travis CI now uses https to fetch script, and sets the group

### Version 0.3.2 (2017-02-14)

-   Changes in examples

    -   New scripts `getRStudioServer.r` and `getRStudioDesktop.r` to
        download daily packages, currently defaults to Ubuntu amd64

    -   New script `c4c.r` calling `rhub::check_for_cran()`

    -   New script `rd2md.r` to convert Rd to markdown.

    -   New script `build.r` to create a source tarball.

    -   The `installGitHub.r` script now use package
        [[remotes]{.pkg}](https://CRAN.R-project.org/package=remotes)
        (PR [\#44](https://github.com/eddelbuettel/littler/pull/44),
        [\#46](https://github.com/eddelbuettel/littler/pull/46))

### Version 0.3.1 (2016-08-06)

-   Changes in examples

    -   `install2.r` now passes on extra options past `--` to
        `R CMD INSTALL` (PR
        [\#37](https://github.com/eddelbuettel/littler/pull/37) by
        Steven Pav)

    -   Added `rcc.r` to run `rcmdcheck::rcmdcheck()`

    -   Added (still simple) `render.r` to render (R)markdown

    -   Several examples now support the `-x` or `--usage` flag to show
        extended help.

-   Changes in build system

    -   The `AM_LDFLAGS` variable is now set and used too (PR
        [\#38](https://github.com/eddelbuettel/littler/pull/38) by
        Mattias Ellert)

    -   Three more directories, used when an explicit installation
        directory is set, are excluded (also
        [\#38](https://github.com/eddelbuettel/littler/pull/38) by
        Mattias)

    -   Travis CI is now driven via `run.sh` from our fork, and deploys
        all packages as .deb binaries using our PPA where needed

-   Changes in package

    -   SystemRequirements now mentions the need for `libR`, i.e. an R
        built with a shared library so that we can embed R.

    -   The [[docopt]{.pkg}](https://CRAN.R-project.org/package=docopt)
        and
        [[rcmdcheck]{.pkg}](https://CRAN.R-project.org/package=rcmdcheck)
        packages are now suggested, and added to the Travis
        installation.

    -   A new helper function `r()` is now provided and exported so that
        the package can be imported (closes
        [\#40](https://github.com/eddelbuettel/littler/issues/40)).

    -   URL and BugReports links were added to DESCRIPTION.

-   Changes in documentation

    -   The help output for `installGithub.r` was corrected (PR
        [\#39](https://github.com/eddelbuettel/littler/pull/39) by
        Brandon Bertelsen)

### Version 0.3.0 (2015-10-29)

-   Changes in build system

    -   First CRAN Release as R package following nine years of source
        releases

    -   Script `configure`, `src/Makevars.in` and remainder of build
        system rewritten to take advantage of the R package build
        infrastructure

    -   Reproducible builds are better supported as the (changing)
        compilation timestamps etc are only inserted for \'verbose
        builds\' directly off the git repo, but not for Debian (or CRAN)
        builds off the release tarballs

-   Changes in littler functionality

    -   Also source `$R_HOME/etc/Rprofile.site` and `~/.Rprofile` if
        present

-   Changes in littler documentation

    -   Added new vignette with examples
