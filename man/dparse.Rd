% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dparser.R
\name{dparse}
\alias{dparse}
\title{Create R-based Dparser tree walking function based on grammar}
\usage{
dparse(grammar, start_state = 0, save_parse_tree = TRUE,
  partial_parses = FALSE, compare_stacks = TRUE,
  commit_actions_interval = 100, fixup = TRUE, fixup_ebnf = FALSE,
  nogreedy = FALSE, noheight = FALSE, use_file_name = TRUE,
  parse_size = 1024, verbose_level = 0, children_first = TRUE, ...)
}
\arguments{
\item{grammar}{Dparser grammar}

\item{start_state}{Start State (default 0)}

\item{save_parse_tree}{Save Parse Tree (default TRUE)}

\item{partial_parses}{Partial Parses (default FALSE)}

\item{compare_stacks}{Compare Stacks (default TRUE)}

\item{commit_actions_interval}{Commit Interval (default 100)}

\item{fixup}{Fix-up Internal Productions (default FALSE)}

\item{fixup_ebnf}{Fixup EBNF Productions (default FALSE)}

\item{nogreedy}{No Greediness for Disambiguation (default FALSE)}

\item{noheight}{No Height for Disambiguation (default FALSE)}

\item{use_file_name}{Use File Name for syntax errors (default
TRUE)}

\item{parse_size}{Parser size (default 1024)}

\item{verbose_level}{the level of verbosity when creating parser
(default 0)}

\item{children_first}{When TRUE, parse the children before the
parent (default TRUE).}

\item{...}{Parameters sent to \code{\link{mkdparse}}, with the
exception of \code{use_r_header} which is forced to be
\code{TRUE}.}
}
\value{
A function that allows parsing of a file based on the
    grammar supplied. This function would be able to
    parse arbitrary grammars the way you may want with your own
    user supplied function.
}
\description{
Note R-based dparser tree walking works on Windows (with R tools)
Mac, or Linux. Linking to arbitrary c grammars works on any
platform.
}
\section{Garbage collection}{


There are two user options that control if the dlls for the
grammars created by dparser will be deleted upon garbage
collection or R exit if they are not associated with any active
objects.  These are:

\describe{

\item{\code{dpaser.rm.unnamed.parser.dll}:}{when \code{TRUE}, this remove parsers
that are created from strings, or other memory-based items in R.}

\item{\code{dpaser.rm.unnamed.parser.dll}:}{when \code{TRUE}, this
removes parsers created from grammar files.}

}
}

\examples{
\donttest{
## This creates the R based parsing function.  It requires
## compilation and runs on most OSes, with the exception of solaris.
## Windows requires Rtools to be installed.
f <- dparse(system.file("tran.g", package = "dparser"),children_first=FALSE);

## Once created, you may then use this function to parse an
## arbitrary syntax file.  For example:
f("
b       = -1
d/dt(X) = a*X + Y*Z;
d/dt(Y) = b*(Y - Z);
d/dt(Z) = -X*Y + c*Y - Z
if (t < 0.02 | t > 99.98){
    print
}
", function(name, value, pos, depth){
    ## This prints the name, value, position and depth passed to the
    ##parsing function.
    cat(sprintf("name:\%s;value:\%s;pos:\%s;depth:\%s\\n", name, value, pos,
                 depth));
})

## You could use a better R parsing function; You could also use
## this as a starting place for your own C-based parser
}
}
\seealso{
\code{\link{mkdparse}}
}
