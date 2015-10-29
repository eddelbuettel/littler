\name{NEWS}
\title{News for Package 'littler'}
\newcommand{\ghrepo}{\href{https://github.com/#1}{\pkg{#1}}}
\newcommand{\ghpr}{\href{https://github.com/eddelbuettel/littler/pull/#1}{##1}}
\newcommand{\ghit}{\href{https://github.com/eddelbuettel/littler/issues/#1}{##1}}

\section{Changes in littler version 0.3.0 (2015-10-29)}{
  \itemize{
    \item Changes in build system
    \itemize{
      \item First CRAN Release as R package following nine years of source releases 
      \item Script \code{configure}, \code{src/Makevars.in} and
      remainder of build system rewritten to take advantage of the R package
      build infrastructure 
      \item Reproducible builds are better supported as the (changing)
      compilation timestamps etc are only inserted for 'verbose builds'
      directly off the git repo, but not for Debian (or CRAN) builds off the
      release tarballs
    }
    \item Changes in littler functionality
    \itemize{
      \item Also source \code{$R_HOME/etc/Rprofile.site} and
      \code{~/.Rprofile} if present
    }
    \item Changes in littler documentation
    \itemize{
      \item Added new vignette with examples
    }
  }
}
