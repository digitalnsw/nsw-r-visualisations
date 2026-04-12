# Construct palette variants

Depending on the structure of your data you may wish to combine palettes
according to some pattern. These helpers may come in handy.
`pal_interleave()` and `pal_paired()` are for grouped data.
`pal_stretch()` interpolates a palette into a new discrete palette.
`col_contrasting()` chooses colours based on the given background
colours.

## Usage

``` r
pal_interleave(...)

pal_paired(colours, amount = 50)

pal_stretch(pal)

col_contrasting(bg)
```

## Arguments

- ...:

  two or more vectors of colours

- amount:

  amount to lighten then colours for the paired set

- pal:

  palette object

- bg, colours:

  vector of colours

## Value

- for `col_contrasting()` a vector of colours the same length as `bg`,

- for `pal_*()` a palette object.
