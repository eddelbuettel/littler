/*                  -*- mode: C; c-indent-level: 8; c-basic-offset: 8; -*-
 *
 *  littler - Provides hash-bang (#!) capability for R (www.r-project.org)
 *
 *  Copyright (C) 2006 Jeffrey Horner and Dirk Eddelbuettel
 *
 *  littler is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 *  $Id$
 */

#include "config.h"
#include "littler.h"
#include "svnversion.h"
#include "autoloads.h"

#include <getopt.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>

#include <R.h>
#include <Rversion.h>
#include <Rdefines.h>
#define R_INTERFACE_PTRS
#include <Rinterface.h>
#include <R_ext/Parse.h>

#define R_240 132096 /* This is set in Rversion.h */

int verbose=0;
extern int R_Visible; /* We're cheating here, as this undocumented and not in the
                       * R embedded interface.
					   * 
					   * This variable controls when an expression is printed
					   * via PrintValue()
					   */

/* these two are being filled by autoconf and friends via config.h */
/* VERSION */
const char *programName = PACKAGE;
const char *binaryName = "r";

#if (R_VERSION < R_240) /* we can delete this code after R 2.4.0 release */
/* 
 * Exported by libR
 * Shouldn't this prototype exist in a header?
 * It will in R-2.4.x.
 */
extern int Rf_initEmbeddedR(int argc, char *argv[]);
#endif

#ifndef HAVE_SETENV
int  setenv(char *name, char *value, int clobber){
	char   *cp;

	if (clobber == 0 && getenv(name) != 0)
		return (0);
	if ((cp = malloc(strlen(name) + strlen(value) + 2)) == 0)
		return (1);
	sprintf(cp, "%s=%s", name, value);
	return (putenv(cp));
}

#endif 

int source(char *file){
	SEXP val, expr, s, f, p;
	int errorOccurred;

	/* Find source function */
	s = Rf_findFun(Rf_install("source"), R_GlobalEnv);
	PROTECT(s);

	/* Make file argument */
	PROTECT(f = NEW_CHARACTER(1));
	SET_STRING_ELT(f, 0, COPY_TO_USER_STRING(file));

	/* Make print.eval argument */
    PROTECT(p = NEW_LOGICAL(1));
	LOGICAL_DATA(p)[0] = (verbose)? TRUE : FALSE;

	/* expression source(f,print.eval=p) */
	PROTECT(expr = allocVector(LANGSXP,3));
	SETCAR(expr,s); 
	SETCAR(CDR(expr),f);
	SETCAR(CDR(CDR(expr)), p);
	SET_TAG(CDR(CDR(expr)),Rf_install("print.eval"));

	errorOccurred=0;
	val = R_tryEval(expr,NULL,&errorOccurred);
	UNPROTECT(4);

	return errorOccurred;
}

/* Autoload default packages and names from autoloads.h
 *
 * This function behaves in almost every way like
 * R's autoload:
 * function (name, package, reset = FALSE, ...)
 * {
 *     if (!reset && exists(name, envir = .GlobalEnv, inherits = FALSE))
 *        stop("an object with that name already exists")
 *     m <- match.call()
 *     m[[1]] <- as.name("list")
 *     newcall <- eval(m, parent.frame())
 *     newcall <- as.call(c(as.name("autoloader"), newcall))
 *     newcall$reset <- NULL
 *     if (is.na(match(package, .Autoloaded)))
 *        assign(".Autoloaded", c(package, .Autoloaded), env = .AutoloadEnv)
 *     do.call("delayedAssign", list(name, newcall, .GlobalEnv,
 *                                                         .AutoloadEnv))
 *     invisible()
 * }
 *
 * What's missing is the updating of the string vector .Autoloaded with the list
 * of packages, which by my code analysis is useless; meaning it's for informational
 * purposes only.
 *
 */
