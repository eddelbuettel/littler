# littler

[![Build Status](https://travis-ci.org/eddelbuettel/littler.png)](https://travis-ci.org/eddelbuettel/littler)

A scripting and command-line front-end for GNU R permitting use of R in
command-line contexts.

## Installation

In general, simply running the script `bootstrap` will configure and build the
executable. Running `make install` (possibly as `sudo make install`) will
install the resulting binary.

On Linux systems, ensure you have the `autotools-dev` package (or its
equivalent on non-Debian/Ubuntu systems).  On OS X, you may need to run `brew
install automake autoconf` to get all the tools. 

### Alternate naming

On some operating systems such as OS X, `r` is not different from `R`.  As
this risk confusing the main binary `R` for the R system with our smaller
scripting frontend `r`, we suggest to consider running `configure
--program-prefix="l"` which this leads to installation of a binary `lr`
instead of `r`.

## More Information

For more information about littler, please see

* [Dirk's main littler page](http://dirk.eddelbuettel.com/code/littler.html)
* [Dirk's page with littler examples](http://dirk.eddelbuettel.com/code/littler.examples.html)

## Authors

Jeff Horner and Dirk Eddelbuettel

## License

GPL (>= 2)



