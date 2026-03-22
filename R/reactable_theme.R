#' reactable_theme()
#'
#' @param colour The starting colour for the table.
#'   It can be any of the ophelia_colours (e.g. "blue_01", "green_01", "purple_02").
#' @param title_font The default title is "Public Sans".
#'   To change to a different font (e.g. to match up with an external publication
#'   requirement), simply change as desired (e.g. "Times New Roman"). Make sure you've
#'   installed the fonts you want to use on your device first!
#' @param base_font The default font is also "Public Sans".
#'   If you want to use a different font (e.g. to match up with an external publication
#'   requirement), simply change as desired (e.g. "Arial"). Make sure you've installed
#'   the fonts you want to use on your device first!
#' @param base_text_size Base text size.
#'   The header size is relative to the base text size.
#' @param .colours Used to read in nsw_colours.
#'   Please leave as is!
#' @param ... Other parameters to pass to reactable::reactableTheme().
#'   See ?reactable::reactableTheme for documentation.
#'   For examples of what can be done with reactable, see
#'   https://glin.github.io/reactable/articles/cookbook/cookbook.html.
#' @param textColor You can specify a text colour if you would like it
#'   different to the borderColor and stripedColor.
#' @param backgroundColor Logical. Can be specified as TRUE/FALSE.
#'   The colour is off_white #F2F2F2
#' @param borderColor The colour for the horizontal lines between rows.
#' @param stripedColor The fill colour for alternate rows.
#'
#' @return A theme to apply to a reactable object
#' @export
#'
reactable_theme <- function(
  colour = "blue_01",
  title_font = "Public Sans",
  base_font = "Public Sans",
  base_text_size = 10,
  textColor = NULL,
  .colours = nsw_colours,
  backgroundColor = TRUE,
  borderColor = TRUE,
  stripedColor = NULL,
  ...
) {
  primary_colour <- .colours[[colour]]

  style_list <- list(
    color = ifelse(is.null(textColor), primary_colour, textColor),
    fontFamily = base_font,
    fontSize = paste0(base_text_size, "px")
  )
  table_style_list <- list(
    fontFamily = base_font,
    fontSize = paste0(base_text_size, "px")
  )
  header_style_list <- list(
    fontFamily = title_font,
    fontSize = paste0(base_text_size + 2, "px")
  )
  cell_style_list <- list(
    fontFamily = base_font,
    fontSize = paste0(base_text_size, "px")
  )

  if (!backgroundColor) {
    style_list$backgroundColor <- NULL
  }
  if (!borderColor) {
    style_list$borderColor <- NULL
  }

  if (is.null(stripedColor)) {
    striped_color <- scales::alpha(primary_colour, 0.3)
  } else {
    striped_color <- scales::alpha(stripedColor, 0.3)
  }

  reactable::reactableTheme(
    style = style_list,
    tableStyle = table_style_list,
    headerStyle = header_style_list,
    cellStyle = cell_style_list,
    # Additional parameters from reactable::reactableTheme()
    backgroundColor = if (backgroundColor) .colours$background else NULL,
    borderColor = if (borderColor) primary_colour else NULL,
    stripedColor = striped_color,
    ...
  )
}