void autoloads(void){
	SEXP da, dacall, al, alcall, AutoloadEnv, name, package;
	int i,j, idx=0, errorOccurred, ptct;

	/* delayedAssign call*/
	PROTECT(da = Rf_findFun(Rf_install("delayedAssign"), R_GlobalEnv));
	PROTECT(AutoloadEnv = Rf_findVar(Rf_install(".AutoloadEnv"), R_GlobalEnv));
	if (AutoloadEnv == R_NilValue){
		fprintf(stderr,"%s: Cannot find .AutoloadEnv!\n", programName);
		exit(1);
	}
	PROTECT(dacall = allocVector(LANGSXP,5));
	SETCAR(dacall,da);
	/* SETCAR(CDR(dacall),name); */          /* arg1: assigned in loop */
	/* SETCAR(CDR(CDR(dacall)),alcall); */  /* arg2: assigned in loop */
	SETCAR(CDR(CDR(CDR(dacall))),R_GlobalEnv); /* arg3 */
	SETCAR(CDR(CDR(CDR(CDR(dacall)))),AutoloadEnv); /* arg3 */


	/* autoloader call */
	PROTECT(al = Rf_findFun(Rf_install("autoloader"), R_GlobalEnv));
	PROTECT(alcall = allocVector(LANGSXP,3));
	SET_TAG(alcall, R_NilValue); /* just like do_ascall() does */
	SETCAR(alcall,al);
	/* SETCAR(CDR(alcall),name); */          /* arg1: assigned in loop */
	/* SETCAR(CDR(CDR(alcall)),package); */  /* arg2: assigned in loop */

	ptct = 5;
	for(i = 0; i < packc; i++){
		 idx += (i != 0)? packobjc[i-1] : 0;
		for (j = 0; j < packobjc[i]; j++){
			/*printf("autload(%s,%s)\n",packobj[idx+j],pack[i]);*/

			PROTECT(name = NEW_CHARACTER(1));
			PROTECT(package = NEW_CHARACTER(1));
			SET_STRING_ELT(name, 0, COPY_TO_USER_STRING(packobj[idx+j]));
			SET_STRING_ELT(package, 0, COPY_TO_USER_STRING(pack[i]));

			/* Set up autoloader call */
			PROTECT(alcall = allocVector(LANGSXP,3));
			SET_TAG(alcall, R_NilValue); /* just like do_ascall() does */
			SETCAR(alcall,al);
			SETCAR(CDR(alcall),name);
			SETCAR(CDR(CDR(alcall)),package);

			/* Setup delayedAssign call */
			SETCAR(CDR(dacall),name);
			SETCAR(CDR(CDR(dacall)),alcall);

			R_tryEval(dacall,R_GlobalEnv,&errorOccurred);
			if (errorOccurred){
				fprintf(stderr,"%s: Error calling delayedAssign!\n", programName);
				exit(1);
			}

			ptct += 3;
		}
	}
	UNPROTECT(ptct);
}

/* Line reading code */
typedef struct membuf_st {
	    int size;
		int count;
		unsigned char *buf;
} *membuf_t;

membuf_t init_membuf(int sizebytes){
	membuf_t lb = malloc(sizebytes+sizeof(struct membuf_st));

	if (lb == NULL) {
		fprintf(stderr,"%s: init_membuf() failed! Exiting!!!\n\n", programName);
		exit(1);
		return NULL; /* unreached */
	}

	lb->size = sizebytes;
	lb->count = 0;
	lb->buf = (unsigned char *)lb+sizeof(struct membuf_st);

	return lb;
}

void destroy_membuf(membuf_t lb){
	free(lb);
}

/* Use power of 2 resizing */
membuf_t resize_membuf(membuf_t *plb){
	membuf_t lb = *plb;
	lb = *plb = realloc(lb,lb->size*2+sizeof(struct membuf_st));
	if (lb == NULL) {
		fprintf(stderr,"%s: init_membuf() failed! Exiting!!!\n\n", programName);
		exit(1);
		return NULL; /* unreached */
	}

	lb->size =  lb->size * 2;
	lb->buf = (unsigned char *)lb+sizeof(struct membuf_st);

	return lb;
}

membuf_t rewind_membuf(membuf_t *mb){
	(*mb)->count = 0;
	return *mb;
}

membuf_t add_to_membuf(membuf_t *pmb,char *buf){
	membuf_t mb = *pmb;
	int buflen = strlen(buf);

	while ((buflen + (mb->count)) >= mb->size){
		mb = *pmb = resize_membuf(pmb);
	}

	memcpy(mb->buf+mb->count,buf,buflen);
	mb->buf[mb->count+buflen] = '\0';
	mb->count += buflen;

	return mb;
}


