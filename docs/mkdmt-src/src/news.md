<div class="container">
<h3 id="version-0.3.16-2022-08-28">Version 0.3.16 (2022-08-28)</h3>
<ul>
<li><p>Changes in package</p>
<ul>
<li><p>The <code>configure</code> code checks for two more headers</p></li>
<li><p>The RNG seeding matches the current version in R (Dirk)</p></li>
</ul></li>
<li><p>Changes in examples</p>
<ul>
<li><p>A <code>cowu.r</code> 'check Window UCRT' helper was added (Dirk)</p></li>
<li><p>A <code>getPandoc.r</code> downloader has been added (Dirk)</p></li>
<li><p>The <code>-r</code> option tp <code>install2.r</code> has been generalzed (Tatsuya Shima in <a href="https://github.com/eddelbuettel/littler/pull/95">#95</a>)</p></li>
<li><p>The <code>rcc.r</code> code / package checker now has <code>valgrind</code> option (Dirk)</p></li>
<li><p><code>install2.r</code> now installs to first element in <code>.libPaths()</code> by default (Dirk)</p></li>
<li><p>A very simple <code>r2u.r</code> help has been added (Dirk)</p></li>
<li><p>The <code>installBioc.r</code> has been generalized and extended similar to <code>install2.r</code> (Pieter Moris in <a href="https://github.com/eddelbuettel/littler/pull/103">#103</a>)</p></li>
</ul></li>
</ul>
<h3 id="version-0.3.15-2021-12-03">Version 0.3.15 (2021-12-03)</h3>
<ul>
<li><p>Changes in examples</p>
<ul>
<li><p>The <code>install2</code> script can select download methods, and cope with errors from parallel download (thanks to Gergely Daroczi)</p></li>
<li><p>The <code>build.r</code> now uses <code>both</code> as argument to <code>--compact-vignettes</code></p></li>
<li><p>The RStudio download helper were once again updated for changed URLs</p></li>
<li><p>New caller for simplermarkdown::mdweave_to_html</p></li>
</ul></li>
<li><p>Changes in package</p>
<ul>
<li><p>Several typos were correct (thanks to John Kerl)</p></li>
<li><p>Travis artifacts and badges have been pruned</p></li>
<li><p>Vignettes now use <code>simplermarkdown</code></p></li>
</ul></li>
</ul>
<h3 id="version-0.3.14-2021-10-05">Version 0.3.14 (2021-10-05)</h3>
<ul>
<li><p>Changes in examples</p>
<ul>
<li><p>Updated RStudio download helper to changed file names</p></li>
<li><p>Added a new option to <code>roxy.r</code> wrapper</p></li>
<li><p>Added a downloader for Quarto command-line tool</p></li>
</ul></li>
<li><p>Changes in package</p>
<ul>
<li><p>The <code>configure</code> files were updated to the standard of version 2.69 following a CRAN request</p></li>
</ul></li>
</ul>
<h3 id="version-0.3.13-2021-07-24">Version 0.3.13 (2021-07-24)</h3>
<ul>
<li><p>Changes in examples</p>
<ul>
<li><p>New script <code>compiledDeps.r</code> to show which dependencies are compiled</p></li>
<li><p>New script <code>silenceTwitterAccount.r</code> wrapping <code>rtweet</code></p></li>
<li><p>The <code>-c</code> or <code>--code</code> option for <code>installRSPM.r</code> was corrected</p></li>
<li><p>The <code>kitten.r</code> script now passes options ‘bunny’ and ‘puppy’ on to the <code>pkgKitten::kitten()</code> call; new options to call the Arma and Eigen variants were added</p></li>
<li><p>The <code>getRStudioDesktop.r</code> and <code>getRStudioServer.r</code> scripts were updated for a change in <code>rvest</code></p></li>
<li><p>Two typos in the <code>tt.r</code> help message were correct (Aaron Wolen in <a href="https://github.com/eddelbuettel/littler/pull/86">#86</a>)</p></li>
<li><p>The message in <code>cranIncoming.r</code> was corrected.</p></li>
</ul></li>
<li><p>Changes in package</p>
<ul>
<li><p>Added Continuous Integration runner via <code>run.sh</code> from <a href="https://eddelbuettel.github.io/r-ci/">r-ci</a>.</p></li>
<li><p>Two vignettes got two extra vignette attributes.</p></li>
<li><p>The mkdocs-material documentation input was moved.</p></li>
<li><p>The basic unit tests were slightly refactored and updated.</p></li>
</ul></li>
</ul>
<h3 id="version-0.3.12-2020-10-04">Version 0.3.12 (2020-10-04)</h3>
<ul>
<li><p>Changes in examples</p>
<ul>
<li><p>Updates to scripts <code>tt.r</code>, <code>cos.r</code>, <code>cow.r</code>, <code>c4r.r</code>, <code>com.r</code></p></li>
<li><p>New script <code>installDeps.r</code> to install dependencies</p></li>
<li><p>Several updates tp script <code>check.r</code></p></li>
<li><p>New script <code>installBSPM.r</code> and <code>installRSPM.r</code> for binary package installation (Dirk and Iñaki in <a href="https://github.com/eddelbuettel/littler/pull/81">#81</a>)</p></li>
<li><p>New script <code>cranIncoming.r</code> to check in Incoming</p></li>
<li><p>New script <code>urlUpdate.r</code> validate URLs as R does</p></li>
</ul></li>
<li><p>Changes in package</p>
<ul>
<li><p>Travis CI now uses BSPM</p></li>
<li><p>A package documentation website was added</p></li>
<li><p>Vignettes now use <code>minidown</code> resulting in <em>much</em> reduced filesizes: from over 800kb to under 50kb (Dirk in <a href="https://github.com/eddelbuettel/littler/pull/83">#83</a>)</p></li>
</ul></li>
</ul>
<h3 id="version-0.3.11-2020-06-26">Version 0.3.11 (2020-06-26)</h3>
<ul>
<li><p>Changes in examples</p>
<ul>
<li><p>Scripts <code>check.r</code> and <code>rcc.r</code> updated to reflect updated <code>docopt</code> 0.7.0 behaviour of quoted arguments</p></li>
<li><p>The <code>roxy.r</code> script has a new ease-of-use option <code>-f | --full</code> regrouping two other options.</p></li>
</ul></li>
</ul>
<h3 id="version-0.3.10-2020-06-02">Version 0.3.10 (2020-06-02)</h3>
<ul>
<li><p>Changes in examples</p>
<ul>
<li><p>The <code>update.r</code> script only considers writeable directories.</p></li>
<li><p>The <code>rcc.r</code> script tries to report full logs by setting <code>_R_CHECK_TESTS_NLINES_=0</code>.</p></li>
<li><p>The <code>tt.r</code> script has an improved <code>ncpu</code> fallback.</p></li>
<li><p>Several installation and updating scripts set <code>_R_SHLIB_STRIP_</code> to <code>TRUE</code>.</p></li>
<li><p>A new script <code>installBioc.r</code> was added.</p></li>
<li><p>The <code>--error</code> option to <code>install2.r</code> was generalized (Sergio Oller in <a href="https://github.com/eddelbuettel/littler/pull/78">#78</a>).</p></li>
<li><p>The <code>roxy.r</code> script was extended a little.</p></li>
</ul></li>
<li><p>Changes in package</p>
<ul>
<li><p>Travis CI now uses R 4.0.0 and the bionic distro</p></li>
</ul></li>
</ul>
<h3 id="version-0.3.9-2019-10-27">Version 0.3.9 (2019-10-27)</h3>
<ul>
<li><p>Changes in examples</p>
<ul>
<li><p>The use of <code>call.</code> in <code>stop()</code> was corrected (Stefan Widgren in <a href="https://github.com/eddelbuettel/littler/pull/72">#72</a>).</p></li>
<li><p>New script <code>cos.r</code> to check (at rhub) on Solaris.</p></li>
<li><p>New script <code>compactpdf.r</code> to compact pdf files.</p></li>
<li><p>The <code>build.r</code> script now compacts vignettes and resaves data.</p></li>
<li><p>The <code>tt.r</code> script now supports parallel tests and side effects.</p></li>
<li><p>The <code>rcc.r</code> script can now report error codes.</p></li>
<li><p>The '–libloc' option to <code>update.r</code> was updated.</p></li>
<li><p>The <code>render.r</code> script can optionally compact pdfs.</p></li>
<li><p>New script <code>sweave.r</code> to render (and compact) pdfs.</p></li>
<li><p>New script <code>pkg2bibtex.r</code> to show bibtex entries.</p></li>
<li><p>The <code>kitten.r</code> script has a new option <code>--puppy</code> to add <code>tinytest</code> support in purring packages.</p></li>
</ul></li>
</ul>
<h3 id="version-0.3.8-2019-06-09">Version 0.3.8 (2019-06-09)</h3>
<ul>
<li><p>Changes in examples</p>
<ul>
<li><p>The <code>install.r</code> and <code>install2.r</code> scripts now use parallel installation using <code>options{Ncpu}</code> on remote packages.</p></li>
<li><p>The <code>install.r</code> script has an expanded help text mentioning the environment variables it considers.</p></li>
<li><p>A new script <code>tt.r</code> was added to support <code>tinytest</code>.</p></li>
<li><p>The rhub checking scripts now all suppress builds of manual and vignettes as asking for working latex appears to be too much.</p></li>
</ul></li>
<li><p>Changes in package</p>
<ul>
<li><p>On startup checks if <code>r</code> is in <code>PATH</code> and if not references new FAQ entry; text from <code>Makevars</code> mentions it too.</p></li>
</ul></li>
<li><p>Changes in documentation</p>
<ul>
<li><p>The FAQ vignette now details setting <code>r</code> to <code>PATH</code>.</p></li>
</ul></li>
</ul>
<h3 id="version-0.3.7-2019-03-15">Version 0.3.7 (2019-03-15)</h3>
<ul>
<li><p>Changes in examples</p>
<ul>
<li><p>The scripts <code>installGithub.r</code> and <code>install2.r</code> get a new option <code>-r | --repos</code> (Gergely Daroczi in <a href="https://github.com/eddelbuettel/littler/pull/67">#67</a>)</p></li>
</ul></li>
<li><p>Changes in build system</p>
<ul>
<li><p>The <code>AC_DEFINE</code> macro use rewritten to please R CMD check.</p></li>
</ul></li>
</ul>
<h3 id="version-0.3.6-2019-01-26">Version 0.3.6 (2019-01-26)</h3>
<ul>
<li><p>Changes in examples</p>
<ul>
<li><p>The scripts <code>install.r</code> and <code>install2.r</code> now support argument <code>"."</code>, and add it if called in a source directory.</p></li>
<li><p>The script <code>install2.r</code> can set <code>Ncpus</code> for <code>install.packages()</code> (Colin Gillespie in <a href="https://github.com/eddelbuettel/littler/pull/63">#63</a> fixing <a href="https://github.com/eddelbuettel/littler/pull/62">#62</a>)</p></li>
<li><p>The script <code>update.r</code> can also set <code>Ncpus</code> for <code>install.packages()</code>.</p></li>
<li><p>A new vignette "litter-faq" was added.</p></li>
</ul></li>
</ul>
<h3 id="version-0.3.5-2018-10-04">Version 0.3.5 (2018-10-04)</h3>
<ul>
<li><p>Changes in examples</p>
<ul>
<li><p>The script <code>roxy.r</code> now uses a cached copy of <code>roxygen2</code> version 6.0.1 (if available) as the current version 6.1.0 changed behaviour.</p></li>
<li><p>The script <code>rcc.r</code> was updated as the underlying <code>rcmdcheck</code> changed parameter order.</p></li>
<li><p>A new simpler wrapper <code>rchk.r</code> was added to use RHub with the <code>rchk</code> image.</p></li>
</ul></li>
<li><p>Changes in package</p>
<ul>
<li><p>Travis CI now uses the R 3.5 PPA</p></li>
</ul></li>
</ul>
<h3 id="version-0.3.4-2018-08-24">Version 0.3.4 (2018-08-24)</h3>
<ul>
<li><p>Changes in examples</p>
<ul>
<li><p>The shebang line is now <code>#!/usr/bin/env r</code> to work with either <code>/usr/local/bin/r</code> or <code>/usr/bin/r</code>.</p></li>
<li><p>New example script to only install packages not yet installed (Brandon Bertelsen in <a href="https://github.com/eddelbuettel/littler/pull/59">#59</a>); later added into <code>install2.r</code>.</p></li>
<li><p>Functions <code>getRStudioDesktop.r</code> and <code>getRStudioServer.r</code> updated their internal URLs.</p></li>
<li><p>Several minor enhancements were made to example scripts.</p></li>
</ul></li>
</ul>
<h3 id="version-0.3.3-2017-12-17">Version 0.3.3 (2017-12-17)</h3>
<ul>
<li><p>Changes in examples</p>
<ul>
<li><p>The script <code>installGithub.r</code> now correctly uses the <code>upgrade</code> argument (Carl Boettiger in <a href="https://github.com/eddelbuettel/littler/pull/49">#49</a>).</p></li>
<li><p>New script <code>pnrrs.r</code> to call the package-native registration helper function added in R 3.4.0</p></li>
<li><p>The script <code>install2.r</code> now has more robust error handling (Carl Boettiger in <a href="https://github.com/eddelbuettel/littler/pull/50">#50</a>).</p></li>
<li><p>New script <code>cow.r</code> to use R Hub's <code>check_on_windows</code></p></li>
<li><p>Scripts <code>cow.r</code> and <code>c4c.r</code> use <code>#!/usr/bin/env r</code></p></li>
<li><p>New option <code>--fast</code> (or <code>-f</code>) for scripts <code>build.r</code> and <code>rcc.r</code> for faster package build and check</p></li>
<li><p>The <code>build.r</code> script now defaults to using the current directory if no argument is provided.</p></li>
<li><p>The RStudio getters now use the <code>rvest</code> package to parse the webpage with available versions.</p></li>
</ul></li>
<li><p>Changes in package</p>
<ul>
<li><p>Travis CI now uses https to fetch script, and sets the group</p></li>
</ul></li>
</ul>
<h3 id="version-0.3.2-2017-02-14">Version 0.3.2 (2017-02-14)</h3>
<ul>
<li><p>Changes in examples</p>
<ul>
<li><p>New scripts <code>getRStudioServer.r</code> and <code>getRStudioDesktop.r</code> to download daily packages, currently defaults to Ubuntu amd64</p></li>
<li><p>New script <code>c4c.r</code> calling <code>rhub::check_for_cran()</code></p></li>
<li><p>New script <code>rd2md.r</code> to convert Rd to markdown.</p></li>
<li><p>New script <code>build.r</code> to create a source tarball.</p></li>
<li><p>The <code>installGitHub.r</code> script now use package <a href="https://CRAN.R-project.org/package=remotes"><span class="pkg">remotes</span></a> (PR <a href="https://github.com/eddelbuettel/littler/pull/44">#44</a>, <a href="https://github.com/eddelbuettel/littler/pull/46">#46</a>)</p></li>
</ul></li>
</ul>
<h3 id="version-0.3.1-2016-08-06">Version 0.3.1 (2016-08-06)</h3>
<ul>
<li><p>Changes in examples</p>
<ul>
<li><p><code>install2.r</code> now passes on extra options past <code>--</code> to <code>R CMD INSTALL</code> (PR <a href="https://github.com/eddelbuettel/littler/pull/37">#37</a> by Steven Pav)</p></li>
<li><p>Added <code>rcc.r</code> to run <code>rcmdcheck::rcmdcheck()</code></p></li>
<li><p>Added (still simple) <code>render.r</code> to render (R)markdown</p></li>
<li><p>Several examples now support the <code>-x</code> or <code>--usage</code> flag to show extended help.</p></li>
</ul></li>
<li><p>Changes in build system</p>
<ul>
<li><p>The <code>AM_LDFLAGS</code> variable is now set and used too (PR <a href="https://github.com/eddelbuettel/littler/pull/38">#38</a> by Mattias Ellert)</p></li>
<li><p>Three more directories, used when an explicit installation directory is set, are excluded (also <a href="https://github.com/eddelbuettel/littler/pull/38">#38</a> by Mattias)</p></li>
<li><p>Travis CI is now driven via <code>run.sh</code> from our fork, and deploys all packages as .deb binaries using our PPA where needed</p></li>
</ul></li>
<li><p>Changes in package</p>
<ul>
<li><p>SystemRequirements now mentions the need for <code>libR</code>, i.e. an R built with a shared library so that we can embed R.</p></li>
<li><p>The <a href="https://CRAN.R-project.org/package=docopt"><span class="pkg">docopt</span></a> and <a href="https://CRAN.R-project.org/package=rcmdcheck"><span class="pkg">rcmdcheck</span></a> packages are now suggested, and added to the Travis installation.</p></li>
<li><p>A new helper function <code>r()</code> is now provided and exported so that the package can be imported (closes <a href="https://github.com/eddelbuettel/littler/issues/40">#40</a>).</p></li>
<li><p>URL and BugReports links were added to DESCRIPTION.</p></li>
</ul></li>
<li><p>Changes in documentation</p>
<ul>
<li><p>The help output for <code>installGithub.r</code> was corrected (PR <a href="https://github.com/eddelbuettel/littler/pull/39">#39</a> by Brandon Bertelsen)</p></li>
</ul></li>
</ul>
<h3 id="version-0.3.0-2015-10-29">Version 0.3.0 (2015-10-29)</h3>
<ul>
<li><p>Changes in build system</p>
<ul>
<li><p>First CRAN Release as R package following nine years of source releases</p></li>
<li><p>Script <code>configure</code>, <code>src/Makevars.in</code> and remainder of build system rewritten to take advantage of the R package build infrastructure</p></li>
<li><p>Reproducible builds are better supported as the (changing) compilation timestamps etc are only inserted for 'verbose builds' directly off the git repo, but not for Debian (or CRAN) builds off the release tarballs</p></li>
</ul></li>
<li><p>Changes in littler functionality</p>
<ul>
<li><p>Also source <code>$R_HOME/etc/Rprofile.site</code> and <code>~/.Rprofile</code> if present</p></li>
</ul></li>
<li><p>Changes in littler documentation</p>
<ul>
<li><p>Added new vignette with examples</p></li>
</ul></li>
</ul>
</div>
