#   -*- mode: Autoconf; tab-width: 4; -*-
# Process this file with autoconf to produce a configure script.      

# Every other copy of the package version number gets its value from here
AC_INIT(littler,0.2.1)

#  Look for ancillary configure tools in tools
AC_CONFIG_AUX_DIR(tools)

# Options for Automake
#
# no-texinfo.tex - obviously means don't include the big texinfo.tex file
#                  in the dist.
# foreign - treats our package as non-gnu, essentially excudluding strict
#           checks for certain files like ChangeLog, NEWS, README, etc
#
AM_INIT_AUTOMAKE( no-texinfo.tex foreign )

# create a config.h file (Automake will add -DHAVE_CONFIG_H)
AC_CONFIG_HEADERS(config.h)

AC_SUBST(VERSION)

AC_CANONICAL_HOST

# Checks for programs.
AC_PROG_INSTALL
AC_PROG_CC

# Checks for libraries.

# Checks for header files.
AC_HEADER_STDC
AC_CHECK_HEADERS( stdio.h string.h errno.h stdlib.h sys/types.h sys/stat.h unistd.h)
AC_CHECK_HEADER([getopt.h],
	[AC_DEFINE([HAVE_GETOPT_H], 1,
		 [Define to 1 if you have <getopt.h>.])],
	[AC_MSG_ERROR([littler needs getopt support to run. Please find and install it.])])

AC_HEADER_MAJOR

# Checks for library functions.

AC_CHECK_FUNC(setenv,AC_DEFINE(HAVE_SETENV,1, [Define if you have the setenv function.]))
AC_CHECK_FUNC(gettimeofday,AC_DEFINE(HAVE_GETTIMEOFDAY,1, [Define if you have the gettimeofday function.]))
AC_CHECK_FUNC(time,AC_DEFINE(HAVE_TIME,1, [Define if you have the time function.]))

# Checks for typedefs, structures, and compiler characteristics.

# Let configure find R using the AC_PATH_PROG macro
AC_PATH_PROG(RPROG,R)

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
		AM_CFLAGS=`${RPROG} CMD config --cppflags`
		AM_LDFLAGS="`${RPROG} CMD config --ldflags`"

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

# Now check if certain libraries should be linked in

# Java
AC_ARG_WITH([java-libs],
        [AC_HELP_STRING([--with-java-libs],
        [Link littler to R's java libraries])],
        	[
		    if test x$"$withval" != xno; then
			   	AM_LDFLAGS="${AM_LDFLAGS} `${RPROG} CMD config JAVA_LIBS | grep -v ERROR`"
       		fi      
        	],
)

# Tcl/TK
AC_ARG_WITH([tcltk-libs],
[AC_HELP_STRING([--with-tcltk-libs],
		[Link littler to R's tcltk libraries])],
	[
		if test x$"$withval" != xno; then
				AM_LDFLAGS="${AM_LDFLAGS} `${RPROG} CMD config TCLTK_LIBS | grep -v ERROR`"
		fi
	],
)

# R version check 
# Note that this may fail really old versions of R as the string wasn't always "R version x.y.z ..." 
r_version=`${RPROG} --version | head -1 | cut -f3 -d" " `
case ${r_version} in
	1.*.*|2.0.*|2.1.*|2.2.*|2.3.0)
		 AC_MSG_ERROR([R version ${r_version} is too old. Please upgrade to a more recent version.])
     		 ;;
esac


# Are we building for Mac OS X? this program will exist if so.
AC_PATH_PROG(NAMETOOL,install_name_tool)

AC_DEFUN([NAMETOOL_FUN],[
	if test "${NAMETOOL}" != ""; then
			RUN_NAMETOOL="${NAMETOOL} -change libR.dylib `${RPROG} RHOME`/lib/libR.dylib `cat ldflags.txt` r"
	fi
])

NAMETOOL_FUN

AC_SUBST(RPROG)
AC_SUBST(RUN_NAMETOOL)
AC_SUBST(AM_CFLAGS)
AC_SUBST(AM_LDFLAGS)

AC_OUTPUT(Makefile)
