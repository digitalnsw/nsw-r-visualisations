# Construct palette variants

Depending on the structure of your data you may wish to combine palettes
according to some pattern. These helpers may come in handy.

- `pal_c()` concatenates multiple discrtee palettes.

- `pal_interleave()` interleaves colours from multiple palettes of the
  same size. It helps when your data are grouped and you need more
  flexibility than the colour grid.

- `pal_stretch()` interpolates a palette into a new discrete palette.
  It's useful for stretching the 4 tones into 5 or 6, at the expense of
  straying from the NSW grid.

- `col_contrasting()` chooses colours based on the given background
  colours. It helps when drawing text on top of a mapped (i.e. variable)
  fill aesthetic

## Usage

``` r
pal_interleave(...)

pal_c(...)

pal_stretch(pal)

col_contrasting(colour, light = "white", dark = "black")
```

## Arguments

- ...:

  two or more vectors of colours.

- pal:

  palette object.

- colour:

  vector of colours.

- light, dark:

  colours to output when `colour` is dark or light respectively.

## Value

- for `col_contrasting()` a vector of colours the same length as
  `colour`,

- for `pal_*()` a palette object.
