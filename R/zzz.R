.onLoad <- function(libname, pkgname)
{
  source( system.file("extdata", "devlibloc.R", package=pkgname, lib.loc=libname) )
  cat("Setting 'devlib' to", sQuote(devlibloc), "\n")
  options( devlib=devlibloc  )
}
