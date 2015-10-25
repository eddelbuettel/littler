## littler [![Build Status](https://travis-ci.org/eddelbuettel/littler.png)](https://travis-ci.org/eddelbuettel/littler) [![License](http://img.shields.io/badge/license-GPL%20%28%3E=%202%29-brightgreen.svg?style=flat)](http://www.gnu.org/licenses/gpl-2.0.html)

A scripting and command-line front-end for GNU R permitting use of R in
command-line contexts.

### Installation

#### Version 0.3.0 or later

_Once the package hits a [drat](http://dirk.eddelbuettel.com/code/drat.html)
repository_, just run

```
install.packages("littler")
```

#### Versions up to 0.2.3 

In general, simply running the script `bootstrap` will configure and build the
executable. Running `make install` (possibly as `sudo make install`) will
install the resulting binary.

On Linux systems, ensure you have the `autotools-dev` package (or its
equivalent on non-Debian/Ubuntu systems).  On OS X, you may need to run `brew
install automake autoconf` to get all the tools. 

#### Alternate naming

On some operating systems such as OS X, `r` is not different from `R`.  As
this risk confusing the main binary `R` for the R system with our smaller
scripting frontend `r`, we suggest to consider running `configure
--program-prefix="l"` which this leads to installation of a binary `lr`
instead of `r`.

#### Alternate R version

As littler uses autoconf its `AC_PATH_PROG()` macro to find `R`, one can
simply adjust the `PATH` when calling `configure` (or, rather, `bootstrap`)
to have another version of R used. For example, on a server with R-devel in
this location, the following builds littler using this R-devel version:
`PATH="/usr/local/lib/R-devel/bin/:$PATH" ./bootstrap`. 

### More Information

For more information about littler, please see

* [Dirk's main littler page](http://dirk.eddelbuettel.com/code/littler.html)
* [Dirk's page with littler examples](http://dirk.eddelbuettel.com/code/littler.examples.html)

### Authors

Jeff Horner and Dirk Eddelbuettel

### License

GPL (>= 2)



