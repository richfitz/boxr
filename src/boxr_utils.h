#include "termbox.h"
#include <R.h>
#include <Rinternals.h>

uint16_t r_to_uint16(SEXP x);
int r_to_int(SEXP r_x);

struct tb_event r_to_tb_event(SEXP x);
SEXP tb_event_to_r(int code, struct tb_event x);
