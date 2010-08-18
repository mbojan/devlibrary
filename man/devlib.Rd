\name{devlib}
\alias{devlib}
\title{Load a package from developer's library}
\description{
Load and attach a package from developer's library
}
\usage{
devlib(pkg, ver = NULL, devtree = getOption("devlib"), ...)
}
\arguments{
  \item{pkg}{character, name of the package}
  \item{ver}{character or NULL, version of the package}
  \item{devtree}{character, path to the top level of developer's library}
  \item{\dots}{other arguments, passed to \code{\link{library}}}
}
\details{
Argument \code{ver} is assumed to follow the standard from R package
DESCRIPTION files. So the version is supposed to look like \code{x.y-z}, and
not \code{x.y.z}.  If \code{ver} is \code{NULL} then the most recent version is
loaded.
}
\value{
The same as \code{\link{library}}.
}
\seealso{
\code{\link{library}}
}
