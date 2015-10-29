#!/usr/bin/env r

# function to be called at exit
.Last <- function() { cat("Really done, so bye-bye from .Last\n") }

# imagine we're doing something now...

# end, and .Last is now called
q(status=42)
