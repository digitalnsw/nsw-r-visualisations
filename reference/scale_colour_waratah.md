# Waratah colour scales for 'ggplot2'

These scales can be used with ggplot to use the waratah palettes. The
`_c` variants interpolate the palette colours into a continuous
gradient.

## Usage

``` r
scale_colour_waratah(
  name = ggplot2::waiver(),
  ...,
  palette = "default",
  direction = 1,
  aesthetics = "colour"
)

scale_fill_waratah(
  name = ggplot2::waiver(),
  ...,
  palette = "default",
  direction = 1,
  aesthetics = "fill"
)

scale_colour_waratah_c(
  name = ggplot2::waiver(),
  ...,
  palette = "default",
  direction = -1,
  values = NULL,
  na.value = "grey50",
  guide = "colourbar",
  aesthetics = "colour"
)

scale_fill_waratah_c(
  name = ggplot2::waiver(),
  ...,
  palette = "default",
  direction = -1,
  values = NULL,
  na.value = "grey50",
  guide = "colourbar",
  aesthetics = "fill"
)
```

## Arguments

- name, na.value, guide, aesthetics, ...:

  Arguments passed on to
  [`ggplot2::discrete_scale()`](https://ggplot2.tidyverse.org/reference/discrete_scale.html)
  or
  [`ggplot2::continuous_scale()`](https://ggplot2.tidyverse.org/reference/continuous_scale.html)
  to control name, limits, breaks, labels and so forth.

- palette:

  Name of the palette: default, brand_default, neg_to_pos, greens,
  teals, blues, purples, fuchsias, reds, oranges, yellows, greys,
  browns, deeps, lights, warm_colours, cool_colours, colour_blind

- direction:

  Set to -1 to reverse the order of colours in the palette, or 1 for the
  original order.

- values:

  if colours should not be evenly positioned along the gradient this
  vector gives the position (between 0 and 1) for each anchor colour.
