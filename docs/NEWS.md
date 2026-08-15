

# News for Package <span class="pkg">littler</span>

## Changes in littler version 0.3.23 (2026-04-12)

<ul>
<li>

Changes in examples scripts

<ul>
<li>

Correct spelling in <code>installGithub.r</code> to lower-case h

</li>
<li>

The <code>r2u.r</code> now recognises ‘resolute’ aka 26.06

</li>
<li>

<code>installRub.r</code> can install (more easily) from r-multiverse

</li>
<li>

A file permission was corrected (Mattias Ellert in
<a href="https://github.com/eddelbuettel/littler/pull/131">[#131](https://github.com/eddelbuettel/littler/issues/131)</a>)

</li>
</ul>
</li>
<li>

Changes in package

<ul>
<li>

Update script count and examples in README.md

</li>
<li>

Continuous intgegration scripts received minor updates

</li>
<li>

The C level access to the R API was updated to reflect most recent
standards (Dirk in
<a href="https://github.com/eddelbuettel/littler/pull/132">[#132](https://github.com/eddelbuettel/littler/issues/132)</a>)

</li>
</ul>
</li>
</ul>

## Changes in littler version 0.3.22 (2026-02-03)

<ul>
<li>

Changes in examples scripts

<ul>
<li>

A new script <code>busybees.r</code> aggregates deadlined packages by
maintainer

</li>
<li>

Several small updated have been made to the (mostly internal) ‘r2u.r’
script

</li>
<li>

The <code>deadliners.r</code> script has refined treatment for screen
width

</li>
<li>

The <code>install2.r</code> script has new options <code>–quiet</code>
and <code>–verbose</code> as proposed by Zivan Karaman

</li>
<li>

The <code>rcc.r</code> script passes build-args to ‘rcmdcheck’ to
compact vignettes and save data

</li>
<li>

The <code>installRub.r</code> script now defaults to ‘noble’ and is more
tolerant of inputs

</li>
<li>

The <code>installRub.r</code> script deals correctly with empty
<code>utils::osVersion</code> thanks to Michael Chirico

</li>
<li>

New script <code>checkPackageUrls.r</code> inspired by how CRAN checks
(with thanks to Kurt Hornik for the hint)

</li>
<li>

The <code>installGithub.r</code> script now adjusts to <code>bspm</code>
and takes advantage of r2u binaries for its build dependencies

</li>
</ul>
</li>
<li>

Changes in package

<ul>
<li>

Environment variables (read at build time) can use double quotes

</li>
<li>

Continuous intgegration scripts received a minor update

</li>
</ul>
</li>
</ul>

## Changes in littler version 0.3.21 (2025-03-24)

<ul>
<li>

Changes in examples scripts

<ul>
<li>

Usage text for <code>ciw.r</code> is improved, new options were added
(Dirk)

</li>
<li>

The ‘noble’ release is supported by <code>r2u.r</code> (Dirk)

</li>
<li>

The <code>installRub.r</code> script has additional options (Dirk)

</li>
<li>

The <code>ttlt.r</code> script has a new <code>load_package</code>
argument (Dirk)

</li>
<li>

A new script <code>deadliners.r</code> showing CRAN packages ‘under
deadline’ has been added, and then refined (Dirk)

</li>
<li>

The <code>kitten.r</code> script can now use
<span class="pkg">whoami</span> and argument <code>githubuser</code> on
the different <code>\*kitten</code> helpers it calls (Dirk)

</li>
<li>

A new script <code>wb.r</code> can upload to win-builder (Dirk)

</li>
<li>

A new script <code>crup.r</code> can upload a CRAN submission (Dirk)

</li>
<li>

In <code>rcc.r</code>, the return from
<span class="pkg">rcmdcheck</span> is now explicitly printed (Dirk)

</li>
<li>

In <code>r2u.r</code> the <code>dry-run</code> option is passed to the
build command (Dirk)

</li>
</ul>
</li>
<li>

Changes in package

<ul>
<li>

Regular updates to badges, continuous integration, DESCRIPTION and
<code>configure.ac</code> (Dirk)

</li>
<li>

Errant <code>osVersion</code> return value are handled more robustly
(Michael Chirico in
<a href="https://github.com/eddelbuettel/littler/pull/121">[#121](https://github.com/eddelbuettel/littler/issues/121)</a>)

</li>
<li>

The current run-time path is available via variable
<code>LITTLER_SCRIPT_PATH</code> (Jon Clayden in
<a href="https://github.com/eddelbuettel/littler/pull/122">[#122](https://github.com/eddelbuettel/littler/issues/122)</a>)

</li>
<li>

The cleanup script remove macOS debug symbols (Jon Clayden in
<a href="https://github.com/eddelbuettel/littler/pull/123">[#123](https://github.com/eddelbuettel/littler/issues/123)</a>)

</li>
</ul>
</li>
</ul>

## Changes in littler version 0.3.20 (2024-03-23)

<ul>
<li>

Changes in examples scripts

<ul>
<li>

New (dependency-free) helper <code>installDeps2.r</code> to install
dependencies

</li>
<li>

Scripts <code>rcc.r</code>, <code>tt.r</code>, <code>tttf.r</code>,
<code>tttlr.r</code> use <code>env</code> argument <code>-S</code> to
set <code>-t</code> to <code>r</code>

</li>
<li>

<code>tt.r</code> can now fill in <code>inst/tinytest</code> if it is
present

</li>
<li>

New script <code>ciw.r</code> wrapping new package
<span class="pkg">ciw</span>

</li>
<li>

<code>tttf.t</code> can now use <span class="pkg">devtools</span> and
its <code>loadall</code>

</li>
<li>

New script <code>doi2bib.r</code> to call the DOI converter REST service
(following a skeet by Richard McElreath)

</li>
</ul>
</li>
<li>

Changes in package

<ul>
<li>

The CI setup use checkout@v4 and the r-ci-setup action

</li>
<li>

The Suggests: is a little tighter as we do not list all packages
optionally used in the the examples (as R does not check for it either)

</li>
<li>

The package load messag can account for the rare build of R under
different architecture (Berwin Turlach in
<a href="https://github.com/eddelbuettel/littler/pull/117">[#117](https://github.com/eddelbuettel/littler/issues/117)</a>
closing
<a href="https://github.com/eddelbuettel/littler/issues/116">[#116](https://github.com/eddelbuettel/littler/issues/116)</a>)

</li>
<li>

In non-vanilla mode, the temporary directory initialization in re-run
allowing for a non-standard temp dir via config settings

</li>
</ul>
</li>
</ul>

## Changes in littler version 0.3.19 (2023-12-17)

<ul>
<li>

Changes in examples scripts

<ul>
<li>

The help or usage text display for <code>r2u.r</code>,
<code>ttt.r</code>, <code>check.r</code> has been improved, expanded or
corrected, respectively

</li>
<li>

<code>installDeps.r</code> has a new argument for dependency selection

</li>
<li>

An initial ‘single test file’ runner <code>tttf.r</code> has been added

</li>
<li>

<code>r2u.r</code> has two new options for setting / varying the Debian
build version of package that is built, and one for BioConductor builds,
one for a ‘dry run’ build, and a new <code>–compile</code> option

</li>
<li>

<code>installRSPM.r</code>, <code>installPPM.r</code>,
<code>installP3M.r</code> have been updates to reflect the name changes

</li>
<li>

<code>installRub.r</code> now understands ‘package@universe’ too

</li>
<li>

<code>tt.r</code> flips the default of the <code>–effects</code> switch

</li>
</ul>
</li>
</ul>

## Changes in littler version 0.3.18 (2023-03-25)

<ul>
<li>

Changes in examples scripts

<ul>
<li>

<code>roxy.r</code> can now set an additional <code>–libpath</code>

</li>
<li>

<code>getRStudioDesktop.r</code> and <code>getRStudioServer.r</code>
have updated default download file

</li>
<li>

<code>install2.r</code> and <code>installGithub.r</code> can set
<code>–type</code>

</li>
<li>

<code>r2u.r</code> now has a <code>–suffix</code> option

</li>
<li>

<code>tt.r</code> removes a redundant <code>library</code> call

</li>
<li>

<code>tttl.r</code> has been added for
<code>testthat::test_local()</code>

</li>
<li>

<code>installRub.r</code> has been added to install r-universe binaries
on Ubuntu

</li>
<li>

<code>install2.r</code> has updated error capture messages (Tatsuya
Shima and Dirk in
<a href="https://github.com/eddelbuettel/littler/pull/104">[#104](https://github.com/eddelbuettel/littler/issues/104)</a>)

</li>
</ul>
</li>
</ul>

## Changes in littler version 0.3.17 (2022-10-29)

<ul>
<li>

Changes in package

<ul>
<li>

An internal function prototype was updated for <code>clang-15</code>.

</li>
</ul>
</li>
<li>

Changes in examples

<ul>
<li>

Scripts <code>install2.r</code> and <code>installBioc.r</code> were
updated for an update in R-devel (Tatsuya Shima and Dirk in
<a href="https://github.com/eddelbuettel/littler/pull/104">[#104](https://github.com/eddelbuettel/littler/issues/104)</a>).

</li>
</ul>
</li>
</ul>

## Changes in littler version 0.3.16 (2022-08-28)

<ul>
<li>

Changes in package

<ul>
<li>

The <code>configure</code> code checks for two more headers

</li>
<li>

The RNG seeding matches the current version in R (Dirk)

</li>
</ul>
</li>
<li>

Changes in examples

<ul>
<li>

A <code>cowu.r</code> ‘check Window UCRT’ helper was added (Dirk)

</li>
<li>

A <code>getPandoc.r</code> downloader has been added (Dirk)

</li>
<li>

The <code>-r</code> option tp <code>install2.r</code> has been
generalzed (Tatsuya Shima in
<a href="https://github.com/eddelbuettel/littler/pull/95">[#95](https://github.com/eddelbuettel/littler/issues/95)</a>)

</li>
<li>

The <code>rcc.r</code> code / package checker now has
<code>valgrind</code> option (Dirk)

</li>
<li>

<code>install2.r</code> now installs to first element in
<code>.libPaths()</code> by default (Dirk)

</li>
<li>

A very simple <code>r2u.r</code> help has been added (Dirk)

</li>
<li>

The <code>installBioc.r</code> has been generalized and extended similar
to <code>install2.r</code> (Pieter Moris in
<a href="https://github.com/eddelbuettel/littler/pull/103">[#103](https://github.com/eddelbuettel/littler/issues/103)</a>)

</li>
</ul>
</li>
</ul>

## Changes in littler version 0.3.15 (2021-12-03)

<ul>
<li>

Changes in examples

<ul>
<li>

The <code>install2</code> script can select download methods, and cope
with errors from parallel download (thanks to Gergely Daroczi)

</li>
<li>

The <code>build.r</code> now uses <code>both</code> as argument to
<code>–compact-vignettes</code>

</li>
<li>

The RStudio download helper were once again updated for changed URLs

</li>
<li>

New caller for simplermarkdown::mdweave_to_html

</li>
</ul>
</li>
<li>

Changes in package

<ul>
<li>

Several typos were correct (thanks to John Kerl)

</li>
<li>

Travis artifacts and badges have been pruned

</li>
<li>

Vignettes now use <span class="pkg">simplermarkdown</span>

</li>
</ul>
</li>
</ul>

## Changes in littler version 0.3.14 (2021-10-05)

<ul>
<li>

Changes in examples

<ul>
<li>

Updated RStudio download helper to changed file names

</li>
<li>

Added a new option to <code>roxy.r</code> wrapper

</li>
<li>

Added a downloader for Quarto command-line tool

</li>
</ul>
</li>
<li>

Changes in package

<ul>
<li>

The <code>configure</code> files were updated to the standard of version
2.69 following a CRAN request

</li>
</ul>
</li>
</ul>

## Changes in littler version 0.3.13 (2021-07-24)

<ul>
<li>

Changes in examples

<ul>
<li>

New script <code>compiledDeps.r</code> to show which dependencies are
compiled

</li>
<li>

New script <code>silenceTwitterAccount.r</code> wrapping
<span class="pkg">rtweet</span>

</li>
<li>

The <code>-c</code> or <code>–code</code> option for
<code>installRSPM.r</code> was corrected

</li>
<li>

The <code>kitten.r</code> script now passes options ‘bunny’ and ‘puppy’
on to the <code>pkgKitten::kitten()</code> call; new options to call the
Arma and Eigen variants were added

</li>
<li>

The <code>getRStudioDesktop.r</code> and <code>getRStudioServer.r</code>
scripts were updated for a change in <span class="pkg">rvest</span>

</li>
<li>

Two typos in the <code>tt.r</code> help message were correct (Aaron
Wolen in
<a href="https://github.com/eddelbuettel/littler/pull/86">[#86](https://github.com/eddelbuettel/littler/issues/86)</a>)

</li>
<li>

The message in <code>cranIncoming.r</code> was corrected.

</li>
</ul>
</li>
<li>

Changes in package

<ul>
<li>

Added Continuous Integration runner via <code>run.sh</code> from
<a href="https://eddelbuettel.github.io/r-ci/">r-ci</a>.

</li>
<li>

Two vignettes got two extra vignette attributes.

</li>
<li>

The mkdocs-material documentation input was moved.

</li>
<li>

The basic unit tests were slightly refactored and updated.

</li>
</ul>
</li>
</ul>

## Changes in littler version 0.3.12 (2020-10-04)

<ul>
<li>

Changes in examples

<ul>
<li>

Updates to scripts <code>tt.r</code>, <code>cos.r</code>,
<code>cow.r</code>, <code>c4r.r</code>, <code>com.r</code>

</li>
<li>

New script <code>installDeps.r</code> to install dependencies

</li>
<li>

Several updates tp script <code>check.r</code>

</li>
<li>

New script <code>installBSPM.r</code> and <code>installRSPM.r</code> for
binary package installation (Dirk and Iñaki in
<a href="https://github.com/eddelbuettel/littler/pull/81">[#81](https://github.com/eddelbuettel/littler/issues/81)</a>)

</li>
<li>

New script <code>cranIncoming.r</code> to check in Incoming

</li>
<li>

New script <code>urlUpdate.r</code> validate URLs as R does

</li>
</ul>
</li>
<li>

Changes in package

<ul>
<li>

Travis CI now uses BSPM

</li>
<li>

A package documentation website was added

</li>
<li>

Vignettes now use <span class="pkg">minidown</span> resulting in
<em>much</em> reduced filesizes: from over 800kb to under 50kb (Dirk in
<a href="https://github.com/eddelbuettel/littler/pull/83">[#83](https://github.com/eddelbuettel/littler/issues/83)</a>)

</li>
</ul>
</li>
</ul>

## Changes in littler version 0.3.11 (2020-06-26)

<ul>
<li>

Changes in examples

<ul>
<li>

Scripts <code>check.r</code> and <code>rcc.r</code> updated to reflect
updated <span class="pkg">docopt</span> 0.7.0 behaviour of quoted
arguments

</li>
<li>

The <code>roxy.r</code> script has a new ease-of-use option <code>-f |
–full</code> regrouping two other options.

</li>
</ul>
</li>
</ul>

## Changes in littler version 0.3.10 (2020-06-02)

<ul>
<li>

Changes in examples

<ul>
<li>

The <code>update.r</code> script only considers writeable directories.

</li>
<li>

The <code>rcc.r</code> script tries to report full logs by setting
<code>*R_CHECK_TESTS_NLINES*=0</code>.

</li>
<li>

The <code>tt.r</code> script has an improved <code>ncpu</code> fallback.

</li>
<li>

Several installation and updating scripts set
<code>*R_SHLIB_STRIP*</code> to <code>TRUE</code>.

</li>
<li>

A new script <code>installBioc.r</code> was added.

</li>
<li>

The <code>–error</code> option to <code>install2.r</code> was
generalized (Sergio Oller in
<a href="https://github.com/eddelbuettel/littler/pull/78">[#78](https://github.com/eddelbuettel/littler/issues/78)</a>).

</li>
<li>

The <code>roxy.r</code> script was extended a little.

</li>
</ul>
</li>
<li>

Changes in package

<ul>
<li>

Travis CI now uses R 4.0.0 and the bionic distro

</li>
</ul>
</li>
</ul>

## Changes in littler version 0.3.9 (2019-10-27)

<ul>
<li>

Changes in examples

<ul>
<li>

The use of <code>call.</code> in <code>stop()</code> was corrected
(Stefan Widgren in
<a href="https://github.com/eddelbuettel/littler/pull/72">[#72](https://github.com/eddelbuettel/littler/issues/72)</a>).

</li>
<li>

New script <code>cos.r</code> to check (at rhub) on Solaris.

</li>
<li>

New script <code>compactpdf.r</code> to compact pdf files.

</li>
<li>

The <code>build.r</code> script now compacts vignettes and resaves data.

</li>
<li>

The <code>tt.r</code> script now supports parallel tests and side
effects.

</li>
<li>

The <code>rcc.r</code> script can now report error codes.

</li>
<li>

The ‘–libloc’ option to <code>update.r</code> was updated.

</li>
<li>

The <code>render.r</code> script can optionally compact pdfs.

</li>
<li>

New script <code>sweave.r</code> to render (and compact) pdfs.

</li>
<li>

New script <code>pkg2bibtex.r</code> to show bibtex entries.

</li>
<li>

The <code>kitten.r</code> script has a new option <code>–puppy</code> to
add <span class="pkg">tinytest</span> support in purring packages.

</li>
</ul>
</li>
</ul>

## Changes in littler version 0.3.8 (2019-06-09)

<ul>
<li>

Changes in examples

<ul>
<li>

The <code>install.r</code> and <code>install2.r</code> scripts now use
parallel installation using <code>options{Ncpu}</code> on remote
packages.

</li>
<li>

The <code>install.r</code> script has an expanded help text mentioning
the environment variables it considers.

</li>
<li>

A new script <code>tt.r</code> was added to support
<code>tinytest</code>.

</li>
<li>

The rhub checking scripts now all suppress builds of manual and
vignettes as asking for working latex appears to be too much.

</li>
</ul>
</li>
<li>

Changes in package

<ul>
<li>

On startup checks if <code>r</code> is in <code>PATH</code> and if not
references new FAQ entry; text from <code>Makevars</code> mentions it
too.

</li>
</ul>
</li>
<li>

Changes in documentation

<ul>
<li>

The FAQ vignette now details setting <code>r</code> to
<code>PATH</code>.

</li>
</ul>
</li>
</ul>

## Changes in littler version 0.3.7 (2019-03-15)

<ul>
<li>

Changes in examples

<ul>
<li>

The scripts <code>installGithub.r</code> and <code>install2.r</code> get
a new option <code>-r | –repos</code> (Gergely Daroczi in
<a href="https://github.com/eddelbuettel/littler/pull/67">[#67](https://github.com/eddelbuettel/littler/issues/67)</a>)

</li>
</ul>
</li>
<li>

Changes in build system

<ul>
<li>

The <code>AC_DEFINE</code> macro use rewritten to please R CMD check.

</li>
</ul>
</li>
</ul>

## Changes in littler version 0.3.6 (2019-01-26)

<ul>
<li>

Changes in examples

<ul>
<li>

The scripts <code>install.r</code> and <code>install2.r</code> now
support argument <code>“.”</code>, and add it if called in a source
directory.

</li>
<li>

The script <code>install2.r</code> can set <code>Ncpus</code> for
<code>install.packages()</code> (Colin Gillespie in
<a href="https://github.com/eddelbuettel/littler/pull/63">[#63](https://github.com/eddelbuettel/littler/issues/63)</a> fixing
<a href="https://github.com/eddelbuettel/littler/pull/62">[#62](https://github.com/eddelbuettel/littler/issues/62)</a>)

</li>
<li>

The script <code>update.r</code> can also set <code>Ncpus</code> for
<code>install.packages()</code>.

</li>
<li>

A new vignette "litter-faq" was added.

</li>
</ul>
</li>
</ul>

## Changes in littler version 0.3.5 (2018-10-04)

<ul>
<li>

Changes in examples

<ul>
<li>

The script <code>roxy.r</code> now uses a cached copy of
<span class="pkg">roxygen2</span> version 6.0.1 (if available) as the
current version 6.1.0 changed behaviour.

</li>
<li>

The script <code>rcc.r</code> was updated as the underlying
<span class="pkg">rcmdcheck</span> changed parameter order.

</li>
<li>

A new simpler wrapper <code>rchk.r</code> was added to use RHub with the
<code>rchk</code> image.

</li>
</ul>
</li>
<li>

Changes in package

<ul>
<li>

Travis CI now uses the R 3.5 PPA

</li>
</ul>
</li>
</ul>

## Changes in littler version 0.3.4 (2018-08-24)

<ul>
<li>

Changes in examples

<ul>
<li>

The shebang line is now <code>#!/usr/bin/env r</code> to work with
either <code>/usr/local/bin/r</code> or <code>/usr/bin/r</code>.

</li>
<li>

New example script to only install packages not yet installed (Brandon
Bertelsen in
<a href="https://github.com/eddelbuettel/littler/pull/59">[#59](https://github.com/eddelbuettel/littler/issues/59)</a>);
later added into <code>install2.r</code>.

</li>
<li>

Functions <code>getRStudioDesktop.r</code> and
<code>getRStudioServer.r</code> updated their internal URLs.

</li>
<li>

Several minor enhancements were made to example scripts.

</li>
</ul>
</li>
</ul>

## Changes in littler version 0.3.3 (2017-12-17)

<ul>
<li>

Changes in examples

<ul>
<li>

The script <code>installGithub.r</code> now correctly uses the
<code>upgrade</code> argument (Carl Boettiger in
<a href="https://github.com/eddelbuettel/littler/pull/49">[#49](https://github.com/eddelbuettel/littler/issues/49)</a>).

</li>
<li>

New script <code>pnrrs.r</code> to call the package-native registration
helper function added in R 3.4.0

</li>
<li>

The script <code>install2.r</code> now has more robust error handling
(Carl Boettiger in
<a href="https://github.com/eddelbuettel/littler/pull/50">[#50](https://github.com/eddelbuettel/littler/issues/50)</a>).

</li>
<li>

New script <code>cow.r</code> to use R Hub’s
<code>check_on_windows</code>

</li>
<li>

Scripts <code>cow.r</code> and <code>c4c.r</code> use
<code>#!/usr/bin/env r</code>

</li>
<li>

New option <code>–fast</code> (or <code>-f</code>) for scripts
<code>build.r</code> and <code>rcc.r</code> for faster package build and
check

</li>
<li>

The <code>build.r</code> script now defaults to using the current
directory if no argument is provided.

</li>
<li>

The RStudio getters now use the <code>rvest</code> package to parse the
webpage with available versions.

</li>
</ul>
</li>
<li>

Changes in package

<ul>
<li>

Travis CI now uses https to fetch script, and sets the group

</li>
</ul>
</li>
</ul>

## Changes in littler version 0.3.2 (2017-02-14)

<ul>
<li>

Changes in examples

<ul>
<li>

New scripts <code>getRStudioServer.r</code> and
<code>getRStudioDesktop.r</code> to download daily packages, currently
defaults to Ubuntu amd64

</li>
<li>

New script <code>c4c.r</code> calling
<code>rhub::check_for_cran()</code>

</li>
<li>

New script <code>rd2md.r</code> to convert Rd to markdown.

</li>
<li>

New script <code>build.r</code> to create a source tarball.

</li>
<li>

The <code>installGithub.r</code> script now use package
<a href="https://CRAN.R-project.org/package=remotes"><span class="pkg">remotes</span></a>
(PR <a href="https://github.com/eddelbuettel/littler/pull/44">[#44](https://github.com/eddelbuettel/littler/issues/44)</a>,
<a href="https://github.com/eddelbuettel/littler/pull/46">[#46](https://github.com/eddelbuettel/littler/issues/46)</a>)

</li>
</ul>
</li>
</ul>

## Changes in littler version 0.3.1 (2016-08-06)

<ul>
<li>

Changes in examples

<ul>
<li>

<code>install2.r</code> now passes on extra options past <code>–</code>
to <code>R CMD INSTALL</code> (PR
<a href="https://github.com/eddelbuettel/littler/pull/37">[#37](https://github.com/eddelbuettel/littler/issues/37)</a> by
Steven Pav)

</li>
<li>

Added <code>rcc.r</code> to run <code>rcmdcheck::rcmdcheck()</code>

</li>
<li>

Added (still simple) <code>render.r</code> to render (R)markdown

</li>
<li>

Several examples now support the <code>-x</code> or <code>–usage</code>
flag to show extended help.

</li>
</ul>
</li>
<li>

Changes in build system

<ul>
<li>

The <code>AM_LDFLAGS</code> variable is now set and used too (PR
<a href="https://github.com/eddelbuettel/littler/pull/38">[#38](https://github.com/eddelbuettel/littler/issues/38)</a> by
Mattias Ellert)

</li>
<li>

Three more directories, used when an explicit installation directory is
set, are excluded (also
<a href="https://github.com/eddelbuettel/littler/pull/38">[#38](https://github.com/eddelbuettel/littler/issues/38)</a> by
Mattias)

</li>
<li>

Travis CI is now driven via <code>run.sh</code> from our fork, and
deploys all packages as .deb binaries using our PPA where needed

</li>
</ul>
</li>
<li>

Changes in package

<ul>
<li>

SystemRequirements now mentions the need for <code>libR</code>, i.e. an
R built with a shared library so that we can embed R.

</li>
<li>

The
<a href="https://CRAN.R-project.org/package=docopt"><span class="pkg">docopt</span></a>
and
<a href="https://CRAN.R-project.org/package=rcmdcheck"><span class="pkg">rcmdcheck</span></a>
packages are now suggested, and added to the Travis installation.

</li>
<li>

A new helper function <code>r()</code> is now provided and exported so
that the package can be imported (closes
<a href="https://github.com/eddelbuettel/littler/issues/40">[#40](https://github.com/eddelbuettel/littler/issues/40)</a>).

</li>
<li>

URL and BugReports links were added to DESCRIPTION.

</li>
</ul>
</li>
<li>

Changes in documentation

<ul>
<li>

The help output for <code>installGithub.r</code> was corrected (PR
<a href="https://github.com/eddelbuettel/littler/pull/39">[#39](https://github.com/eddelbuettel/littler/issues/39)</a> by
Brandon Bertelsen)

</li>
</ul>
</li>
</ul>

## Changes in littler version 0.3.0 (2015-10-29)

<ul>
<li>

Changes in build system

<ul>
<li>

First CRAN Release as R package following nine years of source releases

</li>
<li>

Script <code>configure</code>, <code>src/Makevars.in</code> and
remainder of build system rewritten to take advantage of the R package
build infrastructure

</li>
<li>

Reproducible builds are better supported as the (changing) compilation
timestamps etc are only inserted for ‘verbose builds’ directly off the
git repo, but not for Debian (or CRAN) builds off the release tarballs

</li>
</ul>
</li>
<li>

Changes in littler functionality

<ul>
<li>

Also source <code>$R_HOME/etc/Rprofile.site</code> and
<code>~/.Rprofile</code> if present

</li>
</ul>
</li>
<li>

Changes in littler documentation

<ul>
<li>

Added new vignette with examples

</li>
</ul>
</li>
</ul>