# Interactive plots

``` r
library(waratah)
library(palmerpenguins)
library(ggplot2)
library(ggiraph)
library(gdtools)
#> 
#> Attaching package: 'gdtools'
#> The following object is masked from 'package:ggiraph':
#> 
#>     match_family

nsw_fonts <- font_set(sans = font_google("Public Sans"))
```

Saving plot to an object to demonstrate custom tooltip function using
ggiraph:

``` r
p_gir <-
  ggplot(penguins) +
  geom_point_interactive(aes(
    x = bill_length_mm,
    y = flipper_length_mm,
    colour = species,
    size = body_mass_g,
    tooltip = paste0(
      "Species: ",
      species,
      "<br>Bill length: ",
      bill_length_mm,
      "<br>Flipper length: ",
      flipper_length_mm
    )
  )) +
  labs(
    title = "Penguin measurements",
    dictionary = c(
      bill_length_mm = "Bill length (mm)",
      flipper_length_mm = "Flipper length (mm)",
      species = "Species",
      body_mass_g = "Body mass (g)"
    ),
    caption = "Data from {palmerpenguins}"
  ) +
  scale_colour_manual(
    values = c(
      nsw_colours$blue_01,
      nsw_colours$red_02,
      nsw_colours$teal_02
    )
  ) +
  theme_waratah()

# Create the interactive plot using ggiraph and custom tooltip from waratah package (load the object to show in Viewer)
girafe(
  ggobj = p_gir,
  font_set = nsw_fonts,
  options = list(
    opts_tooltip(css = tooltip_css())
  )
)
#> Warning: Removed 2 rows containing missing values or values outside the scale range
#> (`geom_interactive_point()`).
```

``` r

# With additional styling options
girafe(
  ggobj = p_gir,
  font_set = nsw_fonts,
  options = list(
    opts_tooltip(
      css = tooltip_css(
        font_family = "Arial",
        font_size = "18px",
        background_color = "blue_04",
        text_color = "blue_01"
      )
    )
  )
)
#> Warning: Removed 2 rows containing missing values or values outside the scale range
#> (`geom_interactive_point()`).
```
