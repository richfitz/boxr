% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/boxr.R
\name{with_termbox}
\alias{with_termbox}
\title{Evaluate an expression in a temporary termbox}
\usage{
with_termbox(expr, try = TRUE)
}
\arguments{
\item{expr}{An expression to evaluate.  Don't call
\code{\link{tb_init}} or \code{\link{tb_shutdown}} yourself as
they'll be called within the \code{with_termbox} block.  Don't
forget to run \code{\link{tb_present}} or likely nothing will be
shown.}

\item{try}{Evaluate \code{expr} within a \code{\link{try}} block?
This can help with debugging and error detection, which is
generally tricky because stderrr is generally lost during this
process.}
}
\description{
Evaluate an expression while keeping termbox open, being sure to
close it down even on error.
}

