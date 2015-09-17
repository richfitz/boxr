#!/usr/bin/env Rscript
git <- callr::Sys_which("git")
orig <- "src_orig"
if (file.exists("src_orig")) {
  message("pulling...")
  callr::call_system(git, c("-C", orig, "pull"))
} else {
  message("cloning...")
  callr::call_system(git, c("clone", "https://github.com/nsf/termbox", orig))
}

message("patching...")

orig_files <- dir(file.path(orig, "src"),
                  pattern="\\.(inl|h|c)$", full.names=TRUE)
dest_files <- file.path("src", sub("\\.inl$", ".h", basename(orig_files)))
ok <- file.copy(orig_files, dest_files, overwrite=TRUE)
if (!all(ok)) {
  stop("Copy failed")
}

replace_inl <- function(filename) {
  txt <- readLines(filename)
  re <- '^(\\s*#\\s*include\\s+".+\\.)(inl)("\\s*)$'
  i <- grepl(re, txt)
  if (any(i)) {
    txt[i] <- sub(re, "\\1h\\3", txt[i])
    writeLines(txt, filename)
  }
  invisible()
}

replace_abort <- function(filename) {
  err <- c('\t\tfputs("tb_shutdown() should not be called twice.", stderr);',
           '\t\tabort();')
  repl <- c('#include <R.h>',
            '\t\terror("tb_shutdown() should not be called twice.");')
  txt <- readLines(filename)
  i1 <- grep(err[[1]], txt, fixed=TRUE)
  i2 <- grep(err[[2]], txt, fixed=TRUE)
  ok <- length(i1) == 1 && length(i2) == 1 && i2 == i1 + 1
  if (ok) {
    txt <- c(repl[[1]], txt[1:(i1-1)], repl[[2]], txt[(i2+1):length(txt)])
    writeLines(txt, filename)
  } else {
    stop("sources have changed; repatch")
  }
  invisible()
}

replace_inl("src/termbox.c")
replace_abort("src/termbox.c")

sha <- callr::call_system(git, c("-C", orig, "rev-parse", "HEAD"))
dir.create("inst", FALSE)
writeLines(sha, "inst/termbox_sha")

## unlink(orig, TRUE)
message("done")
