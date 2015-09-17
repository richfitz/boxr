##' @title termbox constants
##' @export
##' @format a locked environment
##' @useDynLib boxr, .registration = TRUE
tb <- new.env(hash=TRUE, parent=emptyenv())

## keys ----------------------------------
tb$KEY_F1               <- 0xFFFF - 0L
tb$KEY_F2               <- 0xFFFF - 1L
tb$KEY_F3               <- 0xFFFF - 2L
tb$KEY_F4               <- 0xFFFF - 3L
tb$KEY_F5               <- 0xFFFF - 4L
tb$KEY_F6               <- 0xFFFF - 5L
tb$KEY_F7               <- 0xFFFF - 6L
tb$KEY_F8               <- 0xFFFF - 7L
tb$KEY_F9               <- 0xFFFF - 8L
tb$KEY_F10              <- 0xFFFF - 9L
tb$KEY_F11              <- 0xFFFF - 10L
tb$KEY_F12              <- 0xFFFF - 11L
tb$KEY_INSERT           <- 0xFFFF - 12L
tb$KEY_DELETE           <- 0xFFFF - 13L
tb$KEY_HOME             <- 0xFFFF - 14L
tb$KEY_END              <- 0xFFFF - 15L
tb$KEY_PGUP             <- 0xFFFF - 16L
tb$KEY_PGDN             <- 0xFFFF - 17L
tb$KEY_ARROW_UP         <- 0xFFFF - 18L
tb$KEY_ARROW_DOWN       <- 0xFFFF - 19L
tb$KEY_ARROW_LEFT       <- 0xFFFF - 20L
tb$KEY_ARROW_RIGHT      <- 0xFFFF - 21L
tb$KEY_MOUSE_LEFT       <- 0xFFFF - 22L
tb$KEY_MOUSE_RIGHT      <- 0xFFFF - 23L
tb$KEY_MOUSE_MIDDLE     <- 0xFFFF - 24L
tb$KEY_MOUSE_RELEASE    <- 0xFFFF - 25L
tb$KEY_MOUSE_WHEEL_UP   <- 0xFFFF - 26L
tb$KEY_MOUSE_WHEEL_DOWN <- 0xFFFF - 27L

tb$KEY_CTRL_TILDE       <- 0x00
tb$KEY_CTRL_2           <- 0x00
tb$KEY_CTRL_A           <- 0x01
tb$KEY_CTRL_B           <- 0x02
tb$KEY_CTRL_C           <- 0x03
tb$KEY_CTRL_D           <- 0x04
tb$KEY_CTRL_E           <- 0x05
tb$KEY_CTRL_F           <- 0x06
tb$KEY_CTRL_G           <- 0x07
tb$KEY_BACKSPACE        <- 0x08
tb$KEY_CTRL_H           <- 0x08
tb$KEY_TAB              <- 0x09
tb$KEY_CTRL_I           <- 0x09
tb$KEY_CTRL_J           <- 0x0A
tb$KEY_CTRL_K           <- 0x0B
tb$KEY_CTRL_L           <- 0x0C
tb$KEY_ENTER            <- 0x0D
tb$KEY_CTRL_M           <- 0x0D
tb$KEY_CTRL_N           <- 0x0E
tb$KEY_CTRL_O           <- 0x0F
tb$KEY_CTRL_P           <- 0x10
tb$KEY_CTRL_Q           <- 0x11
tb$KEY_CTRL_R           <- 0x12
tb$KEY_CTRL_S           <- 0x13
tb$KEY_CTRL_T           <- 0x14
tb$KEY_CTRL_U           <- 0x15
tb$KEY_CTRL_V           <- 0x16
tb$KEY_CTRL_W           <- 0x17
tb$KEY_CTRL_X           <- 0x18
tb$KEY_CTRL_Y           <- 0x19
tb$KEY_CTRL_Z           <- 0x1A
tb$KEY_ESC              <- 0x1B
tb$KEY_CTRL_LSQ_BRACKET <- 0x1B
tb$KEY_CTRL_3           <- 0x1B
tb$KEY_CTRL_4           <- 0x1C
tb$KEY_CTRL_BACKSLASH   <- 0x1C
tb$KEY_CTRL_5           <- 0x1D
tb$KEY_CTRL_RSQ_BRACKET <- 0x1D
tb$KEY_CTRL_6           <- 0x1E
tb$KEY_CTRL_7           <- 0x1F
tb$KEY_CTRL_SLASH       <- 0x1F
tb$KEY_CTRL_UNDERSCORE  <- 0x1F
tb$KEY_SPACE            <- 0x20
tb$KEY_BACKSPACE2       <- 0x7F
tb$KEY_CTRL_8           <- 0x7F

tb$MOD_ALT              <- 0x01

## attributes ----------------------
tb$DEFAULT   <- 0x00
tb$BLACK     <- 0x01
tb$RED       <- 0x02
tb$GREEN     <- 0x03
tb$YELLOW    <- 0x04
tb$BLUE      <- 0x05
tb$MAGENTA   <- 0x06
tb$CYAN      <- 0x07
tb$WHITE     <- 0x08

tb$BOLD      <- 0x10
tb$UNDERLINE <- 0x20
tb$REVERSE   <- 0x40

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
    TB_EUNSUPPORTED_TERMINAL <- -1
    TB_EFAILED_TO_OPEN_TTY   <- -2
    TB_EPIPE_TRAP_ERROR      <- -3
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
  .Call(C_tb_width)
}

##' @rdname termbox
##' @export
tb_clear <- function() {
  .Call(C_tb_clear)
}

##' @rdname termbox
##' @export
##' @param fg,bg foregreound and background colours (see \code{\link{tb}}
##'   for a sest of values)
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
