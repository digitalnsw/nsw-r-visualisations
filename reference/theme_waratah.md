# theme_waratah()

theme_waratah()

## Usage

``` r
theme_waratah(
  title_font = "Public Sans",
  base_font = "Arial",
  void = FALSE,
  show_grid_lines = TRUE,
  base_text_size = 11,
  background_colour = TRUE,
  .colours = nsw_colours
)
```

## Arguments

- title_font:

  The default title is \\Public Sans\\. To change to a different font
  (e.g. to match up with an external publication requirement), simply
  change as desired (e.g. \\Arial\\). Make sure you've installed the
  fonts you want to use on your device first!

- base_font:

  The default font is \\Arial\\). If you want to use a different font
  (e.g. to match up with an external publication requirement), simply
  change as desired (e.g. \\Times New Roman\\). Make sure you've
  installed the fonts you want to use on your device first!

- void:

  Logical (TRUE/FALSE). If TRUE, all grid lines and axes are removed.
  This is useful when creating pie/donut charts.

- show_grid_lines:

  Logical (TRUE/FALSE). If FALSE, all grid lines are removed but the
  axis text is retained.

- base_text_size:

  Base text size in pt. The relative size of the title / subtitle text
  and of the margins is derived from this.

- background_colour:

  Logical. The default (TRUE) adds an off white colour to the background
  in line with the ophelia colour palette. Change to FALSE for a white
  background.

- .colours:

  Used to read in waratah_colours. Please leave as is!

## Value

No object is returned. Instead, the theme is applied to a ggplot plot.
