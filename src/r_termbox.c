#include "r_termbox.h"
#include "termbox.h"
#include "boxr_utils.h"

SEXP r_tb_init() {
  return ScalarInteger(tb_init());
}

SEXP r_tb_shutdown() {
  tb_shutdown();
  return R_NilValue;
}

SEXP r_tb_width() {
  return ScalarInteger(tb_width());
}

SEXP r_tb_height() {
  return ScalarInteger(tb_height());
}

SEXP r_tb_clear() {
  tb_clear();
  return R_NilValue;
}

SEXP r_tb_set_clear_attributes(SEXP fg, SEXP bg) {
  tb_set_clear_attributes(r_to_uint16(fg), r_to_uint16(bg));
  return R_NilValue;
}

SEXP r_tb_present() {
  tb_present();
  return R_NilValue;
}

SEXP r_tb_set_cursor(SEXP cx, SEXP cy) {
  tb_set_cursor(r_to_int(cx), r_to_int(cy));
  return R_NilValue;
}

// NOTE: no tb_put_cell as that needs to work with structs.

// NOTE: (ch: character)
SEXP r_tb_change_cell(SEXP x, SEXP y, SEXP ch, SEXP fg, SEXP bg) {
  tb_change_cell(r_to_int(x), r_to_int(y),
                 r_to_uint16(ch), r_to_uint16(fg), r_to_uint16(bg));
  return R_NilValue;
}

// NOTE: no tb_blit because non-trivial, deprecated
SEXP r_tb_cell_buffer() {
  struct tb_cell *data = tb_cell_buffer();
  int w = tb_width(), h = tb_height();
  int n = w * h;
  SEXP ret = PROTECT(allocVector(n * 3, INTSXP));
  SEXP dim = PROTECT(allocVector(3, INTSXP));
  int *out = INTEGER(ret);
  int i, j = 0;
  for (i = 0, j = 0; i < n; i++) {
    out[j++] = data[i].ch;
    out[j++] = data[i].fg;
    out[j++] = data[i].bg;
  }
  INTEGER(dim)[0] = n;
  INTEGER(dim)[1] = w;
  INTEGER(dim)[2] = h;
  dimgets(ret, dim);
  UNPROTECT(2);
  return ret;
}

// NOTE: Do the name coerseion on the R side.
SEXP r_tb_select_input_mode(SEXP mode) {
  return ScalarInteger(tb_select_input_mode(r_to_int(mode)));
}
SEXP r_tb_select_output_mode(SEXP mode) {
  return ScalarInteger(tb_select_output_mode(r_to_int(mode)));
}

SEXP r_tb_peek_event(SEXP timeout) {
  struct tb_event event;
  int code = tb_peek_event(&event, r_to_int(timeout));
  return tb_event_to_r(code, event);
}
SEXP r_tb_poll_event() {
  struct tb_event event;
  int code = tb_poll_event(&event);
  return tb_event_to_r(code, event);
}
