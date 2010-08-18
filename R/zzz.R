.onLoad <- function(libname, pkgname)
{
  path <- file.path(Sys.getenv("HOME"), "lib", "dev")
  cat("Setting 'devlib' to", path, "\n")
  options( devlib=path  )
}