/* returns 1 on reading another line or until EOF, 0 on EOF */
int readline_stdin(membuf_t *plb){
	membuf_t lb = *plb;
	unsigned int offset=0;
	char *str;

	do {
		lb->buf[lb->size-2] = '\0'; /* mark last char position */
		str = fgets((char*)lb->buf+offset,lb->size-offset,stdin);

		/* EOF or error */ 
		if (str == NULL){ 
			return (offset)? 1 : 0;
		}

		/* Did we read a whole line? */
		if (lb->buf[lb->size-2] != '\0' && lb->buf[lb->size-2] != '\n'){
			/* No. read again. */
			offset = lb->size-1;
			lb = *plb = resize_membuf(plb);
		} else {
			/* Yes. return */
			return 1;
		}
	} while(1);	
}

int parse_eval(membuf_t *pmb, char *line, int lineno){
	membuf_t mb = *pmb;
	ParseStatus status;
	SEXP cmdSexp, cmdexpr, ans = R_NilValue;
	int i, errorOccurred;

	mb = *pmb = add_to_membuf(pmb,line);

	PROTECT(cmdSexp = allocVector(STRSXP, 1));
	SET_STRING_ELT(cmdSexp, 0, mkChar((char*)mb->buf));
	cmdexpr = PROTECT(R_ParseVector(cmdSexp, -1, &status));
	switch (status){
		case PARSE_OK:
			/* Loop is needed here as EXPSEXP might be of length > 1 */
			for(i = 0; i < length(cmdexpr); i++){
				ans = R_tryEval(VECTOR_ELT(cmdexpr, i),NULL,&errorOccurred);
				if (errorOccurred) return 1;
				if (verbose && R_Visible){
					PrintValue(ans);
				}
			}
			mb = *pmb = rewind_membuf(pmb);
		break;
		case PARSE_INCOMPLETE:
			/* need to read another line */
		break;
		case PARSE_NULL:
			fprintf(stderr, "%s: ParseStatus is null (%d)\n", programName, status);
			return 1;
		break;
		case PARSE_ERROR:
			fprintf(stderr,"Parse Error line %d: \"%s\"\n", lineno, line);
			return 1;
		break;
		case PARSE_EOF:
			fprintf(stderr, "%s: ParseStatus is eof (%d)\n", programName, status);
		break;
		default:
			fprintf(stderr, "%s: ParseStatus is not documented %d\n", programName, status);
			return 1;
		break;
	}
	UNPROTECT(2);
	return 0;
}

extern char *R_TempDir;

void littler_InitTempDir()
{
	char *tmp;

	#if (R_VERSION < R_240) /* we can delete this code after R 2.4.0 release */
	if (R_TempDir){
		/* Undo R's InitTempdir() and do something sane */
		if (rmdir(R_TempDir) != 0){
			perror("Fatal Error: could not remove R's TempDir!");
			exit(1);
		}
	}
	#endif

	tmp = getenv("TMPDIR");
	if (tmp == NULL) {
		tmp = getenv("TMP");
			if (tmp == NULL) { 
				tmp = getenv("TEMP");
				if (tmp == NULL) 
					tmp = "/tmp";
			}
	}

	R_TempDir=tmp;

	if (setenv("R_SESSION_TMPDIR",tmp,1) != 0){
		perror("Fatal Error: couldn't set/replace R_SESSION_TMPDIR!");
		exit(1);
	}
}

/* For stdin processing: if an error condition occurs and getOption("error") == NULL,
 * we go here. 
 */
void littler_CleanUp(SA_TYPE s, int a, int b){
	exit(1);
}

void showHelpAndExit() {
	printf("\n" 						
	       "Usage: %s [options] [-|file]"
	       "\n\n"
	       "Launch GNU R to execute the R commands supplied in the specified file, or\n"
	       "from stdin if '-' is used. Suitable for so-called shebang '#!/'-line scripts.\n"
	       "\n"
	       "Options:\n"
	       "  -h, --help           Give this help list\n"
	       "      --usage          Give a short usage message\n"
	       "  -V, --version        Show the version number\n"
	       "  -v, --vanilla        Pass the '--vanilla' option to R\n"  
	       "  -p, --verbose        Print the value of expressions to the console\n"  
	       "  -e, --eval  expr     Let R evaluate 'expr'\n"
	       "\n\n",
	       binaryName);
	exit(-1);
}

