#' @importFrom ggplot2 waiver is_waiver
NULL

#' Construct palette variants
#'
#' Depending on the structure of your data you may wish to combine palettes
#' according to some pattern. These helpers may come in handy.
#' `pal_interleave()` is for grouped data.
#' `pal_stretch()` interpolates a palette into a new discrete palette.
#' `col_contrasting()` chooses colours based on the given background colours.
#'
#' @param ... two or more vectors of colours
#' @param bg vector of colours
#' @param pal palette object
#'
#' @return
#'   - for `col_contrasting()` a vector of colours the same length as `bg`,
#'   - for `pal_*()` a palette object.
#'
#' @export
#' @rdname ggplot_palettes
#'
pal_interleave <- function(...) {
  pals <- vctrs::vec_recycle_common(...)
  pals <- Map(as_colour_vector, pals)
  n_cols <- length(pals[[1]])
  n_pals <- length(pals)
  idx <- rep(seq_len(n_cols), each = n_pals)
  idx <- rep(seq_len(n_cols), each = n_pals) +
    rep(seq_len(n_pals) - 1, times = n_cols) * n_cols
  scales::pal_manual(unlist(pals)[idx], type = "colour")
}

as_colour_vector <- function(x) {
  if (scales::is_discrete_pal(x)) {
    x(scales::palette_nlevels(x))
  } else {
    x
  }
}

#' @export
#' @rdname ggplot_palettes
pal_stretch <- function(pal) {
  cts <- scales::as_continuous_pal(pal)
  scales::as_discrete_pal(cts)
}

#' @export
#' @rdname ggplot_palettes
col_contrasting <- function(bg) {
  Lab <- grDevices::convertColor(
    t(grDevices::col2rgb(bg)),
    from = "sRGB",
    to = "Lab",
    scale.in = 255
  )
  ifelse(Lab[, 1] < 50, "white", "black")
}
