#' tooltipcss
#'
#'CSS code required to add waratah-styled tooltips to interactive graphs created using ggiraph
#'
#' @export
#'
#' @param font_family Font family for text in tooltips (default: "Public Sans")
#' @param font_size Font size for text in tooltips (default: "11px")
#' @param text_color Hover text colour (default: #F2F2F2)
#' @param background_color Hover background colour (default: #22272b)
#'
#' @return A character vector containing CSS styles for tooltips
tooltip_css <- function(font_family = NULL,
                        font_size = NULL,
                        background_color = NULL,
                        text_color = NULL) {

  if (is.null(font_family)) {
    font_family <- "Public Sans"
  }
  if (is.null(font_size)) {
    font_size <- "11px"
  }
  if (is.null(background_color)) {
    background_color <- "#22272b"
  }
  if (is.null(text_color)) {
    text_color <- "#F2F2F2"
  }

  if (is.character(background_color) && exists("waratah_colours", envir = asNamespace("waratah"))) {
    waratah_colours <- get("waratah_colours", envir = asNamespace("waratah"))
    if (background_color %in% names(waratah_colours)) {
      background_color <- waratah_colours[[background_color]]
    }
  }

  if (is.character(text_color) && exists("waratah_colours", envir = asNamespace("waratah"))) {
    waratah_colours <- get("waratah_colours", envir = asNamespace("waratah"))
    if (text_color %in% names(waratah_colours)) {
      text_color <- waratah_colours[[text_color]]
    }
  }

  css <- sprintf('
    max-width: 300px;
    background-color: %s;
    color: %s; /* Text color */
    font-family: "%s";
    font-size: %s;
    padding: 10px;
  ', background_color, text_color, font_family, font_size)

  css
}
