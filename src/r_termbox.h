#include <R.h>
#include <Rinternals.h>

// The direct termbox interface with no sugar:
SEXP r_tb_init();
SEXP r_tb_shutdown();
SEXP r_tb_width();
SEXP r_tb_height();
SEXP r_tb_clear();
SEXP r_tb_set_clear_attributes(SEXP fg, SEXP bg);
SEXP r_tb_present();
SEXP r_tb_set_cursor(SEXP cx, SEXP cy);
SEXP r_tb_change_cell(SEXP x, SEXP y, SEXP ch, SEXP fg, SEXP bg);
SEXP r_tb_cell_buffer();
SEXP r_tb_select_input_mode(SEXP mode);
SEXP r_tb_select_output_mode(SEXP mode);
SEXP r_tb_peek_event(SEXP timeout);
SEXP r_tb_poll_event();
