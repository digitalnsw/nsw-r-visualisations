#' NSW Design System Colour Palettes
#'
#' Palettes created using the [NSW Design System](https://designsystem.nsw.gov.au/docs/content/design/theming.html).
#' Either specify a named palette with `palette`, or choose a `hue` or `shade`.
#'
#' [NSW Design System]: (https://designsystem.nsw.gov.au/docs/content/design/theming.html)
#'
#' @export
#'
#' @param palette Name of the palette: `r names(nsw_palettes_manual)`.
#' @param hue Name or index of the hue - see Details.
#'   Ignored if `palette` is specified.
#' @param shade Name or index of the shade - see Details.
#'   Ignored if `palette` is specified.
#' @param variant Name of palette variant.
#'   Ignored if `palette` is specified.
#' @param direction Set to -1 to reverse the order of colours in the palette,
#'   or 1 for the original order.
#' @returns A palette object (see [palette constructors][scales::new_continuous_palette])
#'
#' @details
#' The `"base"` variant supports:
#'   - **hues**: `r nsw_colour_grids$base$hues`
#'   - **shades**: `r nsw_colour_grids$base$shades`
#'
#' The `"aboriginal"` variant supports:
#'   - **hues**: `r nsw_colour_grids$aboriginal$hues`
#'   - **shades**: `r nsw_colour_grids$aboriginal$shades`
#'
#' @examples
#' library(scales)
#'
#' pal_nsw() |> show_col()
#' pal_nsw(hue = "blues") |> show_col()
#' pal_nsw(shade = "light") |> show_col()
#' pal_nsw(shade = "normal", variant = "aboriginal") |> show_col()
#'
#' # you can interpolate colours by converting to a continuous scale
#' pal_nsw(hue = "blues") |> as_continuous_pal() |> show_col()
pal_nsw <- function(
  palette = waiver(),
  hue = NA,
  shade = NA,
  variant = c("base", "aboriginal"),
  direction = 1
) {
  palette <- pal_name(
    palette = palette,
    hue = hue,
    shade = shade,
    variant = variant
  )
  colours <- nsw_palettes[[palette]]

  if (direction < 0) {
    pal <- rev(pal)
  }

  scales::pal_manual(colours, type = "colour")
}

is_waiver <- function(x) {
  inherits(x, "waiver")
}

pal_name <- function(
  palette = waiver(),
  hue = NA,
  shade = NA,
  variant = c("base", "aboriginal")
) {
  if (is_waiver(palette)) {
    variant <- match.arg(variant)
    grid <- nsw_colour_grids[[match.arg(variant)]]

    if (!is.na(hue) && !is.na(shade)) {
      cli::cli_abort("Only one of {.arg hue} and {.arg shade} can be specified")
    }

    if (!is.na(shade)) {
      if (is.numeric(shade)) {
        shade <- grid$shades[[shade]]
      } else {
        shade <- match.arg(shade, grid$shades)
      }
      palette <- shade
      if (variant != "base") palette <- paste0(variant, "_", palette)
    } else if (!is.na(hue)) {
      if (is.na(hue)) {
        hue <- 1L
      }
      if (is.numeric(hue)) {
        hue <- grid$hues[[hue]]
      } else {
        hue <- match.arg(hue, grid$hues)
      }
      palette <- hue
      if (variant != "base") palette <- paste0(variant, "_", palette)
    } else {
      palette <- "default"
    }
  }
  if (!palette %in% names(nsw_palettes)) {
    cli::cli_abort("Unknown palette: {.val {palette}}")
  }
  palette
}

nsw_palettes_manual <- list(
  default = c(
    nsw_colours$blue_01,
    nsw_colours$teal_02,
    nsw_colours$fuchsia_01,
    nsw_colours$red_02,
    nsw_colours$orange_02,
    nsw_colours$yellow_02,
    nsw_colours$red_03
  ),
  brand_default = c(
    nsw_colours$blue_01,
    nsw_colours$blue_04,
    nsw_colours$blue_02,
    nsw_colours$red_02
  ),
  neg_to_pos = c(
    nsw_colours$purple_01,
    nsw_colours$teal_04,
    nsw_colours$yellow_02
  ),
  colour_blind = c(
    nsw_colours$blue_01,
    nsw_colours$blue_02,
    nsw_colours$teal_03,
    nsw_colours$orange_01,
    nsw_colours$brown_02,
    nsw_colours$orange_03
  )
)

nsw_palettes <- {
  base_hues <- Map(
    \(i) unname(calc_pal_shade(nsw_colour_grids$base, i)),
    seq_along(nsw_colour_grids$base$hues)
  ) |>
    setNames(nsw_colour_grids$base$hues)

  base_shades <- Map(
    \(i) unname(calc_pal_hue(nsw_colour_grids$base, i)),
    seq_along(nsw_colour_grids$base$shades)
  ) |>
    setNames(nsw_colour_grids$base$shades)

  aboriginal_hues <- Map(
    \(i) unname(calc_pal_shade(nsw_colour_grids$aboriginal, i)),
    seq_along(nsw_colour_grids$aboriginal$hues)
  ) |>
    setNames(paste0("aboriginal_", nsw_colour_grids$aboriginal$hues))

  aboriginal_shades <- Map(
    \(i) unname(calc_pal_hue(nsw_colour_grids$aboriginal, i)),
    seq_along(nsw_colour_grids$aboriginal$shades)
  ) |>
    setNames(paste0("aboriginal_", nsw_colour_grids$aboriginal$shades))

  c(
    nsw_palettes_manual,
    base_hues,
    base_shades,
    aboriginal_hues,
    aboriginal_shades
  )
}
