## littler [![Build Status](https://travis-ci.org/eddelbuettel/littler.png)](https://travis-ci.org/eddelbuettel/littler)    [![License](http://img.shields.io/badge/license-GPL%20%28%3E=%202%29-brightgreen.svg?style=flat)](http://www.gnu.org/licenses/gpl-2.0.html) [![CRAN](http://www.r-pkg.org/badges/version/littler)](http://cran.r-project.org/package=littler) [![Downloads](http://cranlogs.r-pkg.org/badges/littler?color=brightgreen)](http://www.r-pkg.org/pkg/littler)

A scripting and command-line front-end for GNU R permitting use of R in
command-line contexts.

### So What Does it Do?

```r
#!/usr/bin/env r              ## for use in scripts

other input | r               ## for use in pipes

r somefile.R                  ## for running files

r -e 'expr'                   ## for evaluating expressions

r --help                      ## to show a quick synopsis
```

See the
[examples vignette](https://cran.r-project.org/web/packages/littler/vignettes/littler-examples.html)
for a full set of introductory examples. Also 
see the
[examples/ directory](https://github.com/eddelbuettel/littler/tree/master/inst/examples),
as well as maybe the
[older tests directory](https://github.com/eddelbuettel/littler/tree/master/inst/script-tests)
both of which are installed with the package.

### Installation

#### Version 0.3.0 or later

The package resides on the CRAN network and can be installed via

```
install.packages("littler")
```

#### Previous Versions up to 0.2.3 

In general, simply running the script `bootstrap` will configure and build the
executable. Running `make install` (possibly as `sudo make install`) will
install the resulting binary.

On Linux systems, ensure you have the `autotools-dev` package (or its
equivalent on non-Debian/Ubuntu systems).  On OS X, you may need to run `brew
install automake autoconf` to get all the tools. 

#### Alternate Naming

On some operating systems such as OS X, `r` is not different from `R`.  As
this risk confusing the main binary `R` for the R system with our smaller
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

* [Dirk's littler page](http://dirk.eddelbuettel.com/code/littler.html)
* [Dirk's page with littler examples](http://dirk.eddelbuettel.com/code/littler.examples.html)

(but note that the latter now overlaps with the
[example vignette](https://cran.r-project.org/web/packages/littler/vignettes/littler-examples.html)).

### Authors

Jeff Horner and Dirk Eddelbuettel

### License

GPL (>= 2)



