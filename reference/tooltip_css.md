# Style interactive plot tooltips

CSS code required to add waratah-styled tooltips to interactive graphs
created using ggiraph.

## Usage

``` r
tooltip_css(
  background_colour = "grey_01",
  text_colour = "off_white",
  font_family = "\"Public Sans\", Arial, sans",
  font_size = "11pt"
)
```

## Arguments

- background_colour:

  tooltip background colour

- text_colour:

  tooltip text colour

- font_family:

  font family for text in tooltips

- font_size:

  font size for text in tooltips

## Value

A character vector containing CSS rules

## Details

As normal with HTML elements, you must make sure that the final document
loads the necessary fonts. See
[`vignette("waratah")`](https://digitalnsw.github.io/nsw-r-visualisations/articles/waratah.md)
for instructions.

## Examples

``` r
tooltip_css()
```
