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
#'   - **hue**: `r nsw_colour_grids$base$hues`
#'   - **shade**: `r nsw_colour_grids$base$shades`
#'
#' The `"aboriginal"` variant supports:
#'   - **hue**: `r nsw_colour_grids$aboriginal$hues`
#'   - **shade**: `r nsw_colour_grids$aboriginal$shades`
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
  palette <- pal_name(
    palette = palette,
    hue = hue,
    shade = shade,
    variant = variant
  )
  colours <- nsw_palettes[[palette]]

  if (direction < 0) {
    colours <- rev(colours)
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
  if (is_waiver(palette) && !all(is.na(hue), is.na(shade))) {
    variant <- match.arg(variant)
    pals <- Filter(
      \(x) {
        isTRUE(
          attr(x, "variant") == variant &&
            (is.na(hue) || attr(x, "hue") == hue) &&
            (is.na(shade) || attr(x, "shade") == shade)
        )
      },
      nsw_palettes
    )
    palette <- switch(
      length(pals) + 1L,
      cli::cli_abort("No matching palettes"),
      names(pals)[[1]],
      cli::cli_abort("Bad search")
    )
  }
  if (is_waiver(palette)) {
    palette = names(nsw_palettes)[[1]]
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
  # sets attributes on each grid-based palette so that they can
  # be retrieved by other functions in this file
  new_pal_group <- function(
    pals,
    variant = NA_character_,
    hue = NA_character_,
    shade = NA_character_
  ) {
    pals <- mapply(
      structure,
      .Data = pals,
      variant = variant,
      hue = hue,
      shade = shade,
      SIMPLIFY = FALSE
    )
    setNames(
      pals,
      apply(cbind(variant, hue, shade), 1, function(x) {
        paste(x[!is.na(x)], collapse = "_")
      })
    )
  }

  base_hues <-
    new_pal_group(
      Map(
        \(i) unname(calc_pal_shade(nsw_colour_grids$base, i)),
        seq_along(nsw_colour_grids$base$hues)
      ),
      variant = "base",
      hue = nsw_colour_grids$base$hues
    )

  base_shades <-
    new_pal_group(
      Map(
        \(i) unname(calc_pal_hue(nsw_colour_grids$base, i)),
        seq_along(nsw_colour_grids$base$shades)
      ),
      variant = "base",
      shade = nsw_colour_grids$base$shades
    )

  aboriginal_hues <-
    new_pal_group(
      Map(
        \(i) unname(calc_pal_shade(nsw_colour_grids$aboriginal, i)),
        seq_along(nsw_colour_grids$aboriginal$hues)
      ),
      variant = "aboriginal",
      hue = nsw_colour_grids$aboriginal$hues
    )

  aboriginal_shades <-
    new_pal_group(
      Map(
        \(i) unname(calc_pal_hue(nsw_colour_grids$aboriginal, i)),
        seq_along(nsw_colour_grids$aboriginal$shades)
      ),
      variant = "aboriginal",
      shade = nsw_colour_grids$aboriginal$shades
    )

  c(
    nsw_palettes_manual,
    base_hues,
    base_shades,
    aboriginal_hues,
    aboriginal_shades
  )
}

display_pal_nsw <- function() {
  pals <- c(
    names(nsw_palettes_manual),
    " ",
    " v=base",
    Filter(\(x) isTRUE(attr(x, "variant") == "base"), nsw_palettes) |>
      names(),
    " ",
    " v=aboriginal",
    Filter(\(x) isTRUE(attr(x, "variant") == "aboriginal"), nsw_palettes) |>
      names()
  )
  labels <- Map(function(pal) {
    if (startsWith(pal, " ")) return(pal)
    hue <- attr(nsw_palettes[[pal]], "hue")
    shade <- attr(nsw_palettes[[pal]], "shade")
    if (is.null(hue)) {
      pal
    } else if (is.na(shade)) {
      sprintf("h=%s", hue)
    } else {
      sprintf("s=%s", shade)
    }
  }, pals)

  n <- lengths(nsw_palettes[pals])
  nr <- length(pals)
  nc <- max(n)

  ylim <- c(0, nr)
  oldpar <- par(mgp = c(0, 0, 0), mar = c(0, 4, 0, 0))
  on.exit(par(oldpar))
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
    shadi <- nsw_palettes[[pals[[i]]]]
    rect(
      xleft = 0:(nj - 1),
      ytop = nr - i,
      xright = 1:nj,
      ybottom = nr - i + 0.8,
      col = shadi,
      border = "light grey"
    )
  }
  text(
    rep(-0.1, nr),
    rev(1:nr) - 0.6,
    labels = labels,
    xpd = TRUE,
    adj = 1,
    cex = 0.7
  )
}