void showVersionAndExit() {
	printf("%s ('%s') version %s\n\tsvn revision %s as of %s\n\tbuilt at %s on %s\n", 
	       binaryName, programName, VERSION, 
	       svnrevision, svndate, compiletime, compiledate);
	printf("\tusing GNU R ");
	if(strcmp(R_SVN_REVISION, "unknown")==0) {
		printf("Version %s.%s %s (%s-%s-%s)",
				R_MAJOR, R_MINOR, R_STATUS, R_YEAR, R_MONTH, R_DAY);
	} else {
		if(strlen(R_STATUS)==0){
			printf("Version %s.%s (%s-%s-%s)",
					R_MAJOR, R_MINOR, R_YEAR, R_MONTH, R_DAY);
		}
		else{
			printf("Version %s.%s %s (%s-%s-%s r%s)",
					R_MAJOR, R_MINOR, R_STATUS, R_YEAR, R_MONTH, R_DAY,
					R_SVN_REVISION);
		}
	}
  	printf("\n\nCopyright (C) 2006 Jeffrey Horner and Dirk Eddelbuettel\n"
	       "\n"
	       "%s is free software and comes with ABSOLUTELY NO WARRANTY.\n"
	       "You are welcome to redistribute it under the terms of the\n"
	       "GNU General Public License.  For more information about\n"
	       "these matters, see http://www.gnu.org/copyleft/gpl.html.\n\n",
	       binaryName);
	exit(-1);       
}

void showUsageAndExit() {
  	printf("\n" 						
	       "%s (aka '%s') can be used in three main modes.\n\n"
	       "The first is via the so-called 'shebang' support it provides for GNU R.\n"
	       "Suppose '%s' is installed in /usr/local/bin/%s. Then the first line of a\n"
	       "script can be written as \"#!/usr/local/bin/%s\" and the rest of the file\n"
	       "can contain standard R commands.  By setting executable permissions\n"
	       "on the file, one can now create executable  R scripts.\n\n" 
	       "The second is to supply a filename with commands that are to be\n"
	       "evaluated.\n\n"
	       "The third use is in standard compound command-line expressions common\n" 
	       "under Unix (so called 'command pipes') as '%s' can take arguments\n"
	       "from stdin if the special filename '-' is used to select stdin.\n\n"
	       "More documentation is provided in the '%s' manual page and via\n"
	       "the tests directory in the sources.\n\n",
	       binaryName, programName, binaryName, binaryName, binaryName,  programName, binaryName);
	exit(-1);       
}

