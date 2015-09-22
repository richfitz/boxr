# boxr

> Interface to 'termbox'

[![Linux Build Status](https://travis-ci.org/richfitz/boxr.svg?branch=master)](https://travis-ci.org/richfitz/boxr)

Interface to '[termbox](https://github.com/nsf/termbox)'.  The idea is low level support for terminal based reactive apps.

## Low level interface

`boxr` supports the full termbox interface, which is not very large.

* `tb_init`
* `tb_shutdown`
* `tb_width`
* `tb_height`
* `tb_clear`
* `tb_set_clear_attributes`
* `tb_present`
* `tb_set_cursor`
* `tb_change_cell`
* `tb_cell_buffer` (read-only)
* `tb_select_input_mode`
* `tb_select_output_mode`
* `tb_peek_event`
* `tb_poll_event`

The [termbox](https://github.com/nsf/termbox) documentation is the best place for details on these functions; the R interface here merely exposes them and does a teensy bit of type coersion.

The many, _many_ constants defined by termbox are available in the `tb` object (e.g. `tb$BLUE` is the colour code for blue).  See `ls(boxr::tb)` for the full set.

In addition, `boxr` has two vectorised version of `tb_change_cell`:

* `boxr_change_cell` - vectorised in all arguments
* `boxr_change_rect` - takes x, y rectangle corners as x/y arguments


## Installation

```r
devtools::install_github("richfitz/boxr")
```

## License

MIT + file LICENSE © [Rich FitzJohn](https://github.com/richfitz).
