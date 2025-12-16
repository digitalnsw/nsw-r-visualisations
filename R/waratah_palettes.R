#' Waratah palettes
#'
#' Palettes created using the waratah anchor colours.
#' Note that the palettes used in plots interpolate between the anchor colours,
#' allowing each palette to be used with any number of colours (within reason!)
#'
#' @export
#'
#' @param palette Name of the palette: `r names(waratah_palettes)`
#' @param direction Set to -1 to reverse the order of colours in the palette,
#'   or 1 for the original order.
#' @examples
#' library(scales)
#'
#' show_col(pal_waratah()(8))
#' show_col(pal_waratah("colour_blind")(6))
pal_waratah <- function(palette = "default", direction = 1) {
  pal <- get_full_palette(palette, direction)
  pal_len <- length(pal)

  function(n) {
    if (n > pal_len) {
      cli::cli_warn("At most {pal_len} colours are supported by the {.val {palette}} palette")
    }
    pal[seq_len(min(n, pal_len))]
  }
}

get_full_palette <- function(palette, direction) {
  if (!palette %in% names(waratah_palettes)) {
      cli::cli_warn("Unknown palette: {.val {palette}}")
  }
  pal <- waratah_palettes[[palette]]
  if (direction < 0) pal <- rev(pal)
  pal
}

waratah_palettes <- list(
  default = c(
    waratah_colours$blue_01,
    waratah_colours$teal_02,
    waratah_colours$fuchsia_01,
    waratah_colours$red_02,
    waratah_colours$orange_02,
    waratah_colours$yellow_02,
    waratah_colours$red_03
  ),
  brand_default = c(
    waratah_colours$blue_01,
    waratah_colours$blue_04,
    waratah_colours$blue_02,
    waratah_colours$red_02
  ),
  neg_to_pos = c(
    waratah_colours$purple_01,
    waratah_colours$teal_04,
    waratah_colours$yellow_02
  ),
  greens = c(
    waratah_colours$green_01,
    waratah_colours$green_02,
    waratah_colours$green_03,
    waratah_colours$green_04
  ),
  teals = c(
    waratah_colours$teal_01,
    waratah_colours$teal_02,
    waratah_colours$teal_03,
    waratah_colours$teal_04
  ),
  blues = c(
    waratah_colours$blue_01,
    waratah_colours$blue_02,
    waratah_colours$blue_03,
    waratah_colours$blue_04
  ),
  purples = c(
    waratah_colours$purple_01,
    waratah_colours$purple_02,
    waratah_colours$purple_03,
    waratah_colours$purple_04
  ),
  fuchsias = c(
    waratah_colours$fuchsia_01,
    waratah_colours$fuchsia_02,
    waratah_colours$fuchsia_03,
    waratah_colours$fuchsia_04
  ),
  reds = c(
    waratah_colours$red_01,
    waratah_colours$red_02,
    waratah_colours$red_03,
    waratah_colours$red_04
  ),
  oranges = c(
    waratah_colours$orange_01,
    waratah_colours$orange_02,
    waratah_colours$orange_03,
    waratah_colours$orange_04
  ),
  yellows = c(
    waratah_colours$yellow_01,
    waratah_colours$yellow_02,
    waratah_colours$yellow_03,
    waratah_colours$yellow_04
  ),
  greys = c(
    waratah_colours$grey_01,
    waratah_colours$grey_02,
    waratah_colours$grey_03,
    waratah_colours$grey_04
  ),
  browns = c(
    waratah_colours$brown_01,
    waratah_colours$brown_02,
    waratah_colours$brown_03,
    waratah_colours$brown_04
  ),
  deeps = c(
    waratah_colours$grey_01,
    waratah_colours$grey_02,
    waratah_colours$green_01,
    waratah_colours$green_02,
    waratah_colours$teal_01,
    waratah_colours$teal_02,
    waratah_colours$blue_01,
    waratah_colours$blue_02,
    waratah_colours$purple_01,
    waratah_colours$purple_02,
    waratah_colours$fuchsia_01,
    waratah_colours$fuchsia_02,
    waratah_colours$red_01,
    waratah_colours$red_02,
    waratah_colours$orange_01,
    waratah_colours$orange_02,
    waratah_colours$yellow_01,
    waratah_colours$yellow_02,
    waratah_colours$brown_01,
    waratah_colours$brown_02
  ),
  lights = c(
    waratah_colours$grey_03,
    waratah_colours$grey_04,
    waratah_colours$green_03,
    waratah_colours$green_04,
    waratah_colours$teal_03,
    waratah_colours$teal_04,
    waratah_colours$blue_03,
    waratah_colours$blue_04,
    waratah_colours$purple_03,
    waratah_colours$purple_04,
    waratah_colours$fuchsia_03,
    waratah_colours$fuchsia_04,
    waratah_colours$red_03,
    waratah_colours$red_04,
    waratah_colours$orange_03,
    waratah_colours$orange_04,
    waratah_colours$yellow_03,
    waratah_colours$yellow_04,
    waratah_colours$brown_03,
    waratah_colours$brown_04
  ),
  warm_colours = c(
    waratah_colours$fuchsia_01,
    waratah_colours$fuchsia_02,
    waratah_colours$fuchsia_03,
    waratah_colours$fuchsia_04,
    waratah_colours$red_01,
    waratah_colours$red_02,
    waratah_colours$red_03,
    waratah_colours$red_04,
    waratah_colours$orange_01,
    waratah_colours$orange_02,
    waratah_colours$orange_03,
    waratah_colours$orange_04,
    waratah_colours$yellow_01,
    waratah_colours$yellow_02,
    waratah_colours$yellow_03,
    waratah_colours$yellow_04
  ),
  cool_colours = c(
    waratah_colours$green_01,
    waratah_colours$green_02,
    waratah_colours$green_03,
    waratah_colours$green_04,
    waratah_colours$teal_01,
    waratah_colours$teal_02,
    waratah_colours$teal_03,
    waratah_colours$teal_04,
    waratah_colours$blue_01,
    waratah_colours$blue_02,
    waratah_colours$blue_03,
    waratah_colours$blue_04,
    waratah_colours$purple_01,
    waratah_colours$purple_02,
    waratah_colours$purple_03,
    waratah_colours$purple_04
  ),
  colour_blind = c(
    waratah_colours$blue_01,
    waratah_colours$blue_02,
    waratah_colours$teal_03,
    waratah_colours$orange_01,
    waratah_colours$brown_02,
    waratah_colours$orange_03
  )
)
