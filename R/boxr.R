##' Evaluate an expression while keeping termbox open, being sure to
##' close it down even on error.
##'
##' @title Evaluate an expression in a temporary termbox
##' @param expr An expression to evaluate.  Don't call
##'   \code{\link{tb_init}} or \code{\link{tb_shutdown}} yourself as
##'   they'll be called within the \code{with_termbox} block.  Don't
##'   forget to run \code{\link{tb_present}} or likely nothing will be
##'   shown.
##' @param try Evaluate \code{expr} within a \code{\link{try}} block?
##'   This can help with debugging and error detection, which is
##'   generally tricky because stderrr is generally lost during this
##'   process.
##' @export
with_termbox <- function(expr, try=TRUE) {
  tb_init()
  on.exit(tb_shutdown())
  if (try) {
    try(expr)
  } else {
    expr
  }
}

##' Vectorised version of \code{\link{tb_change_cell}}; any elements
##' in \code{x}, \code{y} \code{ch} \code{fg} and \code{bg} may be
##' vectors with length greater than 1, but only one length greater
##' than 1 is allowed, and \code{x} and/or \code{y} must have length
##' greater than 1 if anything else does.
##' @title Set many cells
##' @param x,y x and y position of the cells so c(x[i], y[i]) is the ith cell
##' @param ch A single or vector of character codes (integer)
##' @param fg,bg foregreound and background colours (see \code{\link{tb}}
##'   for a set of values)
##' @export
boxr_change_cell <- function(x, y, ch, fg, bg) {
  .Call(C_boxr_change_cell, as.integer(x), as.integer(y),
        as.integer(ch), as.integer(fg), as.integer(bg))
}

##' Wrapper around \code{boxr_change_cell} to set a rectangle to a
##' single colour and character (it is possible to pass vectors here
##' in but not recommended as the interface may change).
##' @title Set a rectangle of cells
##' @param x a pair of points being the x edge of the rectangle
##' @param y a pair of points being the y edge of the rectangle
##' @param ch A single integer character code
##' @param fg,bg Single foreground and background colours (see \code{\link{tb}}
##'   for a set of values)
##' @export
boxr_change_rect <- function(x, y, ch, fg, bg) {
  if (length(x) != 2L) {
    stop("Expected x to be length 2")
  }
  if (length(y) != 2L) {
    stop("Expected y to be length 2")
  }
  xx <- seq.int(x[[1]], x[[2]])
  yy <- seq.int(y[[1]], y[[2]])
  boxr_change_cell(rep(xx, each=length(yy)), rep(yy, length(xx)), ch, fg, bg)
}

##' Bitwise OR - a simple wrapper around \code{\link{bitwOr}} that is
##' a little nicer to look at.
##' @param a,b scalar integers
##' @export
##' @rdname bitwise_or
##' @examples
##' tb$BLUE
##' tb$BLUE %OR% tb$BOLD
##' bitwOr(tb$BLUE, tb$BOLD)
`%OR%` <- function(a, b) {
  bitwOr(a, b)
}
