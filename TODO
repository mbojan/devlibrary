# Maintaining developer's library of R packages
#
# Every package is stored in his own library tree


# top level of the dev library

dlib1 <- "/home/mbojan/lib/R/dev"
dlib2 <- "/home/mbojan/R/src/devlib/lib"
options(devlib =dlib1 )

path <- dlib1

#============================================================================ 
# build db of packages in dev library

buildLibDB <- function(path=getOption("devlib"))
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


#============================================================================ 
# install packages to dev tree

install.devlib <- function(fname, pkg, ver, ...)
{
  # path to library
  loc <- file.path(getOption("devlib"), pkg, ver)
  if(!file.exists(loc)) 
    dir.create(loc, recursive=TRUE)
  cat("Trying to install package", sQuote(fname), "to", loc, "\n")
  install.packages(fname, lib=loc, repos=NULL, ...)
}


#============================================================================ 
# loading packages from dev library

# TODO iv ver=NULL, load the latest

# if package not found list those available

devlib <- function(pkg, ver=NULL, devtree=getOption("devlib"), ...)
{
  # check if availability
  db <- buildLibDB(devtree)
  pkgmatch <- db$package %in% pkg
  if(!any(pkgmatch))
    stop("package", pkg, "not available in", devtree)
  dbsub <- db[pkgmatch,]
  if(is.null(ver))
  {
    # load latest
    loadver <- dbsub$version[ which(dbsub$ver == max(dbsub$ver)) ]
  } else
  {
    # test if version available
    vermatch <- dbsub$version %in% ver
    if(!any(vermatch))
    {
      stop("package", paste(pkg, ver, sep="_"), "not available\n",
          "available versions of", pkg, ":", paste(dsub$version, collapse=", "))
    }
    loadver <- ver
  }
  loc <- file.path(devtree, pkg, loadver)
  if( !file.exists(loc) )
    stop("library ", loc, " does not exist")
  if( pkg %in% unique(c(.packages(), loadedNamespaces())) )
  {
    cat("Trying to unload/detach package", sQuote(pkg), "\n")
    detach( paste("package", "network", sep=":"), unload=TRUE, character.only=TRUE)
  }
  cat("Loading package", sQuote(pkg), paste("(", loadver, ")", sep=""),
      "from", devtree, "\n")
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

z <- buildLibDB(dlib1)
ind <- unlist(with(z, tapply(ver, package, order, decreasing=TRUE)))
zz <- z[ ind == 1 , ]
newpaths <- unique(path.expand(c(.libPaths()[1], zz$libloc, .Library.site, .Library)))
newpaths # ?

.libPaths(newpaths)
