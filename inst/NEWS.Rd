\name{NEWS}
\title{News for Package 'littler'}
\newcommand{\ghrepo}{\href{https://github.com/#1}{\pkg{#1}}}
\newcommand{\ghpr}{\href{https://github.com/eddelbuettel/littler/pull/#1}{##1}}
\newcommand{\ghit}{\href{https://github.com/eddelbuettel/littler/issues/#1}{##1}}

\section{Changes in littler version 0.3.2 (2017-02-14)}{
  \itemize{
    \item Changes in examples
    \itemize{
      \item New scripts \code{getRStudioServer.r} and
      \code{getRStudioDesktop.r} to download daily packages, currently
      defaults to Ubuntu amd64
      \item New script \code{c4c.r} calling \code{rhub::check_for_cran()}
      \item New script \code{rd2md.r} to convert Rd to markdown.
      \item New script \code{build.r} to create a source tarball.
      \item The \code{installGitHub.r} script now use package
      \CRANpkg{remotes} (PR \ghpr{44}, \ghpr{46})
    }
  }
}

\section{Changes in littler version 0.3.1 (2016-08-06)}{
  \itemize{
    \item Changes in examples
    \itemize{
      \item \code{install2.r} now passes on extra options past \code{--}
      to \code{R CMD INSTALL} (PR \ghpr{37} by Steven Pav)
      \item Added \code{rcc.r} to run \code{rcmdcheck::rcmdcheck()}
      \item Added (still simple) \code{render.r} to render (R)markdown
      \item Several examples now support the \code{-x} or \code{--usage}
      flag to show extended help.
    }
    \item Changes in build system
    \itemize{
      \item The \code{AM_LDFLAGS} variable is now set and used too
      (PR \ghpr{38} by Mattias Ellert)
      \item Three more directories, used when an explicit installation
      directory is set, are excluded (also \ghpr{38} by Mattias)
      \item Travis CI is now driven via \code{run.sh} from our fork, and
      deploys all packages as .deb binaries using our PPA where needed
    }
    \item Changes in package
    \itemize{
      \item SystemRequirements now mentions the need for \code{libR},
      i.e. an R built with a shared library so that we can embed R.
      \item The \CRANpkg{docopt} and \CRANpkg{rcmdcheck} packages are
      now suggested, and added to the Travis installation.
      \item A new helper function \code{r()} is now provided and
      exported so that the package can be imported (closes \ghit{40}).
      \item URL and BugReports links were added to DESCRIPTION.
    }
    \item Changes in documentation
    \itemize{
      \item The help output for \code{installGithub.r} was corrected
      (PR \ghpr{39} by Brandon Bertelsen)
    }
  }
}

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
