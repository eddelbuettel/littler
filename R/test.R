test <- function(src = "cat(2 + 2)") {
    r <- file.path(system.file(package="littler"), "bin",
                   paste0("r", ifelse(.Platform$OS.type=="windows", ".exe", "")))
    system2(r, c("-e", shQuote(src)), stdout = TRUE, stderr = TRUE)
}
