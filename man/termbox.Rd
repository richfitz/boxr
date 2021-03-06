% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/termbox.R
\name{tb_init}
\alias{tb_cell_buffer}
\alias{tb_change_cell}
\alias{tb_clear}
\alias{tb_height}
\alias{tb_init}
\alias{tb_peek_event}
\alias{tb_poll_event}
\alias{tb_present}
\alias{tb_select_input_mode}
\alias{tb_select_output_mode}
\alias{tb_set_clear_attributes}
\alias{tb_set_cursor}
\alias{tb_shutdown}
\alias{tb_width}
\title{Termbox low level interface}
\usage{
tb_init()

tb_shutdown()

tb_width()

tb_height()

tb_clear()

tb_set_clear_attributes(fg, bg)

tb_present()

tb_set_cursor(cx, cy)

tb_change_cell(x, y, ch, fg, bg)

tb_cell_buffer()

tb_select_input_mode(mode)

tb_select_output_mode(mode)

tb_peek_event(timeout)

tb_poll_event()
}
\arguments{
\item{fg,bg}{foregreound and background colours (see \code{\link{tb}}
for a set of values)}

\item{cx,cy}{x and y position of the cursor}

\item{x,y}{x and y position of the cell}

\item{ch}{A single character code}

\item{mode}{input or output mode (see \code{tb$INPUT_*} and
\code{tb$INPUT_*} for possible values.}

\item{timeout}{timeout in milliseconds}
}
\description{
These are a direct mapping of the termbox functions.  Things
should be built on top of these as they're very primitive.
}

