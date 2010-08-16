# Maintaining developer's library of R packages
#
# Every package is stored in his own library tree


# top level of the dev library

dlib1 <- "/home/mbojan/lib/R/dev"
dlib2 <- "/home/mbojan/R/src/devlib/lib"
options(devlib =dlib2 )

#============================================================================ 
# build db of packages in dev library

buildLibDB <- function(path=getOption("devlib"))
{
  path <- path.expand(path)
  l <- list.files(path)
  ll <- lapply(l, function(n) list.files(file.path(path, n)))
  names(ll) <- l
  db <- data.frame( package=rep(names(ll), sapply(ll, length)), 
      version=unlist(ll, use.names=FALSE),
      stringsAsFactors=FALSE )
  db$libloc <- apply(db, 1, function(v) file.path(path, v[1], v[2]))
  db$ver <- package_version(db$version)
  db
}


#============================================================================ 
# install packages to dev tree

install.devlib <- function(fname, pkg, ver, ...)
{
  loc <- file.path(getOption("devlib"), pkg, ver)
  if( !file.exists(loc) )
  {
    dir.create(loc, recursive=TRUE)
  }
  cat("Trying to install package", sQuote(fname), "to", loc, "\n")
  install.packages(fname, lib=loc, repos=NULL, ...)
}


#============================================================================ 
# loading packages from dev library

devlibrary <- function(pkg, ver, devtree=getOption("devlib"), ...)
{
  loc <- file.path(devtree, pkg, ver)
  if( !file.exists(loc) )
    stop("library ", loc, " does not exist")
  cat("Loading package", pkg, "from", loc, "\n")
  library(pkg, character.only=TRUE, lib.loc=loc, ...)
}

#============================================================================ 
# adding dev library to lib paths

# NOTE On .libPaths this shouldn't be on the fist location

# 1. Create a vector of paths to package library trees. Only for most recent
# versions (from lib db extract those based on package name and version number

# 2. Put those after 1st entry in libPaths (default pkg installation
# directory), but after any other trees so that these packages are loaded first
# (?)

f <- function(new)
{
  if(!missing(new))
  {
    new <- Sys.glob(path.expand(new))
    paths <- unique(path.expand(c(new, .Library.site, .Library)))
    .dupa <<- paths[file.info(paths)$isdir %in% TRUE]
  }
  else .dupa
}

z <- buildLibDB(dlib1)
z[ with(z, order(package, ver)) , ]
