\name{NEWS}
\title{News for Package \pkg{littler}}
\newcommand{\ghpr}{\href{https://github.com/eddelbuettel/littler/pull/#1}{##1}}
\newcommand{\ghit}{\href{https://github.com/eddelbuettel/littler/issues/#1}{##1}}

\section{Changes in littler version 0.3.21 (2025-03-24)}{
  \itemize{
    \item Changes in examples scripts
    \itemize{
      \item Usage text for \code{ciw.r} is improved, new options were added (Dirk)
      \item The \sQuote{noble} release is supported by \code{r2u.r} (Dirk)
      \item The \code{installRub.r} script has additional options (Dirk)
      \item The \code{ttlt.r} script has a new \code{load_package} argument
      (Dirk)
      \item A new script \code{deadliners.r} showing CRAN packages 'under
      deadline' has been added, and then refined (Dirk)
      \item The \code{kitten.r} script can now use \pkg{whoami} and argument
      \code{githubuser} on the different \code{*kitten} helpers it calls (Dirk)
      \item A new script \code{wb.r} can upload to win-builder (Dirk)
      \item A new script \code{crup.r} can upload a CRAN submission (Dirk)
      \item In \code{rcc.r}, the return from \pkg{rcmdcheck} is now
      explicitly printed (Dirk)
      \item In \code{r2u.r} the \code{dry-run} option is passed to the build
      command
    }
    \item Changes in package
    \itemize{
      \item Regular updates to badges, continuous integration, DESCRIPTION
      and \code{configure.ac} (Dirk)
      \item Errant \code{osVersion} return value are handled more robustly
      (Michael Chirico in \ghpr{121})
      \item The current run-time path is available via variable
      \code{LITTLER_SCRIPT_PATH} (Jon Clayden in \ghpr{122})
      \item The cleanup script remove macOS debug symbols (Jon Clayden in
      \ghpr{123})
    }
  }
}

\section{Changes in littler version 0.3.20 (2024-03-23)}{
  \itemize{
    \item Changes in examples scripts
    \itemize{
      \item New (dependency-free) helper \code{installDeps2.r} to install dependencies
      \item Scripts \code{rcc.r}, \code{tt.r}, \code{tttf.r}, \code{tttlr.r}
      use \code{env} argument \code{-S} to set \code{-t} to \code{r}
      \item \code{tt.r} can now fill in \code{inst/tinytest} if it is present
      \item New script \code{ciw.r} wrapping new package \pkg{ciw}
      \item \code{tttf.t} can now use \pkg{devtools} and its \code{loadall}
      \item New script \code{doi2bib.r} to call the DOI converter REST
      service (following a skeet by Richard McElreath)
    }
    \item Changes in package
    \itemize{
      \item The CI setup use checkout@v4 and the r-ci-setup action
      \item The Suggests: is a little tighter as we do not list all packages
      optionally used in the the examples (as R does not check for it either)
      \item The package load messag can account for the rare build of R under
      different architecture (Berwin Turlach in \ghpr{117} closing \ghit{116})
      \item In non-vanilla mode, the temporary directory initialization in
      re-run allowing for a non-standard temp dir via config settings
    }
  }
}

\section{Changes in littler version 0.3.19 (2023-12-17)}{
  \itemize{
    \item Changes in examples scripts
    \itemize{
      \item The help or usage text display for \code{r2u.r}, \code{ttt.r},
      \code{check.r} has been improved, expanded or corrected, respectively
      \item \code{installDeps.r} has a new argument for dependency selection
      \item An initial 'single test file' runner \code{tttf.r} has been added
      \item \code{r2u.r} has two new options for setting / varying the Debian
      build version of package that is built, and one for BioConductor
      builds, one for a 'dry run' build, and a new \code{--compile} option
      \item \code{installRSPM.r}, \code{installPPM.r}, \code{installP3M.r}
      have been updates to reflect the name changes
      \item \code{installRub.r} now understands 'package@universe' too
      \item \code{tt.r} flips the default of the \code{--effects} switch
    }
  }
}

\section{Changes in littler version 0.3.18 (2023-03-25)}{
  \itemize{
    \item Changes in examples scripts
    \itemize{
      \item \code{roxy.r} can now set an additional \code{--libpath}
      \item \code{getRStudioDesktop.r} and \code{getRStudioServer.r} have
      updated default download file
      \item \code{install2.r} and \code{installGithub.r} can set
      \code{--type}
      \item \code{r2u.r} now has a \code{--suffix} option
      \item \code{tt.r} removes a redundant \code{library} call
      \item \code{tttl.r} has been added for \code{testthat::test_local()}
      \item \code{installRub.r} has been added to install r-universe binaries
      on Ubuntu
      \item \code{install2.r} has updated error capture messages (Tatsuya
      Shima and Dirk in \ghpr{104})
    }
  }
}

\section{Changes in littler version 0.3.17 (2022-10-29)}{
  \itemize{
    \item Changes in package
    \itemize{
      \item An internal function prototype was updated for \code{clang-15}.
    }
    \item Changes in examples
    \itemize{
      \item Scripts \code{install2.r} and \code{installBioc.r} were updated
      for an update in R-devel (Tatsuya Shima and Dirk in \ghpr{104}).
    }
  }
}

\section{Changes in littler version 0.3.16 (2022-08-28)}{
  \itemize{
    \item Changes in package
    \itemize{
      \item The \code{configure} code checks for two more headers
      \item The RNG seeding matches the current version in R (Dirk)
    }
    \item Changes in examples
    \itemize{
      \item A \code{cowu.r} 'check Window UCRT' helper was added (Dirk)
      \item A \code{getPandoc.r} downloader has been added (Dirk)
      \item The \code{-r} option tp \code{install2.r} has been
      generalzed (Tatsuya Shima in \ghpr{95})
      \item The \code{rcc.r} code / package checker now has
      \code{valgrind} option (Dirk)
      \item \code{install2.r} now installs to first element in
      \code{.libPaths()} by default (Dirk)
      \item A very simple \code{r2u.r} help has been added (Dirk)
      \item The \code{installBioc.r} has been generalized and extended
      similar to \code{install2.r} (Pieter Moris in \ghpr{103})
    }
  }
}

\section{Changes in littler version 0.3.15 (2021-12-03)}{
  \itemize{
    \item Changes in examples
    \itemize{
      \item The \code{install2} script can select download methods, and
      cope with errors from parallel download (thanks to Gergely Daroczi)
      \item The \code{build.r} now uses \code{both} as argument to
      \code{--compact-vignettes}
      \item The RStudio download helper were once again updated for
      changed URLs
      \item New caller for simplermarkdown::mdweave_to_html
    }
    \item Changes in package
    \itemize{
      \item Several typos were correct (thanks to John Kerl)
      \item Travis artifacts and badges have been pruned
      \item Vignettes now use \pkg{simplermarkdown}
    }
  }
}

\section{Changes in littler version 0.3.14 (2021-10-05)}{
  \itemize{
    \item Changes in examples
    \itemize{
      \item Updated RStudio download helper to changed file names
      \item Added a new option to \code{roxy.r} wrapper
      \item Added a downloader for Quarto command-line tool
    }
    \item Changes in package
    \itemize{
      \item The \code{configure} files were updated to the standard of
      version 2.69 following a CRAN request
    }
  }
}

\section{Changes in littler version 0.3.13 (2021-07-24)}{
  \itemize{
    \item Changes in examples
    \itemize{
      \item New script \code{compiledDeps.r} to show which dependencies
      are compiled
      \item New script \code{silenceTwitterAccount.r} wrapping
      \pkg{rtweet}
      \item The \code{-c} or \code{--code} option for
      \code{installRSPM.r} was corrected
      \item The \code{kitten.r} script now passes options \sQuote{bunny}
      and \sQuote{puppy} on to the \code{pkgKitten::kitten()} call;
      new options to call the Arma and Eigen variants were added
      \item The \code{getRStudioDesktop.r} and \code{getRStudioServer.r}
      scripts were updated for a change in \pkg{rvest}
      \item Two typos in the \code{tt.r} help message were correct
      (Aaron Wolen in \ghpr{86})
      \item The message in \code{cranIncoming.r} was corrected.
    }
    \item Changes in package
    \itemize{
      \item Added Continuous Integration runner via \code{run.sh} from
      \href{https://eddelbuettel.github.io/r-ci/}{r-ci}.
      \item Two vignettes got two extra vignette attributes.
      \item The mkdocs-material documentation input was moved.
      \item The basic unit tests were slightly refactored and updated.
    }
  }
}

\section{Changes in littler version 0.3.12 (2020-10-04)}{
  \itemize{
    \item Changes in examples
    \itemize{
      \item Updates to scripts \code{tt.r}, \code{cos.r}, \code{cow.r},
      \code{c4r.r}, \code{com.r}
      \item New script \code{installDeps.r} to install dependencies
      \item Several updates tp script \code{check.r}
      \item New script \code{installBSPM.r} and \code{installRSPM.r}
      for binary package installation (Dirk and Iñaki in \ghpr{81})
      \item New script \code{cranIncoming.r} to check in Incoming
      \item New script \code{urlUpdate.r} validate URLs as R does
    }
    \item Changes in package
    \itemize{
      \item Travis CI now uses BSPM
      \item A package documentation website was added
      \item Vignettes now use \pkg{minidown} resulting in \emph{much}
      reduced filesizes: from over 800kb to under 50kb (Dirk in \ghpr{83})
    }
  }
}

\section{Changes in littler version 0.3.11 (2020-06-26)}{
  \itemize{
    \item Changes in examples
    \itemize{
      \item Scripts \code{check.r} and \code{rcc.r} updated to reflect
      updated \pkg{docopt} 0.7.0 behaviour of quoted arguments
      \item The \code{roxy.r} script has a new ease-of-use option
      \code{-f | --full} regrouping two other options.
    }
  }
}

\section{Changes in littler version 0.3.10 (2020-06-02)}{
  \itemize{
    \item Changes in examples
    \itemize{
      \item The \code{update.r} script only considers writeable directories.
      \item The \code{rcc.r} script tries to report full logs by setting
      \code{_R_CHECK_TESTS_NLINES_=0}.
      \item The \code{tt.r} script has an improved \code{ncpu} fallback.
      \item Several installation and updating scripts set
      \code{_R_SHLIB_STRIP_} to \code{TRUE}.
      \item A new script \code{installBioc.r} was added.
      \item The \code{--error} option to \code{install2.r} was
      generalized (Sergio Oller in \ghpr{78}).
      \item The \code{roxy.r} script was extended a little.
    }
    \item Changes in package
    \itemize{
      \item Travis CI now uses R 4.0.0 and the bionic distro
    }
  }
}

\section{Changes in littler version 0.3.9 (2019-10-27)}{
  \itemize{
    \item Changes in examples
    \itemize{
      \item The use of \code{call.} in \code{stop()} was corrected
      (Stefan Widgren in \ghpr{72}).
      \item New script \code{cos.r} to check (at rhub) on Solaris.
      \item New script \code{compactpdf.r} to compact pdf files.
      \item The \code{build.r} script now compacts vignettes and resaves
      data.
      \item The \code{tt.r} script now supports parallel tests and side
      effects.
      \item The \code{rcc.r} script can now report error codes.
      \item The `--libloc` option to \code{update.r} was updated.
      \item The \code{render.r} script can optionally compact pdfs.
      \item New script \code{sweave.r} to render (and compact) pdfs.
      \item New script \code{pkg2bibtex.r} to show bibtex entries.
      \item The \code{kitten.r} script has a new option \code{--puppy}
      to add \pkg{tinytest} support in purring packages.
    }
  }
}

\section{Changes in littler version 0.3.8 (2019-06-09)}{
  \itemize{
    \item Changes in examples
    \itemize{
      \item The \code{install.r} and \code{install2.r} scripts now use
      parallel installation using \code{options{Ncpu}} on remote packages.
      \item The \code{install.r} script has an expanded help text
      mentioning the environment variables it considers.
      \item A new script \code{tt.r} was added to support \code{tinytest}.
      \item The rhub checking scripts now all suppress builds of manual
      and vignettes as asking for working latex appears to be too much.
    }
    \item Changes in package
    \itemize{
      \item On startup checks if \code{r} is in \code{PATH} and if not
      references new FAQ entry; text from \code{Makevars} mentions it too.
    }
    \item Changes in documentation
    \itemize{
      \item The FAQ vignette now details setting \code{r} to \code{PATH}.
    }
  }
}

\section{Changes in littler version 0.3.7 (2019-03-15)}{
  \itemize{
    \item Changes in examples
    \itemize{
      \item The scripts \code{installGithub.r} and \code{install2.r} get
      a new option \code{-r | --repos} (Gergely Daroczi in \ghpr{67})
    }
    \item Changes in build system
    \itemize{
      \item The \code{AC_DEFINE} macro use rewritten to please R CMD check.
    }
  }
}

\section{Changes in littler version 0.3.6 (2019-01-26)}{
  \itemize{
    \item Changes in examples
    \itemize{
      \item The scripts \code{install.r} and \code{install2.r} now support
      argument \code{"."}, and add it if called in a source directory.
      \item The script \code{install2.r} can set \code{Ncpus} for
      \code{install.packages()} (Colin Gillespie in \ghpr{63} fixing \ghpr{62})
      \item The script \code{update.r} can also set \code{Ncpus} for
      \code{install.packages()}.
      \item A new vignette "litter-faq" was added.
    }
  }
}

\section{Changes in littler version 0.3.5 (2018-10-04)}{
  \itemize{
    \item Changes in examples
    \itemize{
      \item The script \code{roxy.r} now uses a cached copy of \pkg{roxygen2}
      version 6.0.1 (if available) as the current version 6.1.0
      changed behaviour.
      \item The script \code{rcc.r} was updated as the underlying
      \pkg{rcmdcheck} changed parameter order.
      \item A new simpler wrapper \code{rchk.r} was added to use RHub
      with the \code{rchk} image.
    }
    \item Changes in package
    \itemize{
      \item Travis CI now uses the R 3.5 PPA
    }
  }
}

\section{Changes in littler version 0.3.4 (2018-08-24)}{
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
