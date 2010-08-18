\name{devlib-package}
\alias{devlib-package}
\docType{package}
\title{Maintaining developers' library tree}
\description{
While developing new or patching existing packages it is convenient to be able
to load different versions of the same package.  Standard R package library
cannot store different versions of the same package. Package 'devlib' enables
that by managing a "developers library" in which every package is essentially
stored in its own library sub-tree. Wrapper functions hide all the mechanics
from the end-user.
}
\author{
Michal Bojanowski \email{michal2992@gmail.com}
}
\keyword{ package }
