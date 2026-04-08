#' theme_waratah()
#'
#' @param title_font The default title is \"Public Sans\".
#'   To change to a different font (e.g. to match up with an external publication
#'   requirement), simply change as desired (e.g. \"Arial\"). Make sure you've
#'   installed the fonts you want to use on your device first!
#' @param base_font The default font is \"Arial\").
#'   If you want to use a different font (e.g. to match up with an external
#'   publication requirement), simply change as desired (e.g. \"Times New Roman\").
#'   Make sure you've installed the fonts you want to use on your device first!
#' @param void Logical (TRUE/FALSE).
#'   If TRUE, all grid lines and axes are removed. This is useful when creating
#'   pie/donut charts.
#' @param show_grid_lines Logical (TRUE/FALSE).
#'   If FALSE, all grid lines are removed but the axis text is retained.
#' @param base_text_size Base text size in pt.
#'   The relative size of the title / subtitle text and of the margins is derived
#'   from this.
#' @param background_colour Logical.
#'   The default (TRUE) adds an off white colour to the background in line with
#'   the ophelia colour palette. Change to FALSE for a white background.
#' @param .colours Used to read in waratah_colours.
#'   Please leave as is!
#'
#' @return No object is returned. Instead, the theme is applied to a ggplot plot.
#' @export
#'
theme_waratah <- function(
  title_font = "Public Sans",
  base_font = "Arial",
  void = FALSE,
  show_grid_lines = TRUE,
  base_text_size = 11,
  background_colour = TRUE,
  .colours = nsw_colours
) {
  theme_elements <- list(
    text = ggplot2::element_text(
      family = base_font,
      size = base_text_size,
      color = .colours$text
    ),
    plot.title = ggtext::element_markdown(
      family = title_font,
      size = base_text_size + 2,
      color = .colours$text,
      hjust = 0,
      face = "bold"
    ),
    plot.subtitle = ggtext::element_textbox_simple(
      margin = ggplot2::margin(5, 5, 10, 0)
    ),
    axis.title = ggplot2::element_text(
      family = base_font,
      size = base_text_size,
      color = .colours$text
    ),
    axis.text = ggplot2::element_text(
      family = base_font,
      size = base_text_size - 1,
      color = .colours$text
    ),
    legend.title = ggplot2::element_text(
      family = base_font,
      size = base_text_size,
      color = .colours$text
    ),
    legend.text = ggplot2::element_text(
      family = base_font,
      size = base_text_size - 1,
      color = .colours$text
    ),
    legend.background = ggplot2::element_rect(fill = "transparent"),
    plot.background = if (background_colour) {
      ggplot2::element_rect(fill = .colours$background)
    } else {
      ggplot2::element_blank()
    },
    panel.background = if (background_colour) {
      ggplot2::element_rect(fill = .colours$background)
    } else {
      ggplot2::element_blank()
    },
    panel.grid.major = if (show_grid_lines) {
      ggplot2::element_line(color = "#cdd3d6")
    } else {
      ggplot2::element_blank()
    },
    panel.grid.minor = if (show_grid_lines) {
      ggplot2::element_line(color = "#cdd3d6", linetype = "dotted")
    } else {
      ggplot2::element_blank()
    },
    strip.background = ggplot2::element_rect(fill = "transparent"),
    axis.ticks.x = ggplot2::element_blank(),
    axis.line = ggplot2::element_line(color = "transparent")
  )

  if (void) {
    theme_elements$plot.background <- ggplot2::element_blank()
    theme_elements$panel.background <- ggplot2::element_blank()
    theme_elements$panel.grid.major <- ggplot2::element_blank()
    theme_elements$panel.grid.minor <- ggplot2::element_blank()
    theme_elements$axis.title <- ggplot2::element_blank()
    theme_elements$axis.text <- ggplot2::element_blank()
    theme_elements$axis.ticks <- ggplot2::element_blank()
    theme_elements$axis.line <- ggplot2::element_blank()
    theme_elements$axis.ticks.x <- ggplot2::element_blank()
  }

  ggplot2::theme(
    text = theme_elements$text,
    plot.title = theme_elements$plot.title,
    plot.subtitle = theme_elements$plot.subtitle,
    axis.title = theme_elements$axis.title,
    axis.text = theme_elements$axis.text,
    legend.title = theme_elements$legend.title,
    legend.text = theme_elements$legend.text,
    legend.background = theme_elements$legend.background,
    plot.background = theme_elements$plot.background,
    panel.background = theme_elements$panel.background,
    panel.grid.major = theme_elements$panel.grid.major,
    panel.grid.minor = theme_elements$panel.grid.minor,
    strip.background = theme_elements$strip.background,
    axis.ticks = theme_elements$axis.ticks,
    axis.ticks.x = theme_elements$axis.ticks.x,
    axis.line = theme_elements$axis.line
  )
}
