#include "r_termbox.h"
#include "boxr.h"

#include <R_ext/Rdynload.h>

static const R_CallMethodDef callMethods[] = {
  // Plain interface
  {"C_tb_init",                  (DL_FUNC) &r_tb_init,                  0},
  {"C_tb_shutdown",              (DL_FUNC) &r_tb_shutdown,              0},
  {"C_tb_width",                 (DL_FUNC) &r_tb_width,                 0},
  {"C_tb_height",                (DL_FUNC) &r_tb_height,                0},
  {"C_tb_clear",                 (DL_FUNC) &r_tb_clear,                 0},
  {"C_tb_set_clear_attributes",  (DL_FUNC) &r_tb_set_clear_attributes,  2},
  {"C_tb_present",               (DL_FUNC) &r_tb_present,               0},
  {"C_tb_set_cursor",            (DL_FUNC) &r_tb_set_cursor,            2},
  {"C_tb_change_cell",           (DL_FUNC) &r_tb_change_cell,           5},
  {"C_tb_cell_buffer",           (DL_FUNC) &r_tb_cell_buffer,           0},
  {"C_tb_select_input_mode",     (DL_FUNC) &r_tb_select_input_mode,     1},
  {"C_tb_select_output_mode",    (DL_FUNC) &r_tb_select_output_mode,    1},
  {"C_tb_peek_event",            (DL_FUNC) &r_tb_peek_event,            1},
  {"C_tb_poll_event",            (DL_FUNC) &r_tb_poll_event,            0},
  // Not termbox:
  {"C_boxr_change_cell",         (DL_FUNC) &r_boxr_change_cell,         5},
  {NULL,                         NULL,                                  0}
};

void R_init_boxr(DllInfo *info) {
  R_registerRoutines(info, NULL, callMethods, NULL, NULL);
}
