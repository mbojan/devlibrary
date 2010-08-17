\name{devlib}
\alias{devlib}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
devlib(pkg, ver = NULL, devtree = getOption("devlib"), ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{pkg}{
%%     ~~Describe \code{pkg} here~~
}
  \item{ver}{
%%     ~~Describe \code{ver} here~~
}
  \item{devtree}{
%%     ~~Describe \code{devtree} here~~
}
  \item{\dots}{
%%     ~~Describe \code{\dots} here~~
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function(pkg, ver=NULL, devtree=getOption("devlib"), ...)
{
  # check if availability
  db <- buildLibDB(devtree)
  pkgmatch <- db$package \%in\% pkg
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
    vermatch <- dbsub$version \%in\% ver
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
  if( pkg \%in\% unique(c(.packages(), loadedNamespaces())) )
  {
    cat("Trying to unload/detach package", sQuote(pkg), "\n")
    detach( paste("package", "network", sep=":"), unload=TRUE, character.only=TRUE)
  }
  cat("Loading package", sQuote(pkg), paste("(", loadver, ")", sep=""),
      "from", devtree, "\n")
  library(pkg, character.only=TRUE, lib.loc=loc, ...)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
