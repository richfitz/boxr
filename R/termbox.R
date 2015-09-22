##' @title termbox constants
##' @export
##' @format a locked environment
##' @useDynLib boxr, .registration = TRUE
tb <- new.env(hash=TRUE, parent=emptyenv())

## keys ----------------------------------
tb$KEY_F1               <- as.integer(0xFFFF - 0L)
tb$KEY_F2               <- as.integer(0xFFFF - 1L)
tb$KEY_F3               <- as.integer(0xFFFF - 2L)
tb$KEY_F4               <- as.integer(0xFFFF - 3L)
tb$KEY_F5               <- as.integer(0xFFFF - 4L)
tb$KEY_F6               <- as.integer(0xFFFF - 5L)
tb$KEY_F7               <- as.integer(0xFFFF - 6L)
tb$KEY_F8               <- as.integer(0xFFFF - 7L)
tb$KEY_F9               <- as.integer(0xFFFF - 8L)
tb$KEY_F10              <- as.integer(0xFFFF - 9L)
tb$KEY_F11              <- as.integer(0xFFFF - 10L)
tb$KEY_F12              <- as.integer(0xFFFF - 11L)
tb$KEY_INSERT           <- as.integer(0xFFFF - 12L)
tb$KEY_DELETE           <- as.integer(0xFFFF - 13L)
tb$KEY_HOME             <- as.integer(0xFFFF - 14L)
tb$KEY_END              <- as.integer(0xFFFF - 15L)
tb$KEY_PGUP             <- as.integer(0xFFFF - 16L)
tb$KEY_PGDN             <- as.integer(0xFFFF - 17L)
tb$KEY_ARROW_UP         <- as.integer(0xFFFF - 18L)
tb$KEY_ARROW_DOWN       <- as.integer(0xFFFF - 19L)
tb$KEY_ARROW_LEFT       <- as.integer(0xFFFF - 20L)
tb$KEY_ARROW_RIGHT      <- as.integer(0xFFFF - 21L)
tb$KEY_MOUSE_LEFT       <- as.integer(0xFFFF - 22L)
tb$KEY_MOUSE_RIGHT      <- as.integer(0xFFFF - 23L)
tb$KEY_MOUSE_MIDDLE     <- as.integer(0xFFFF - 24L)
tb$KEY_MOUSE_RELEASE    <- as.integer(0xFFFF - 25L)
tb$KEY_MOUSE_WHEEL_UP   <- as.integer(0xFFFF - 26L)
tb$KEY_MOUSE_WHEEL_DOWN <- as.integer(0xFFFF - 27L)

tb$KEY_CTRL_TILDE       <- as.integer(0x00)
tb$KEY_CTRL_2           <- as.integer(0x00)
tb$KEY_CTRL_A           <- as.integer(0x01)
tb$KEY_CTRL_B           <- as.integer(0x02)
tb$KEY_CTRL_C           <- as.integer(0x03)
tb$KEY_CTRL_D           <- as.integer(0x04)
tb$KEY_CTRL_E           <- as.integer(0x05)
tb$KEY_CTRL_F           <- as.integer(0x06)
tb$KEY_CTRL_G           <- as.integer(0x07)
tb$KEY_BACKSPACE        <- as.integer(0x08)
tb$KEY_CTRL_H           <- as.integer(0x08)
tb$KEY_TAB              <- as.integer(0x09)
tb$KEY_CTRL_I           <- as.integer(0x09)
tb$KEY_CTRL_J           <- as.integer(0x0A)
tb$KEY_CTRL_K           <- as.integer(0x0B)
tb$KEY_CTRL_L           <- as.integer(0x0C)
tb$KEY_ENTER            <- as.integer(0x0D)
tb$KEY_CTRL_M           <- as.integer(0x0D)
tb$KEY_CTRL_N           <- as.integer(0x0E)
tb$KEY_CTRL_O           <- as.integer(0x0F)
tb$KEY_CTRL_P           <- as.integer(0x10)
tb$KEY_CTRL_Q           <- as.integer(0x11)
tb$KEY_CTRL_R           <- as.integer(0x12)
tb$KEY_CTRL_S           <- as.integer(0x13)
tb$KEY_CTRL_T           <- as.integer(0x14)
tb$KEY_CTRL_U           <- as.integer(0x15)
tb$KEY_CTRL_V           <- as.integer(0x16)
tb$KEY_CTRL_W           <- as.integer(0x17)
tb$KEY_CTRL_X           <- as.integer(0x18)
tb$KEY_CTRL_Y           <- as.integer(0x19)
tb$KEY_CTRL_Z           <- as.integer(0x1A)
tb$KEY_ESC              <- as.integer(0x1B)
tb$KEY_CTRL_LSQ_BRACKET <- as.integer(0x1B)
tb$KEY_CTRL_3           <- as.integer(0x1B)
tb$KEY_CTRL_4           <- as.integer(0x1C)
tb$KEY_CTRL_BACKSLASH   <- as.integer(0x1C)
tb$KEY_CTRL_5           <- as.integer(0x1D)
tb$KEY_CTRL_RSQ_BRACKET <- as.integer(0x1D)
tb$KEY_CTRL_6           <- as.integer(0x1E)
tb$KEY_CTRL_7           <- as.integer(0x1F)
tb$KEY_CTRL_SLASH       <- as.integer(0x1F)
tb$KEY_CTRL_UNDERSCORE  <- as.integer(0x1F)
tb$KEY_SPACE            <- as.integer(0x20)
tb$KEY_BACKSPACE2       <- as.integer(0x7F)
tb$KEY_CTRL_8           <- as.integer(0x7F)

