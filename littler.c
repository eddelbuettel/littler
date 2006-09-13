/* 
 * littler: scripting support for R
 *
 * Usage:
 *
 * From the command line:
 * $ littler filename
 *
 * In a file:
 * --------------------
 * #!/path/to/littler
 * cat("hello world\n");
 * --------------------
 *
 *  $Id$
 */

/*
 * TODOs:
 *           iii) Should we create a throwaway gmail address littler_authors@gmail.com ?
 *                Do you know if we set up a double forward to you and me from gmail ? [DE]
 *
 * DONEs:
 *           i)   indent cleanup -- my Emacs default is the standard, so it'll be 
 *                two chars from here unless I manually fix it [DE]
 *                ---> should be done now [DE]
 *           ii)  toolchain -- you used autoconf 2.59 so is our reference platform
 *                Debian testing (my preference, autoconf 2.60 among other things)
 *                or is it Debian stable ?   I have a stable box left with some tools. [DE]
 *                ---> we chatted about that in email, status not entirely clear [DE]
 *           iv)  Need to do the actual change to have the binary called 'r'. [DE]
 *                ---> Done
 *
 */

#include "config.h"
#include "littler.h"
#include "autoloads.h"
#include "getopt.h"

#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>

#include <R.h>
#include <Rdefines.h>
#define R_INTERFACE_PTRS
#include <Rinterface.h>
#include <R_ext/Parse.h>

/* these two are being filled by autoconf and friends via config.h */
const char* versionNumber = VERSION;
const char* programName = PACKAGE;

/* 
 * Exported by libR
 * Shouldn't this prototype exist in a header?
 * It will in R-2.4.x.
 */
extern int Rf_initEmbeddedR(int argc, char *argv[]);

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

int call_fun1str( char *funstr, char *argstr){
	SEXP val, expr, fun, arg;
	int errorOccurred;

	/* Call funstr */
	fun = Rf_findFun(Rf_install(funstr), R_GlobalEnv);
	PROTECT(fun);

	/* argument */
	PROTECT(arg = NEW_CHARACTER(1));
	SET_STRING_ELT(arg, 0, COPY_TO_USER_STRING(argstr));

	/* expression */
	PROTECT(expr = allocVector(LANGSXP,2));
	SETCAR(expr,fun);
	SETCAR(CDR(expr),arg);

	errorOccurred=1;
	val = R_tryEval(expr,NULL,&errorOccurred);
	UNPROTECT(3);

	return (errorOccurred)? 0:1;
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

void parse_eval(membuf_t *pmb, char *line, int lineno){
	membuf_t mb = *pmb;
	ParseStatus status;
	SEXP cmdSexp, cmdexpr, ans = R_NilValue;
	int i;

	mb = *pmb = add_to_membuf(pmb,line);

	PROTECT(cmdSexp = allocVector(STRSXP, 1));
	SET_STRING_ELT(cmdSexp, 0, mkChar((char*)mb->buf));
	cmdexpr = PROTECT(R_ParseVector(cmdSexp, -1, &status));
	switch (status){
		case PARSE_OK:
			/* Loop is needed here as EXPSEXP will be of length > 1 */
			for(i = 0; i < length(cmdexpr); i++){
				ans = eval(VECTOR_ELT(cmdexpr, i), R_GlobalEnv);
			}
			mb = *pmb = rewind_membuf(pmb);
		break;
		case PARSE_INCOMPLETE:
			/* need to read another line */
		break;
		case PARSE_NULL:
			fprintf(stderr, "%s: ParseStatus is null (%d)\n", programName, status);
			exit(1);
		break;
		case PARSE_ERROR:
			fprintf(stderr,"Line %d: \"%s\"", lineno, line);
			exit(1);
		break;
		case PARSE_EOF:
			fprintf(stderr, "%s: ParseStatus is eof (%d)\n", programName, status);
		break;
		default:
			fprintf(stderr, "%s: ParseStatus is not documented %d\n", programName, status);
			exit(1);
		break;
    }
	UNPROTECT(2);
}

/* Undo R's InitTempdir() and do something sane */

extern char *R_TempDir;

void littler_InitTempDir()
{
	char *tmp;

	if (R_TempDir){
		if (rmdir(R_TempDir) != 0){
			perror("Fatal Error: could not remove R's TempDir!");
			exit(1);
		}
	}

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
	       "Usage: %s [options] file [...]\n"
	       "   or: %s [options]\n"
	       "\n"
	       "Launches GNU R to execute the specified file containing R commands,\n"
	       "or takes commands from stdin using the specified options. This makes\n"
	       "it suitable to create R scripts via the so-called shebang '#!/' line.\n"
	       "\n"
	       "Options:\n"
	       "  -h, --help           Give this help list\n"
	       "      --usage          Give a short usage message\n"
	       "  -V, --version        Show the version number\n"
	       "  --vanilla            Pass the '--vanilla' option to R\n"  
	       "  --slave              Pass the '--slave' option to R\n"  
	       "  --silent             Pass the '--silent' option to R\n"  
	       "\n\n",
	       programName, programName);
	exit(-1);
}

