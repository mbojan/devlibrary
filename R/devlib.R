devlib <- function(pkg=NULL, ver=NULL, devtree=getOption("devlib"), ...)
{
  # check if availability
  db <- buildLibDB(devtree)
  if(is.null(pkg))
  {
      cat("Packages in", devtree, "\n")
      return(db)
  }
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
          "available versions of", pkg, ":", paste(dbsub$version, collapse=", "))
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

