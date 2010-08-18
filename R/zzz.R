.onLoad <- function(libname, pkgname)
{
  source( system.file(file.path("extdata", "devlibloc.R"), package=pkgname) )
  cat("Setting 'devlib' to", sQuote(devlibloc), "\n")
  options( devlib=devlibloc  )
}
