

# Command-line and scripting front-end for R

## Description

The <code>r</code> <em>binary</em> provides a convenient and powerful
front-end. By embedding R, it permits four distinct ways to leverage the
power of R at the shell prompt: scripting, filename execution, piping
and direct expression evaluation.

## Details

The <code>r</code> front-end was written with four distinct usage modes
in mind.

First, it allow to write so-called ‘shebang’ scripts starting with
<code>#!/usr/bin/env r</code>. These ‘shebang’ scripts are perfectly
suited for automation and execution via e.g. via <code>cron</code>.

Second, we can use <code>r somefile.R</code> to quickly execute the name
R source file. This is useful as <code>r</code> is both easy to type—and
quicker to start that either <code>R</code> itself, or its scripting
tool <code>Rscript</code>, while still loading the <code>methods</code>
package.

Third, <code>r</code> can be used in ‘pipes’ which are very common in
Unix. A simple and trivial example is <code>echo ‘cat(2+2)’ | r</code>
illustrating that the standard output of one program can be used as the
standard input of another program.

Fourth, <code>r</code> can be used as a calculator by supplying
expressions after the <code>-e</code> or <code>–eval</code> options.

## Value

Common with other shell tools and programs, <code>r</code> returns its
exit code where a value of zero indicates success.

## Note

On OS X one may have to link the binary to, say, <code>lr</code>
instead. As OS X insists that files named <code>R</code> and
<code>r</code> are the same, we cannot use the latter.

## Author(s)

Jeff Horner and Dirk Eddelbuettel wrote <code>littler</code> from 2006
to today, with contributions from several others.

Dirk Eddelbuettel <a href="mailto:edd@debian.org">edd@debian.org</a> is
the maintainer.

## Examples

``` r
library("littler")

  #!/usr/bin/env r              ## for use in scripts

  other input | r               ## for use in pipes

  r somefile.R                  ## for running files

  r -e 'expr'                   ## for evaluating expressions

  r --help                      ## to show a quick synopsis
```