tb$MOD_ALT              <- as.integer(0x01)

## attributes ----------------------
tb$DEFAULT   <- as.integer(0x00)
tb$BLACK     <- as.integer(0x01)
tb$RED       <- as.integer(0x02)
tb$GREEN     <- as.integer(0x03)
tb$YELLOW    <- as.integer(0x04)
tb$BLUE      <- as.integer(0x05)
tb$MAGENTA   <- as.integer(0x06)
tb$CYAN      <- as.integer(0x07)
tb$WHITE     <- as.integer(0x08)

tb$BOLD      <- as.integer(0x100)
tb$UNDERLINE <- as.integer(0x200)
tb$REVERSE   <- as.integer(0x400)

## misc ----------------------------
tb$HIDE_CURSOR      <- -1L
tb$INPUT_CURRENT    <-  0L
tb$INPUT_ESC        <-  1L
tb$INPUT_ALT        <-  2L
tb$OUTPUT_CURRENT   <-  0L
tb$OUTPUT_NORMAL    <-  1L
tb$OUTPUT_256       <-  2L
tb$OUTPUT_216       <-  3L
tb$OUTPUT_GRAYSCALE <-  4L
tb$EVENT_KEY        <-  1L
tb$EVENT_RESIZE     <-  2L
tb$EVENT_MOUSE      <-  3L

lockEnvironment(tb, bindings=TRUE)

##' These are a direct mapping of the termbox functions.  Things
##' should be built on top of these as they're very primitive.
##' @title Termbox low level interface
##' @rdname termbox
##' @export
tb_init <- function() {
  ok <- .Call(C_tb_init)
  if (ok < 0) {
    ## From termbox.h:
    TB_EUNSUPPORTED_TERMINAL <- -1L
    TB_EFAILED_TO_OPEN_TTY   <- -2L
    TB_EPIPE_TRAP_ERROR      <- -3L
    msg <- switch(ok,
                  TB_EUNSUPPORTED_TERMINAL="unsupported terminal",
                  TB_EFAILED_TO_OPEN_TTY="failed to open tty",
                  TB_EPIPE_TRAP_ERROR="pipe trap error")
    stop("Failed to initialise termbox: ", msg)
  }
  invisible(TRUE)
}

##' @rdname termbox
##' @export
tb_shutdown <- function() {
  .Call(C_tb_shutdown)
}

##' @rdname termbox
##' @export
tb_width <- function() {
  .Call(C_tb_width)
}

##' @rdname termbox
##' @export
tb_height <- function() {
  .Call(C_tb_height)
}

##' @rdname termbox
##' @export
tb_clear <- function() {
  .Call(C_tb_clear)
}

##' @rdname termbox
##' @export
##' @param fg,bg foregreound and background colours (see \code{\link{tb}}
##'   for a set of values)
tb_set_clear_attributes <- function(fg, bg) {
  .Call(C_tb_set_clear_attributes, fg, bg)
}

##' @rdname termbox
##' @export
tb_present <- function() {
  .Call(C_tb_present)
}

##' @rdname termbox
##' @export
##' @param cx,cy x and y position of the cursor
tb_set_cursor <- function(cx, cy) {
  .Call(C_tb_set_cursor, cx, cy)
}

##' @rdname termbox
##' @export
##' @param x,y x and y position of the cell
##' @param ch A single character code
tb_change_cell <- function(x, y, ch, fg, bg) {
  .Call(C_tb_change_cell, x, y, ch, fg, bg)
}

##' @rdname termbox
##' @export
tb_cell_buffer <- function() {
  .Call(C_tb_cell_buffer)
}

##' @rdname termbox
##' @export
##' @param mode input or output mode (see \code{tb$INPUT_*} and
##'   \code{tb$INPUT_*} for possible values.
tb_select_input_mode <- function(mode) {
  .Call(C_tb_select_input_mode, mode)
}

##' @rdname termbox
##' @export
tb_select_output_mode <- function(mode) {
  .Call(C_tb_select_input_mode, mode)
}

##' @rdname termbox
##' @export
##' @param timeout timeout in milliseconds
tb_peek_event <- function(timeout) {
  e <- .Call(C_tb_peek_event, timeout)
  if (is.null(e)) NULL else tb_event(e)
}

##' @rdname termbox
##' @export
tb_poll_event <- function() {
  tb_event(.Call(C_tb_poll_event))
}

## This might move into C if I can be fussed with the effort.  But I
## don't see a situation where I wouldn't want to use the peek/poll
## things and *not* process the event like this.
tb_event <- function(e) {
  if (e[[1]] == 0L) {
    NULL
  } else if (e[[1]] == tb$EVENT_KEY) {
    list(type="KEY", mod=e[[2]], key=e[[3]], ch=e[[4]])
  } else if (e[[2]] == tb$EVENT_RESIZE) {
    list(type="RESIZE", w=e[[5]], h=e[[6]])
  } else if (e[[3]] == tb$EVENT_MOUSE) {
    list(type="MOUSE", w=e[[7]], h=e[[8]])
  } else {
    stop(sprintf("Unknown event: {%s}", paste(e, collapse=", ")))
  }
}
