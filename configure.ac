#   -*- mode: Autoconf; tab-width: 4; -*-
# Process this file with autoconf to produce a configure script.

# require at least autoconf 2.69
AC_PREREQ([2.69])

# Every other copy of the package version number gets its value from here
# The m4_esyscmd_s invocation is due to an excellent StackOverflow answer.
# Sadly it breaks under Debian package builds (likely due to a missing component)
AC_INIT([littler],[0.3.21],[edd@debian.org])

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
dnl AC_CHECK_HEADERS( stdio.h string.h errno.h stdlib.h sys/types.h sys/stat.h unistd.h)
AC_CHECK_HEADER([getopt.h],
    [AC_DEFINE([HAVE_GETOPT_H], 1, [Define to 1 if you have <getopt.h>.])],
	    [AC_MSG_ERROR([littler needs getopt support to run. Please find and install it.])])

AC_HEADER_MAJOR

# Checks for library functions.
AC_CHECK_FUNC(setenv,AC_DEFINE(HAVE_SETENV,1,[Define if you have the setenv function.]))
AC_CHECK_FUNC(clock_gettime,AC_DEFINE(HAVE_CLOCK_GETTIME,1,[Define if you have clock_gettime.]))
AC_CHECK_FUNC(realtime,AC_DEFINE(HAVE_REALTIME,1,[Define if you have realtime.]))
AC_CHECK_FUNC(gettimeofday,AC_DEFINE(HAVE_GETTIMEOFDAY,1,[Define if you have the gettimeofday function.]))
AC_CHECK_FUNC(time,AC_DEFINE(HAVE_TIME,1,[Define if you have the time function.]))
AC_CHECK_FUNC(realpath,AC_DEFINE(HAVE_REALPATH,1,[Define if you have the realpath function.]))


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
    AC_DEFINE([VERBOSE_BUILD],[1],[Verbose build with git revision and date information])
else
    GITREVISION=""
    GITDATE=""
fi

# Now check if certain libraries should be linked in

# Java
AC_ARG_WITH([java-libs],
	[AS_HELP_STRING([--with-java-libs],[link littler to the R java libraries])],
              [if test "${withval}" != no; then
                	AM_LDFLAGS="${AM_LDFLAGS} `${RPROG} CMD config JAVA_LIBS | grep -v ERROR`"
               fi],
)

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

AC_CONFIG_FILES([src/Makevars src/gitversion.h])
AC_OUTPUT
