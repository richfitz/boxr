#include "termbox.h"
#include "boxr_utils.h"

// This is liable to get split into two; the coersion does not happen
// here but perhaps should (that just requires a little more
// bookkeeping though).  The name is up for grabs too; I've gone with
// r_boxr_ here to indicate the boxr API, but that is not going to
// settle for a while.
SEXP r_boxr_change_cell(SEXP r_x, SEXP r_y, SEXP r_ch, SEXP r_fg, SEXP r_bg) {
  const int nx = LENGTH(r_x), ny = LENGTH(r_y), nch = LENGTH(r_ch),
    nfg = LENGTH(r_fg), nbg = LENGTH(r_fg);
  const int n = nx;
  const int ok =
    nx == ny             &&
    check_length(nch, n) &&
    check_length(nfg, n) &&
    check_length(nbg, n);
  int *x = INTEGER(r_x), *y = INTEGER(r_y), *ch = INTEGER(r_ch),
    *fg = INTEGER(r_fg), *bg = INTEGER(r_bg);
  int i, ich = 0, ifg = 0, ibg = 0;
  if (!ok) {
    error("Inconsistent lengths: %d, %d, %d, %d, %d",
          nx, ny, nch, nfg, nbg);
  }
  for (i = 0; i < n; ++i) {
    tb_change_cell(x[i], y[i], ch[ich], fg[ifg], bg[ifg]);
    if (nch > 1) ++ich;
    if (nfg > 1) ++ifg;
    if (nbg > 1) ++ibg;
  }
  return R_NilValue;
}
