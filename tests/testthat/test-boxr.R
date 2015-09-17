test_that("off", {
  ## expect_that(tb_shutdown(), throws_error()) # crash
  expect_that(tb_width(),  equals(-1))
  expect_that(tb_height(), equals(-1))

  ## This won't always work:
  w <- with_termbox(tb_width())
  expect_that(w, is_a("integer"))
  expect_that(w, is_more_than(0))

  ## expect_that(with_termbox(tb_width()), equals(getOption("width")))
  h <- with_termbox(tb_height())
  expect_that(h, is_a("integer"))
  expect_that(h, is_more_than(0))

  sl <- if (interactive()) 1.5 else 0.0

  ## Holy crap it works.
  res <- with_termbox({
    tb_set_clear_attributes(tb$RED, tb$BLUE)
    tb_clear()
    tb_present()
    message("hello")
    Sys.sleep(sl)
  })
})
