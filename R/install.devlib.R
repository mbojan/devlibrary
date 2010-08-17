install.devlib <-
function(fname, pkg, ver, ...)
{
  # path to library
  loc <- file.path(getOption("devlib"), pkg, ver)
  if(!file.exists(loc)) 
    dir.create(loc, recursive=TRUE)
  cat("Trying to install package", sQuote(fname), "to", loc, "\n")
  install.packages(fname, lib=loc, repos=NULL, ...)
}

