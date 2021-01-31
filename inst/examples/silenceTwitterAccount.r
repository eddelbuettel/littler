#!/usr/bin/r

if (is.null(argv) | length(argv) < 1) {
    cat("Usage: silenceTwitterAccount.r user1 [user2 user3 ...]\n\n")
    cat("Calls rtweet::post_silence() for the given users.\n")
    cat("NB: Needs a modified version of rtweet and a twitter token.\n\n")
    q()
}

if (!requireNamespace("rtweet", quietly=TRUE))
    stop("Please install `rtweet`.", call. = FALSE)

if (Sys.getenv("TWITTER_PAT") == "")
    stop("Please setup a 'TWITTER_PAT' using `rtweet`.", call. = FALSE)

library(rtweet)
if (is.na(match("post_silence", ls("package:rtweet"))))
    stop("This needs a version of 'rtweet' with the post_silence() function", call. = FALSE)

for (arg in argv) rtweet::post_silence(arg)