void showVersionAndExit() {
  	printf("\n" 						
	       "%s version %s\n"
	       "Copyright (C) 2006 Jeffrey Horner and Dirk Eddelbuettel\n"
	       "\n"
	       "%s is free software and comes with ABSOLUTELY NO WARRANTY.\n"
	       "You are welcome to redistribute it under the terms of the\n"
	       "GNU General Public License.  For more information about\n"
	       "these matters, see http://www.gnu.org/copyleft/gpl.html.\n\n",
	       programName, versionNumber, programName);
	exit(-1);       
}

void showUsageAndExit() {
  	printf("\n" 						
	       "%s can be used in two main modes.\n\n"
	       "The first is via the so-called 'shebang' support it provides for GNU R.\n"
	       "Suppose %s is installed in /usr/local/bin/%s. Then a first line\n"
	       "in the script can be written as \"#!/usr/local/bin/%s\" and the rest\n"
	       "of the file can contain standard R commands.  By adding executable\n"
	       "permissions on the file, one can now create little R scripts.\n\n" 
	       "The second use is in standard compound command-line expressions common\n" 
	       "under Unix as %s can also take arguments from stdin.\n\n"
	       "More documentation is provided in the %s manual, man page and via\n"
	       "the tests directory in the sources.\n\n",
	       programName, programName, programName, programName,  programName, programName);
	exit(-1);       
}

int main(int argc, char **argv){

	/* R embedded arguments, and optional arguments to be picked via cmdline switches */
        char *R_argv[] = {"LITTLER", "--gui=none", "--no-save", "--no-readline", "", "", ""};
        char *R_argv_opt[] = {"--vanilla", "--silent", "--slave"};
	int R_argc = (sizeof(R_argv) - sizeof(R_argv_opt) ) / sizeof(R_argv[0]);
	int i, nargv;
	SEXP s_argv;
	int c, optpos=0, vanilla=0, slave=0, silent=0;

	static struct option optargs[] = {
		{"help", 0, NULL, 'h'}, 		/* --help also has short option -h */
		{"usage", 0, 0, 0},
		{"version", 0, NULL, 'V'},
		{"vanilla", 0, 0, 0},
		{"silent", 0, 0, 0},
		{"slave", 0, 0, 0},
		{0, 0, 0, 0}
	};
	while ((c = getopt_long(argc, argv, "+hV", optargs, &optpos)) != -1) {
		switch (c) {	
			case 0:					/* numeric 0 is code for a long option */
				/* printf ("Got option %s %d", optargs[optpos].name, optpos);*/
				switch (optpos) {		/* so switch on the position in the optargs struct */
					/* cases 0 and 2 can't happen as these cases are covered by the `--help' and '-h' */ 
					/* and '--version' and '-V' equivalences, so c will have values 'h' or 'V' instead */
					case 1:
						showUsageAndExit();
						break;			/* never reached */
					case 3:	
						vanilla=1;
						break;
					case 4:	
						silent=1;
						break;
					case 5:
						slave=1;
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
			case 'V':
				showVersionAndExit();
				break;  			/* never reached */
			default:
				printf("Unknown option '%c'. Try `%s --help' for help\n",(char)c, programName);
				exit(-1);
		}
	}
 	if (vanilla) R_argv[3+vanilla] = R_argv_opt[0]; 		/* copy pointer address */
 	if (silent)  R_argv[3+vanilla+silent] = R_argv_opt[1]; 		/* copy pointer address */
 	if (slave)   R_argv[3+vanilla+silent+slave] = R_argv_opt[2]; 	/* copy pointer address */
	R_argc += vanilla + slave + silent;
	/*printf("%d %d %d '%s' '%s'\n", R_argc, sizeof(R_argv), sizeof(R_argv[0]), R_argv[3], R_argv[4]);*/
	/*printf("Now optind %d, argc %d\n", optind, argc);*/

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

	/* Assume argv[optind] is the file we want to source.
	 * (optind is an extern in getopt.h)
	 */
	struct stat sbuf;
	if (optind < argc) { 
		if (stat(argv[optind],&sbuf) != 0){
			perror(argv[optind]);
			exit(1);
		}
	}

	/* otherwise we'll read commands from stdin */

	/* Don't let R set up its own signal handlers */
	R_SignalHandlers = 0;

	#ifdef CSTACK_DEFNS
	/* Don't do any stack checking */
	R_CStackLimit = -1;
	#endif
	Rf_initEmbeddedR(R_argc, R_argv);

	littler_InitTempDir();

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
		}
		UNPROTECT(1);

		setVar(install("argv"),s_argv,R_GlobalEnv);
	} else {
		setVar(install("argv"),R_NilValue,R_GlobalEnv);
	}

	/* Now call R function source(filename) */
	if (optind < argc){
		call_fun1str("source",argv[optind]);
	} else {
		/* Or read from stdin */
		membuf_t lb = init_membuf(1024);
		membuf_t pb = init_membuf(1024);
		int lineno = 1;
		while(readline_stdin(&lb)){
			parse_eval(&pb,(char*)lb->buf,lineno++);
		}
		destroy_membuf(lb);
		destroy_membuf(pb);
	}

	exit(0);
}

/* 
 * Local Variables: 
 *   mode: C
 *   indent-tabs-mode: nil
 *   c-indent-level: 8
 *   c-basic-offset: 8
 * End: 
 */
