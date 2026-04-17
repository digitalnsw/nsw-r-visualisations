#' NSW Design System Colour Palettes
#'
#' Palettes created using the [NSW Design System](https://designsystem.nsw.gov.au/docs/content/design/theming.html).
#' There are several named palettes which can be specified with `palette`.
#' To use palettes based on the NSW Design System colour grid, either
#' specify `hue` and allow the shade to vary, or specify `shade` to allow the
#' hue to vary.
#' To use the Aboriginal colour grid, specify `variant = "aboriginal"`.
#' \if{html}{\figure{nsw_palette.svg}{options: width=95%}}
#' `r svglite::svglite("man/figures/nsw_palette.svg"); display_pal_nsw(); invisible(dev.off())`
#'
#' @export
#'
#' @param palette Name of the palette: `r rev(names(nsw_named_palettes))`.
#' @param hue Name or index of the hue - see Details.
#'   Ignored if `palette` is specified.
#' @param shade Name or index of the shade - see Details.
#'   Ignored if `palette` is specified.
#' @param variant Name of palette variant.
#'   Ignored unless `hue` or `shade` is specified.
#' @param direction Set to -1 to reverse the order of colours in the palette,
#'   or 1 for the original order.
#' @returns A palette object (see [palette constructors][scales::new_continuous_palette])
#'
#' @details
#' The `"base"` variant supports:
#'   - **hue**: `r colnames(nsw_colour_grids$base)`
#'   - **shade**: `r rownames(nsw_colour_grids$base)`
#'
#' The `"aboriginal"` variant supports:
#'   - **hue**: `r colnames(nsw_colour_grids$aboriginal)`
#'   - **shade**: `r rownames(nsw_colour_grids$aboriginal)`
#'
#' Anchor colours used to create the NSW colour palettes can also be used
#' stand-alone (e.g. `nsw_colours$blue_01` returns the hex code `"#002664"`).
#'
#' @examples
#' library(scales)
#'
#' pal_nsw() |> show_col()
#' pal_nsw(hue = "blues") |> show_col()
#' pal_nsw(hue = "reds", direction = -1) |> show_col()
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
  if (!missing(variant) && all(is.na(hue), is.na(shade))) {
    cli::cli_warn(
      "{.arg variant} is ignored unless used with {.arg hue} or {.arg shade}"
    )
  }
  rlang::check_exclusive(hue, shade, .require = FALSE)
  if (!is_waiver(palette) && any(!missing(variant), !is.na(hue), !is.na(shade))) {
    cli::cli_warn(
      "{.arg variant}, {.arg hue} and {.arg shade} are ignored when {.arg palette} is specified"
    )
  }

  if (!is.na(hue)) {
    colours <- col_nsw(hue = hue, variant = variant)
  } else if (!is.na(shade)) {
    colours <- col_nsw(shade = shade, variant = variant)
  } else if (!is_waiver(palette)) {
    colours <- get(palette, envir = nsw_named_palettes)
  } else {
    colours <- get("default", envir = nsw_named_palettes)
  }

  if (direction < 0) {
    colours <- rev(colours)
  }

  scales::pal_manual(unlist(colours), type = "colour")
}

nsw_named_palettes <- rlang::new_environment(list(
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
  core = c(
    nsw_colours$blue_01,
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
))

display_pal_nsw <- function() {
  pals <- c(
    rev(names(nsw_named_palettes)),
    " ",
    " v=base",
    paste0("h=", colnames(nsw_colour_grids$base)),
    paste0("s=", rownames(nsw_colour_grids$base)),
    " ",
    " v=aboriginal",
    paste0("h=", colnames(nsw_colour_grids$aboriginal)),
    paste0("s=", rownames(nsw_colour_grids$aboriginal))
  )
  cols <- unname(c(
    rev(as.list(nsw_named_palettes)),
    NA,
    NA,
    Map(
      \(x) unlist(col_nsw(hue = x, variant = "base"), use.names = FALSE),
      colnames(nsw_colour_grids$base)
    ),
    Map(
      \(x) unlist(col_nsw(shade = x, variant = "base"), use.names = FALSE),
      rownames(nsw_colour_grids$base)
    ),
    NA,
    NA,
    Map(
      \(x) unlist(col_nsw(hue = x, variant = "aboriginal"), use.names = FALSE),
      colnames(nsw_colour_grids$aboriginal)
    ),
    Map(
      \(x) {
        unlist(col_nsw(shade = x, variant = "aboriginal"), use.names = FALSE)
      },
      rownames(nsw_colour_grids$aboriginal)
    )
  ))

  n <- lengths(cols)
  nr <- length(pals)
  nc <- max(n)

  ylim <- c(0, nr)
  oldpar <- graphics::par(mgp = c(0, 0, 0), mar = c(0, 4, 0, 0))
  on.exit(graphics::par(oldpar))
  plot(
    1,
    1,
    xlim = c(0, nc),
    ylim = ylim,
    type = "n",
    axes = FALSE,
    bty = "n",
    xlab = "",
    ylab = ""
  )
  for (i in 1:nr) {
    nj <- n[[i]]
    if (startsWith(pals[[i]], " ")) {
      next
    }
    shadi <- cols[[i]]
    graphics::rect(
      xleft = 0:(nj - 1),
      ytop = nr - i,
      xright = 1:nj,
      ybottom = nr - i + 0.8,
      col = shadi,
      border = "light grey"
    )
  }
  graphics::text(
    rep(-0.1, nr),
    rev(1:nr) - 0.6,
    labels = pals,
    xpd = TRUE,
    adj = 1,
    cex = 0.7
  )
}
