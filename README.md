## littler: A scripting and command-line front-end for GNU R

[![CI](https://github.com/eddelbuettel/littler/workflows/ci/badge.svg)](https://github.com/eddelbuettel/littler/actions?query=workflow%3Aci)
[![License](https://img.shields.io/badge/license-GPL%20%28%3E=%202%29-brightgreen.svg?style=flat)](https://www.gnu.org/licenses/gpl-2.0.html)
[![CRAN](https://www.r-pkg.org/badges/version/littler)](https://cran.r-project.org/package=littler)
[![r-universe](https://eddelbuettel.r-universe.dev/badges/littler)](https://eddelbuettel.r-universe.dev/littler)
[![Dependencies](https://tinyverse.netlify.app/badge/littler)](https://cran.r-project.org/package=littler)
[![Downloads](https://cranlogs.r-pkg.org/badges/littler?color=brightgreen)](https://www.r-pkg.org/pkg/littler)
[![Last Commit](https://img.shields.io/github/last-commit/eddelbuettel/littler)](https://github.com/eddelbuettel/littler)
[![Documentation](https://img.shields.io/badge/documentation-is_here-blue)](https://eddelbuettel.github.io/littler/)

### So What Is It For?

```r
#!/usr/bin/env r              ## for use in scripts

other input | r               ## for use in pipes

r somefile.R                  ## for running files

r -e 'expr'                   ## for evaluating expressions

r --help                      ## to show a quick synopsis
```

### Examples?

Plenty. See the [examples vignette](https://cran.r-project.org/package=littler/vignettes/littler-examples.html)
for a full set of introductory examples. Also
see the [examples/ directory](https://github.com/eddelbuettel/littler/tree/master/inst/examples) for a full 28
example scripts, as well as maybe the
[older tests directory](https://github.com/eddelbuettel/littler/tree/master/inst/script-tests)
both of which are installed with the package.

Some scripts I use daily or near daily (in alphabetical order):

```
build.r                                ## builds from the current directory
c4c.r                                  ## submits current directory to winbuilder
compAttr.r                             ## run compileAttributes() for a Rcpp package
dratInstert.r 1.2-3.tar.gz -r /srv     ## inserts package into drat repo
install.r abc def                      ## installs packages abc and def
install.r abc_1.2-3.tar.gz             ## installs given tarball
install2.r -l /tmp/lib abc def         ## installs abc and def into /tmp/lib
rcc.r abc_1.2-3.tar.gz                 ## run's R CMD check via Gabor's rcmdcheck
render.r foo.Rmd                       ## calls rmarkdown::render()
roxy.r                                 ## run roxygenize() for a package (only Rd creation)
update.r                               ## updates any currently installed packages
```

### Installation

#### Version 0.3.0 or later

The package resides on the CRAN network and can be installed via

```
install.packages("littler")
```

Note that the package states `OS_type: unix`. It works great on all Linux
variants, with a naming caveat on macOS (see below and the [FAQ
vignettes](https://github.com/eddelbuettel/littler/blob/master/vignettes/littler-faq.md))
and not at all on Windows (but could be ported just like
[RInside](https://github.com/eddelbuettel/rinside) has been--the two show
architectural similarities).

#### Previous Versions up to 0.2.3

In general, simply running the script `bootstrap` will configure and build the
executable. Running `make install` (possibly as `sudo make install`) will
install the resulting binary.

On Linux systems, ensure you have the `autotools-dev` package (or its
equivalent on non-Debian/Ubuntu systems).  On OS X, you may need to run `brew
install automake autoconf` to get all the tools.

#### Alternate Naming

On some operating systems such as OS X, `r` is not different from `R`.  As
this risks confusing the main binary `R` for the R system with our smaller
scripting frontend `r`, we suggest to consider running `configure
--program-prefix="l"` which this leads to installation of a binary `lr`
instead of `r`.

#### Alternate R Version

As littler uses autoconf its `AC_PATH_PROG()` macro to find `R`, one can
simply adjust the `PATH` when calling `configure` (or, rather, `bootstrap`)
to have another version of R used. For example, on a server with R-devel in
this location, the following builds littler using this R-devel version:
`PATH="/usr/local/lib/R-devel/bin/:$PATH" ./bootstrap`.

### More Information

For more information about littler, please see

* [Dirk's littler page](https://dirk.eddelbuettel.com/code/littler.html)
* [Dirk's page with littler examples](https://dirk.eddelbuettel.com/code/littler.examples.html)

(but note that the latter now overlaps with the
[example vignette](https://cran.r-project.org/package=littler/vignettes/littler-examples.html)).

### Authors

Jeff Horner (2006 to 2008) and Dirk Eddelbuettel (since 2006)

### License

GPL (>= 2)
