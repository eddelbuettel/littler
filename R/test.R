test <- function(src = "print(sessionInfo())"){
  r <- file.path(system.file(package="littler"), "bin/r")
  system2(r, c("-e", shQuote(src)), stdout = TRUE, stderr = TRUE)
}
