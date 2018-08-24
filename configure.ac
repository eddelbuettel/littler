#   -*- mode: Autoconf; tab-width: 4; -*-
# Process this file with autoconf to produce a configure script.      

# require at least autoconf 2.61
AC_PREREQ(2.61)

# Every other copy of the package version number gets its value from here
# The m4_esyscmd_s invocation is due to an excellent StackOverflow answer.
#AC_INIT([littler], m4_esyscmd_s([awk -e '/^Version:/ {print $2}' DESCRIPTION]))
AC_INIT([littler], [0.3.4])

#  Look for ancillary configure tools in tools
dnl AC_CONFIG_AUX_DIR(tools)

# Ensure R_HOME is set yet respect a previously set value
: ${R_HOME=`R RHOME`}
if test -z "${R_HOME}"; then
    AC_MSG_ERROR([Could not determine R_HOME.])   
fi
RPROG=${R_HOME}/bin/R
CC=`${RPROG} CMD config CC`
AM_CFLAGS=`${RPROG} CMD config CFLAGS`
AM_LDFLAGS=`${RPROG} CMD config LDFLAGS`

dnl # Options for Automake
dnl #
dnl # no-texinfo.tex - obviously means don't include the big texinfo.tex file
dnl #                  in the dist.
dnl # foreign - treats our package as non-gnu, essentially excudluding strict
dnl #           checks for certain files like ChangeLog, NEWS, README, etc
dnl #
dnl AM_INIT_AUTOMAKE( no-texinfo.tex foreign )

# create a config.h file 
AC_CONFIG_HEADERS(src/config.h)

AC_SUBST(VERSION)

# commenting this out relieves us from requiring tools/ with all the scripts
dnl AC_CANONICAL_HOST

# Checks for programs.
dnl AC_PROG_INSTALL
AC_PROG_CC

# Checks for libraries.

# Checks for header files.
dnl AC_HEADER_STDC
dnl AC_CHECK_HEADERS( stdio.h string.h errno.h stdlib.h sys/types.h sys/stat.h unistd.h)
AC_CHECK_HEADER([getopt.h],
    [AC_DEFINE([HAVE_GETOPT_H], 1, [Define to 1 if you have <getopt.h>.])],
	    [AC_MSG_ERROR([littler needs getopt support to run. Please find and install it.])])

AC_HEADER_MAJOR

# Checks for library functions.

AC_CHECK_FUNC(setenv,AC_DEFINE(HAVE_SETENV,1, [Define if you have the setenv function.]))
AC_CHECK_FUNC(gettimeofday,
    AC_DEFINE(HAVE_GETTIMEOFDAY,1, [Define if you have the gettimeofday function.]))
AC_CHECK_FUNC(time,AC_DEFINE(HAVE_TIME,1, [Define if you have the time function.]))

# Checks for typedefs, structures, and compiler characteristics.

# Test the R version for shared library
AC_DEFUN([R_PROG],[
	AC_MSG_CHECKING([if R was built as a shared library])

    # Unset any user defined notion of R_HOME
    export R_HOME

    # First test if R was found
    if test "${RPROG}" = ""; then
    	echo
        echo "R not found. Please update your PATH variable to include the R bin directory"
        echo
        AC_MSG_ERROR( aborting! )
    fi

    # Now make sure that a well known include file exists
    # and the libR.so
    if ${RPROG} CMD config --ldflags 2>/dev/null | grep -v 'R was not built as a shared library' >/dev/null; then
    	AM_CFLAGS="${AM_CFLAGS} `${RPROG} CMD config --cppflags`"
        AM_LDFLAGS="${AM_LDFLAGS} `${RPROG} CMD config --ldflags`"

        # Now add the various libraries for linking
        AM_LDFLAGS="${AM_LDFLAGS} `${RPROG} CMD config BLAS_LIBS | grep -v ERROR`"
        AM_LDFLAGS="${AM_LDFLAGS} `${RPROG} CMD config LAPACK_LIBS | grep -v ERROR`"

        # are we on apple or not
        if test "$build_vendor" != "apple"; then
        	RUN_NAMETOOL=""
        fi
        AC_MSG_RESULT([yes])
	else
    	echo
        echo "R was not built as a shared library"
        echo
        echo "Either build it with one, or use another install of R"
        echo
        AC_MSG_ERROR( aborting! )
    fi

])

R_PROG


## Check for .git directory
if test -d ".git/"; then
    GITREVISION=`git log --format=fuller | head -6 | awk '/^commit / {print substr($2,1,7)}'`
    GITDATE=`git log --format=fuller | head -6 | awk '/^CommitDate: / {print $2, $3, $4, $5, $6, $7}'`
    AC_DEFINE(VERBOSE_BUILD)
else
    GITREVISION=""
    GITDATE=""
fi    

# Now check if certain libraries should be linked in

# Java
AC_ARG_WITH([java-libs],
	[AC_HELP_STRING([--with-java-libs],
        [Link littler to R's java libraries])],
              [if test x$"$withval" != xno; then
                	AM_LDFLAGS="${AM_LDFLAGS} `${RPROG} CMD config JAVA_LIBS | grep -v ERROR`"
               fi],
)

dnl # Tcl/TK
dnl AC_ARG_WITH([tcltk-libs],
dnl [AC_HELP_STRING([--with-tcltk-libs],
dnl             [Link littler to R's tcltk libraries])],
dnl     [
dnl             if test x$"$withval" != xno; then
dnl                             AM_LDFLAGS="${AM_LDFLAGS} `${RPROG} CMD config TCLTK_LIBS | grep -v ERROR`"
dnl             fi
dnl     ],
dnl )

dnl # R version check 
dnl # Note that this may fail really old versions of R as the string wasn't always "R version x.y.z ..." 
dnl r_version=`${RPROG} --version | head -1 | cut -f3 -d" " `
dnl case ${r_version} in
dnl     1.*.*|2.0.*|2.1.*|2.2.*|2.3.0)
dnl              AC_MSG_ERROR([R version ${r_version} is too old. Please upgrade to a more recent version.])
dnl                      ;;
dnl esac

#AC_MSG_RESULT([AM_LDFLAGS is now: ${AM_LDFLAGS}])
# get other linker flags for rpath 
EXTRA_LDFLAGS=`${RPROG} --silent --vanilla --slave --file=src/scripts/ldflags.R`
#AC_MSG_RESULT([EXTRA_LDFLAGS is now: ${EXTRA_LDFLAGS}])
#AM_LDFLAGS="${AM_LDFLAGS} ${EXTRA_LDFLAGS}"
#AC_MSG_RESULT([AM_LDFLAGS is now: ${AM_LDFLAGS}])

# Are we building for Mac OS X? this program will exist if so.
AC_PATH_PROG(NAMETOOL, install_name_tool)

AC_DEFUN([NAMETOOL_FUN],[
	if test "${NAMETOOL}" != ""; then
    	RUN_NAMETOOL="${NAMETOOL} -change libR.dylib `${RPROG} RHOME`/lib/libR.dylib r"
    fi
])

NAMETOOL_FUN

AC_SUBST(RPROG)
AC_SUBST(CC)
AC_SUBST(AM_CFLAGS)
AC_SUBST(AM_LDFLAGS)
AC_SUBST(EXTRA_LDFLAGS)
AC_SUBST(RUN_NAMETOOL)
AC_SUBST(GITREVISION)
AC_SUBST(GITDATE)

AC_OUTPUT([src/Makevars src/gitversion.h])


