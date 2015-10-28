\name{littler}
\alias{littler}
\alias{r}
\title{Command-line and scripting front-end for R}
\description{
  The \code{r} \emph{binary} provides a convenient and powerful front-end.
  By embedding R, it permits four distinct ways to leverage the power of R at
  the shell prompt: scripting, filename execution, piping and direct expression
  evaluation.
}
\usage{
  #!/usr/bin/env r

  other input | r

  r somefile.R

  r -e 'expr'
}
\details{
  The \code{r} front-end was written with four distinct usage modes in mind.

  First, it allow to write so-called \sQuote{shebang} scripts starting with
  \code{#!/usr/bin/env r}. These \sQuote{shebang} scripts are
  perfectly suited for automation and execution via e.g. via \code{cron}.

  Second, we can use \code{r somefile.R} to quickly execute the name R source file.
  This is useful as \code{r} is both easy to type---and quicker to start that either
  \code{R} itself, or its scripting tool \code{Rscript}, while still loading the
  \code{methods} package.

  Third, \code{r} can be used in \sQuote{pipes} which are very common in Unix. A
  simple and trivial example is \code{echo 'cat(2+2)' | r} illustrating that the
  standard output of one program can be used as the standard input of another
  program.

  Fourth, \code{r} can be used as a calculator by supplying expressions after the
  \code{-e} or \code{--eval} options.
}
\value{
  Common with other shell tools and programs, \code{r} returns its exit code where
  a value of zero indicates success.
}
\notes{
  On OS X one may have to link the binary to, say, \code{lr} instead. As OS X
  insists that files named \code{R} and \code{r} are the same, we cannot use the
  latter.
}
\author{
  Jeff Horner and Dirk Eddelbuettel wrote \code{littler} from 2006 to today, with
  contributions from several others.

  Dirk Eddelbuettel \email{edd@debian.org} is the maintainer.
}
\keyword{package}
