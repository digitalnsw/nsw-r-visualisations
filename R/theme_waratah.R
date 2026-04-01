#' Theme plots using NSW colours and fonts
#'
#' A 'ggplot2' theme compatible with the NSW design system.
#' It sets default colour scales, fonts, and some other styles.
#'
#' @param void whether to hide grid lines and axes.
#'   If `TRUE`, all grid lines and axes are removed. This is useful when creating
#'   pie/donut charts.
#' @param show_grid_lines whether to show grid lines.
#'   If `FALSE`, all grid lines are removed but the axis text is retained.
#'   Ignored when `void` is `TRUE`.
#' @inheritParams ggplot2::theme_minimal
#' @returns ggplot theme specification to add to a plot
#' @export
#' @importFrom ggplot2 theme element_blank element_text element_geom element_line element_rect %+replace%
#' @examples
#' library(ggplot2)
#' set_theme(theme_waratah())
#'
#' ggplot(palmerpenguins::penguins) +
#'   geom_point(aes(
#'     x = bill_length_mm,
#'     y = flipper_length_mm,
#'     colour = species,
#'     size = body_mass_g
#'   )) +
#'   labs(
#'     caption = "Data from {palmerpenguins}",
#'     dictionary = c(
#'       bill_length_mm = "Bill length (mm)",
#'       flipper_length_mm = "Flipper length (mm)",
#'       species = "Species",
#'       body_mass_g = "Body mass (g)"
#'     )
#'   )
#'
theme_waratah <- function(
  base_size = 11,
  base_family = "Arial",
  header_family = "Public Sans",
  base_line_size = base_size / 22,
  base_rect_size = base_size / 22,
  ink = "black",
  paper = "off_white",
  accent = "blue_01",
  show_grid_lines = TRUE,
  void = FALSE
) {
  ink <- resolve_colours(ink)
  paper <- resolve_colours(paper)
  accent <- resolve_colours(accent)

  new_theme <-
    ggplot2::theme_minimal(
      base_size = base_size,
      base_family = base_family,
      header_family = header_family,
      base_line_size = base_line_size,
      base_rect_size = base_rect_size,
      ink = ink,
      paper = paper,
      accent = accent
    ) %+replace%
    theme(
      # plot.title = marquee::element_marquee(
      #   width = 1,
      #   family = header_family,
      #   size = base_size + 2,
      #   style = marquee::classic_style(weight = "bold"),
      #   colour = ink,
      #   hjust = 0,
      # ),
      # plot.subtitle = marquee::element_marquee(
      #   width = 1,
      #   family = header_family,
      #   margin = ggplot2::margin_part(t = base_size, b = base_size)
      # ),
      legend.background = element_rect(fill = "transparent"),
      panel.grid.major = element_line(color = "#cdd3d6"),
      panel.grid.minor = element_line(color = "#cdd3d6", linetype = "dotted"),
      strip.background = element_rect(fill = "transparent"),
      axis.ticks.x = element_blank(),
      axis.line = element_line(color = "transparent"),
      geom = element_geom(ink = ink, paper = paper, accent = accent),
      palette.colour.discrete = pal_nsw("default"),
      palette.fill.discrete = pal_nsw("default"),
      palette.colour.continuous = scales::as_continuous_pal(pal_nsw(
        hue = "blues"
      )),
      palette.fill.continuous = scales::as_continuous_pal(pal_nsw(
        hue = "blues"
      )),
      complete = TRUE
    )

  if (!show_grid_lines) {
    new_theme <- new_theme %+replace%
      ggplot2::theme(
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        complete = TRUE
      )
  }

  if (void) {
    new_theme <- new_theme %+replace%
      ggplot2::theme(
        plot.background = element_blank(),
        panel.background = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        axis.line = element_blank(),
        axis.ticks.x = element_blank(),
        complete = TRUE
      )
  }

  new_theme
}

# replaces NSW colours with their hex codes, leaving others unchanged
resolve_colours <- function(x) {
  if (is.character(x)) {
    hex_colours <- setdiff(names(nsw_colours), colors())
    hex <- rlang::env_get_list(
      x,
      env = as.environment(nsw_colours),
      default = NA_character_
    )
    ifelse(x %in% hex_colours, as.character(hex), x)
  } else {
    x
  }
}
