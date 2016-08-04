
1. Installation from distributed sources
========================================


1.1 Requirements
----------------


1.1.1 Requirements regarding R
------------------------------

    GNU R has to be installed in a shared-library configuration. This
    is not the default, so you may have to rebuild R.  If in doubt, look
    for a file 'libR.so' which should be in the lib/ directory of your
    R installtions, i.e. in

	/usr/local/lib/R/libR.so

    or

	/usr/lib/R/libR.so

    If R is not compiled with a shared library, you can rebuild from source
	with the following miminal recipe:

	# For GNU R, not littler
	./configure --enable-R-shlib
	make
	make install

    See the R manuals for details.

    Linux and OS X are known to be supported at this point.
    
    In all likelihood, the requirement of shared libary precludes
    installation of littler on Windoze.


1.1.2 Build-tools when building from git
----------------------------------------

    When building from the git repo, the autoconf / autotools / automake suite
    of programs is required. 

    On a Debian / Ubuntu based system do

        sudo apt-get install r-base-dev autoconf-dev

    to install R dependencies as well as build tools.

    When building from a release tarball, the auto* tools should not be
    required.


1.2 Basic Steps
---------------


1.2.1 Building from repo sources
--------------------------------

    The minimal recipe for installation should apply, i.e. start by

 	$ ./bootstrap

    which will first run the auto* tools to create the configure script.
   
    It the invokes the configure script to find the first path to R in your
    environment variable PATH.
   
    If you want the binary to be installation with a name other than 'r' 
    (which is a good idea on case-insensitive systems like OS X), then you 
    can set either --program-suffix or --program-prefix as in

      ./configure --program-suffix=sp			# creates rsp

    and 

      ./configure --program-prefix=little		# creates littler

    If there's another R installation you want to use, then you'll have to 
    readjust the PATH. For example:

		$ PATH=~/R-trunk/bin:$PATH ./configure

    Then

	$ make

    should build the 'r' binary, and 

	$ sudo make install

    should install it, as well as the manual page. Note that the renaming is
    only done at the installation stage so you must run (sudo) make install.


2. Installation from GIT
========================


2.1 Requirements
----------------

    As note above, but you will also need autoconf, aclocal, and of course
    git itself.


2.2 GIT clone
-------------

    Anonymous checkout is available via 

	$ git clone https://github.com/eddelbuettel/littler.git


2.3 Build preparation
---------------------

    You can simply run the catch-all script 'bootstrap':

	$ bootstrap

    as detailed in 1.2 above and produces a new executable.

    If you want to set configure options, you can do so too after an
    initial 'bootstrap' call.



3. Binary Installation
======================

3.1 Debian
----------

    Calling

	$ sudo apt-get install littler

    is all it takes if your sources.list file points to testing or
    unstable.


4. Feedback
===========

    Is encouraged ;-)

    
	- Jeffrey Horner <jeff.horner@vanderbilt.edu>
	- Dirk Eddelbuettel <edd@debian.org> 

 
