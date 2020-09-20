## Command-line and scripting front-end for R

### Description

The `r` *binary* provides a convenient and powerful front-end. By
embedding R, it permits four distinct ways to leverage the power of R at
the shell prompt: scripting, filename execution, piping and direct
expression evaluation.

### Details

The `r` front-end was written with four distinct usage modes in mind.

First, it allow to write so-called ‘shebang’ scripts starting with
`#!/usr/bin/env r`. These ‘shebang’ scripts are perfectly suited for
automation and execution via e.g. via `cron`.

Second, we can use `r somefile.R` to quickly execute the name R source
file. This is useful as `r` is both easy to type—and quicker to start
that either `R` itself, or its scripting tool `Rscript`, while still
loading the `methods` package.

Third, `r` can be used in ‘pipes’ which are very common in Unix. A
simple and trivial example is `echo 'cat(2+2)' | r` illustrating that
the standard output of one program can be used as the standard input of
another program.

Fourth, `r` can be used as a calculator by supplying expressions after
the `-e` or `--eval` options.

### Value

Common with other shell tools and programs, `r` returns its exit code
where a value of zero indicates success.

### Note

On OS X one may have to link the binary to, say, `lr` instead. As OS X
insists that files named `R` and `r` are the same, we cannot use the
latter.

### Author(s)

Jeff Horner and Dirk Eddelbuettel wrote `littler` from 2006 to today,
with contributions from several others.

Dirk Eddelbuettel <edd@debian.org> is the maintainer.

### Examples

``` 
  ## Not run: 
  #!/usr/bin/env r              ## for use in scripts

  other input | r               ## for use in pipes

  r somefile.R                  ## for running files

  r -e 'expr'                   ## for evaluating expressions

  r --help                      ## to show a quick synopsis
        
  
## End(Not run)
```