int main(int argc, char **argv){

	/* R embedded arguments, and optional arguments to be picked via cmdline switches */
	char *R_argv[] = {(char*)programName, "--gui=none", "--no-save", "--no-readline", "--silent", "", ""};
	char *R_argv_opt[] = {"--vanilla", "--slave"};
	int R_argc = (sizeof(R_argv) - sizeof(R_argv_opt) ) / sizeof(R_argv[0]);
	int i, nargv, c, optpos=0, vanilla=0;
	char *evalstr = NULL;
	SEXP s_argv;

	static struct option optargs[] = {
		{"help",    no_argument,       NULL, 'h'}, 		/* --help also has short option -h */
		{"usage",   no_argument,       0,    0},
		{"version", no_argument,       NULL, 'V'},
		{"vanilla", no_argument,       NULL, 'v'},
		{"eval",    required_argument, NULL, 'e'},
		{"verbose", no_argument,       NULL, 'p'},
		{0, 0, 0, 0}
	};
	while ((c = getopt_long(argc, argv, "+hVve:np", optargs, &optpos)) != -1) {
		switch (c) {	
			case 0:					/* numeric 0 is code for a long option */
				/* printf ("Got option %s %d", optargs[optpos].name, optpos);*/
				switch (optpos) {		/* so switch on the position in the optargs struct */
					/* cases 0, 2, and 3 can't happen as they are covered by the '-h', */ 
					/* '-V', and '-v' equivalences */
					case 1:
						showUsageAndExit();
						break;				/* never reached */
					case 5:
						verbose = 1;
						break;
					default:
						printf("Uncovered option position '%d'. Try `%s --help' for help\n", 
                                                       optpos, programName);
						exit(-1);
				}
				break;
			case 'h':				/* -h is the sole short option, cf getopt_long() call */
				showHelpAndExit();
				break;  			/* never reached */
			case 'e':
				evalstr = optarg;
				break;
			case 'v':	
				vanilla=1;
				break;
			case 'p':	
				verbose=1;
				break;
			case 'V':
				showVersionAndExit();
				break;  			/* never reached */
			default:
				printf("Unknown option '%c'. Try `%s --help' for help\n",(char)c, programName);
				exit(-1);
		}
	}
 	if (vanilla) {
		R_argv[R_argc++] = R_argv_opt[0];
	}
	if (!verbose) {
		R_argv[R_argc++] = R_argv_opt[1];
	}

	#ifdef DEBUG
		printf("R_argc %d sizeof(R_argv) \n", R_argc, sizeof(R_argv));
		for (i=0; i<7; i++) {
			printf("R_argv[%d] = %s\n", i, R_argv[i]);
		}
		printf("optind %d, argc %d\n", optind, argc);
		for (i=0; i<argc; i++) {
			printf("argv[%d] = %s\n", i, argv[i]);
		}
	#endif

	/* Now, argv[optind] could be a file we want to source -- if we're
	 * in the 'shebang' case -- or it could be an expression from stdin.
	 * So call stat(1) on it, and if its a file we will treat it as such.
	 */
	struct stat sbuf;
	if (optind < argc) { 
		if ((strcmp(argv[optind],"-") != 0) && (stat(argv[optind],&sbuf) != 0)) {
			perror(argv[optind]);
			exit(1);
		}
	}

	/* Setenv R_HOME: insert or replace into environment.
	 * The RHOME macro is defined during configure
	 */
	if (setenv("R_HOME",RHOME,1) != 0){
		perror("ERROR: couldn't set/replace R_HOME");
		exit(1);
	}

	/* We don't require() default packages upon startup; rather, we
	 * set up delayedAssign's instead. see autoloads().
	 */
	if (setenv("R_DEFAULT_PACKAGES","NULL",1) != 0){
		perror("ERROR: couldn't set/replace R_DEFAULT_PACKAGES");
		exit(1);
	}

	/* Don't let R set up its own signal handlers */
	R_SignalHandlers = 0;

	#ifdef CSTACK_DEFNS
	/* Don't do any stack checking */
	R_CStackLimit = -1;
	#endif

	#if (R_VERSION >= R_240) /* we'll take out the ifdef after R 2.4.0 release */
	littler_InitTempDir();
	#endif

	Rf_initEmbeddedR(R_argc, R_argv);

	#if (R_VERSION < R_240) /* we can delete this code after R 2.4.0 release */
	littler_InitTempDir();
	#endif

	ptr_R_CleanUp = littler_CleanUp;

	/* Force all default package to be dynamically required */
	autoloads();

	/* Place any argv arguments into argv vector in Global Environment */
	if ((argc - optind) > 1){
		/* Build string vector */
		nargv = argc - optind - 1;
		PROTECT(s_argv = allocVector(STRSXP,nargv));
		for (i = 0; i <nargv; i++){
			STRING_PTR(s_argv)[i] = mkChar(argv[i+1+optind]);
			#ifdef DEBUG
				printf("Passing %s to R\n", argv[i+1+optind]);
			#endif
		}
		UNPROTECT(1);

		setVar(install("argv"),s_argv,R_GlobalEnv);
	} else {
		setVar(install("argv"),R_NilValue,R_GlobalEnv);
	}

	/* Now determine which R code to evaluate */

	int exit_val;
	if (evalstr != NULL) {				
		/* we have a command line expression to evaluate */
		membuf_t pb = init_membuf(512);
		exit_val = parse_eval(&pb, evalstr, 1);
		destroy_membuf(pb);
	} else if (optind < argc && (strcmp(argv[optind],"-") != 0)) {	
		/* call R function source(filename) */
		exit_val = source(argv[optind]);
	} else {
		/* Or read from stdin */
		membuf_t lb = init_membuf(1024);
		membuf_t pb = init_membuf(1024);
		int lineno = 1;
		while(readline_stdin(&lb)){
			exit_val = parse_eval(&pb,(char*)lb->buf,lineno++);
			if (exit_val) break;
		}
		destroy_membuf(lb);
		destroy_membuf(pb);
	}
	exit(exit_val);
}
