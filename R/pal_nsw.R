#' NSW Design System Colour Palettes
#'
#' Palettes created using the [NSW Design System](https://designsystem.nsw.gov.au/docs/content/design/theming.html).
#' There are several named palettes which can be specified with `palette`.
#' To use palettes based on the NSW Design System colour grid, either
#' specify `hue` and allow the tone to vary, or specify `tone` to allow the
#' hue to vary.
#' To use the Aboriginal colour grid, specify `variant = "aboriginal"`.
#' \if{html}{\figure{nsw_palette.svg}{options: width=95%}}
#' `r svglite::svglite("man/figures/nsw_palette.svg"); display_pal_nsw(); invisible(dev.off())`
#'
#' @export
#'
#' @param palette Name of a predefined palette: `r rev(names(nsw_named_palettes))`.
#' @param hue Name or index of the hue - see below.
#'   Ignored if `palette` is specified.
#' @param tone Name or index of the tone - see below.
#'   Ignored if `palette` is specified.
#' @param variant Name of palette variant.
#'   Ignored unless `hue` or `tone` is specified.
#'   Available options are: `r rev(names(nsw_colour_grids))`.
#' @param direction Set to -1 to reverse the order of colours in the palette,
#'   or 1 for the original order.
#' @returns A palette object (see [palette constructors][scales::new_continuous_palette])
#'
#' @inheritSection col_nsw Colour columns and tonal rows
#' @seealso [col_nsw()]
#'
#' @examples
#' library(scales)
#'
#' pal_nsw() |> show_col()
#' pal_nsw(hue = "blues") |> show_col()
#' pal_nsw(tone = 1:2, variant = "corporate") |> show_col()
#' pal_nsw(tone = "light") |> show_col()
#' pal_nsw(tone = "normal", variant = "aboriginal") |> show_col()
#'
#' # you can interpolate colours by converting to a continuous scale
#' pal_nsw(hue = "blues") |> as_continuous_pal() |> show_col(labels = FALSE)
pal_nsw <- function(
  palette = waiver(),
  hue = NA,
  tone = NA,
  variant = getOption("waratah.colour_theme", default = "base"),
  direction = 1
) {
  if (all(identical(hue, NA), identical(tone, NA))) {
    if (!missing(variant)) {
      cli::cli_warn(
        "{.arg variant} is ignored unless used with {.arg hue} or {.arg tone}"
      )
    }
  }
  rlang::check_exclusive(hue, tone, .require = FALSE)
  if (
    !is_waiver(palette) &&
      any(!missing(variant), !identical(hue, NA), !identical(tone, NA))
  ) {
    cli::cli_warn(
      "{.arg variant}, {.arg hue} and {.arg tone} are ignored when {.arg palette} is specified"
    )
  }

  if (!identical(hue, NA)) {
    colours <- col_nsw(hue = hue, variant = variant)
  } else if (!identical(tone, NA)) {
    colours <- col_nsw(tone = tone, variant = variant)
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

#' @rdname pal_nsw
#'
#' @param colours Vector of colour names corresponding to [nsw_colours].
#'
#' @export
pal_nsw_manual <- function(colours) {
  colours <- rlang::env_get_list(colours, env = as.environment(nsw_colours))
  scales::pal_manual(colours, type = "colour")
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
    paste0("t=", rownames(nsw_colour_grids$base)),
    " ",
    " v=aboriginal",
    paste0("h=", colnames(nsw_colour_grids$aboriginal)),
    paste0("t=", rownames(nsw_colour_grids$aboriginal))
  )
  cols <- unname(c(
    rev(as.list(nsw_named_palettes)),
    NA,
    NA,
    Map(
      \(x) unname(unlist(col_nsw(hue = x, variant = "base"))),
      colnames(nsw_colour_grids$base)
    ),
    Map(
      \(x) unname(unlist(col_nsw(tone = x, variant = "base"))),
      rownames(nsw_colour_grids$base)
    ),
    NA,
    NA,
    Map(
      \(x) unname(unlist(col_nsw(hue = x, variant = "aboriginal"))),
      colnames(nsw_colour_grids$aboriginal)
    ),
    Map(
      \(x) unname(unlist(col_nsw(tone = x, variant = "aboriginal"))),
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
