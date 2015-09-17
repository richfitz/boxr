#include "boxr_utils.h"

uint16_t r_to_uint16(SEXP r_x) {
  int i_x;
  if (LENGTH(r_x) != 1) {
    error("Expected a single value");
  }
  i_x = INTEGER(coerceVector(r_x, INTSXP))[0];
  if (i_x < 0 || i_x > ((uint16_t) - 1)) {
    error("Value out of bounds");
  }
  return (uint16_t)i_x;
}

int r_to_int(SEXP r_x) {
  if (LENGTH(r_x) != 1) {
    error("Expected a single value");
  }
  return INTEGER(coerceVector(r_x, INTSXP))[0];
}

SEXP tb_event_to_r(int code, struct tb_event event) {
  SEXP ret;
  int *data;
  ret = PROTECT(allocVector(INTSXP, 8));
  if (code > 0) {
    data = INTEGER(ret);
    data[0] = event.type;
    data[1] = event.ch;
    data[2] = event.key;
    data[3] = event.mod;
    data[4] = event.w;
    data[5] = event.h;
    data[6] = event.x;
    data[7] = event.y;
  }
  UNPROTECT(1);
  return ret;
}
