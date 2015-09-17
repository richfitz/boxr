tb_x_dim <- function() {
  c(tb_width(), tb_height())
}

with_termbox <- function(expr) {
  tb_init()
  on.exit(tb_shutdown())
  try(expr)
}
