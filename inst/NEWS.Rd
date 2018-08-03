\name{NEWS}
\title{News for Package \pkg{littler}}
\newcommand{\ghpr}{\href{https://github.com/eddelbuettel/littler/pull/#1}{##1}}
\newcommand{\ghit}{\href{https://github.com/eddelbuettel/littler/issues/#1}{##1}}

\section{Changes in littler version 0.3.4 (2018-xx-yy)}{
  \itemize{
    \item Changes in examples
    \itemize{
      \item The shebang line is now \code{#!/usr/bin/env r} to work with
      either \code{/usr/local/bin/r} or \code{/usr/bin/r}.
      \item New example script to only install packages not yet installed
      (Brandon Bertelsen in \ghpr{59}); later added into \code{install2.r}.
      \item Functions \code{getRStudioDesktop.r} and
      \code{getRStudioServer.r} updated their internal URLs.
      \item Several minor enhancements were made to example scripts.
    }
  }
}

\section{Changes in littler version 0.3.3 (2017-12-17)}{
  \itemize{
    \item Changes in examples
    \itemize{
      \item The script \code{installGithub.r} now correctly uses the
      \code{upgrade} argument (Carl Boettiger in \ghpr{49}).
      \item New script \code{pnrrs.r} to call the package-native
      registration helper function added in R 3.4.0
      \item The script \code{install2.r} now has more robust error
      handling (Carl Boettiger in \ghpr{50}).
      \item New script \code{cow.r} to use R Hub's \code{check_on_windows}
      \item Scripts \code{cow.r} and \code{c4c.r} use
      \code{#!/usr/bin/env r}
      \item New option \code{--fast} (or \code{-f}) for scripts
      \code{build.r} and \code{rcc.r} for faster package build and check
      \item The \code{build.r} script now defaults to using the current
      directory if no argument is provided.
      \item The RStudio getters now use the \code{rvest} package to
      parse the webpage with available versions.
    }
    \item Changes in package
    \itemize{
      \item Travis CI now uses https to fetch script, and sets the group
    }
  }
}

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
