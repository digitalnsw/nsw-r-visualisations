#' Waratah colour scales for 'ggplot2'
#'
#' These scales can be used with ggplot to use the waratah palettes. The `_c`
#' variants interpolate the palette colours into a continuous gradient.
#'
#' @inheritParams pal_waratah
#' @param name,na.value,guide,aesthetics,... Arguments passed on to
#'   [ggplot2::discrete_scale()] or [ggplot2::continuous_scale()] to control name,
#'   limits, breaks, labels and so forth.
#' @param values if colours should not be evenly positioned along the gradient
#'   this vector gives the position (between 0 and 1) for each anchor colour.

#' @export
#' @rdname scale_colour_waratah
scale_colour_waratah <- function(
  name = ggplot2::waiver(),
  ...,
  palette = "default",
  direction = 1,
  aesthetics = "colour"
) {
  ggplot2::discrete_scale(
    aesthetics,
    name = name,
    palette = pal_waratah(palette, direction),
    ...
  )
}

#' @export
#' @rdname scale_colour_waratah
scale_fill_waratah <- function(
  name = ggplot2::waiver(),
  ...,
  palette = "default",
  direction = 1,
  aesthetics = "fill"
) {
  ggplot2::discrete_scale(
    aesthetics,
    name = name,
    palette = pal_waratah(palette, direction),
    ...
  )
}

#' @export
#' @rdname scale_colour_waratah
scale_colour_waratah_c <- function(
  name = ggplot2::waiver(),
  ...,
  palette = "default",
  direction = -1,
  values = NULL,
  na.value = "grey50",
  guide = "colourbar",
  aesthetics = "colour"
) {
  ggplot2::continuous_scale(
    aesthetics,
    name = name,
    palette = scales::pal_gradient_n(
      get_full_palette(palette, direction),
      values
    ),
    na.value = na.value,
    guide = guide,
    ...
  )
}

#' @export
#' @rdname scale_colour_waratah
scale_fill_waratah_c <- function(
  name = ggplot2::waiver(),
  ...,
  palette = "default",
  direction = -1,
  values = NULL,
  na.value = "grey50",
  guide = "colourbar",
  aesthetics = "fill"
) {
  ggplot2::continuous_scale(
    aesthetics,
    name = name,
    palette = scales::pal_gradient_n(
      get_full_palette(palette, direction),
      values
    ),
    na.value = na.value,
    guide = guide,
    ...
  )
}
