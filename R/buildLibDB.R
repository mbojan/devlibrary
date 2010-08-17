buildLibDB <-
function(path=getOption("devlib"))
{
  # absolute path
  path <- path.expand(path)
  # package names
  pkgpaths <- list.files(path, full.names=TRUE)
  isdir <- file.info(pkgpaths)$isdir
  pkgnames <- basename( pkgpaths[isdir] )
  vernames <- lapply( pkgpaths[isdir], list.files)
  ind <- sapply(vernames, length)
  db <- data.frame( 
      package=rep(pkgnames, ind),
      version=unlist(vernames, use.names=FALSE),
      libloc = rep(pkgpaths[isdir], ind),
      stringsAsFactors=FALSE )
  db$ver <- package_version(db$version)
  db
}

