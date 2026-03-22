# reactable_theme()

reactable_theme()

## Usage

``` r
reactable_theme(
  colour = "blue_01",
  title_font = "Public Sans",
  base_font = "Public Sans",
  base_text_size = 10,
  textColor = NULL,
  .colours = waratah_colours,
  backgroundColor = TRUE,
  borderColor = TRUE,
  stripedColor = NULL,
  ...
)
```

## Arguments

- colour:

  The starting colour for the table. It can be any of the
  ophelia_colours (e.g. "blue_01", "green_01", "purple_02").

- title_font:

  The default title is "Public Sans". To change to a different font
  (e.g. to match up with an external publication requirement), simply
  change as desired (e.g. "Times New Roman"). Make sure you've installed
  the fonts you want to use on your device first!

- base_font:

  The default font is also "Public Sans". If you want to use a different
  font (e.g. to match up with an external publication requirement),
  simply change as desired (e.g. "Arial"). Make sure you've installed
  the fonts you want to use on your device first!

- base_text_size:

  Base text size. The header size is relative to the base text size.

- textColor:

  You can specify a text colour if you would like it different to the
  borderColor and stripedColor.

- .colours:

  Used to read in waratah_colours. Please leave as is!

- backgroundColor:

  Logical. Can be specified as TRUE/FALSE. The colour is off_white
  \#F2F2F2

- borderColor:

  The colour for the horizontal lines between rows.

- stripedColor:

  The fill colour for alternate rows.

- ...:

  Other parameters to pass to reactable::reactableTheme(). See
  ?reactable::reactableTheme for documentation. For examples of what can
  be done with reactable, see
  https://glin.github.io/reactable/articles/cookbook/cookbook.html.

## Value

A theme to apply to a reactable object
