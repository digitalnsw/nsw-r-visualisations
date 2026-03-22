#' @export
#' @rdname pal_nsw
#' @format NULL
nsw_colours <- list(
  # NOTE: order is important. Adjust grid definitions below if changing order.
  black = "#000000",
  white = "#ffffff",
  off_white = "#F2F2F2",

  grey_01 = "#22272b",
  grey_02 = "#495054",
  grey_03 = "#cdd3d6",
  grey_04 = "#ebebeb",
  green_01 = "#004000",
  green_02 = "#00aa45",
  green_03 = "#a8edb3",
  green_04 = "#dbfadf",
  teal_01 = "#0b3f47",
  teal_02 = "#2e808e",
  teal_03 = "#8cdbe5",
  teal_04 = "#d1eeea",
  blue_01 = "#002664",
  blue_02 = "#146cfd",
  blue_03 = "#8ce0ff",
  blue_04 = "#cbedfd",
  purple_01 = "#441170",
  purple_02 = "#8055f1",
  purple_03 = "#cebfff",
  purple_04 = "#e6e1fd",
  fuchsia_01 = "#65004d",
  fuchsia_02 = "#d912ae",
  fuchsia_03 = "#f4b5e6",
  fuchsia_04 = "#fddef2",
  red_01 = "#630019",
  red_02 = "#d7153a",
  red_03 = "#ffb8c1",
  red_04 = "#ffe6ea",
  orange_01 = "#941b00",
  orange_02 = "#f3631b",
  orange_03 = "#FFCE99",
  orange_04 = "#fdeddf",
  yellow_01 = "#694800",
  yellow_02 = "#faaf05",
  yellow_03 = "#fde79a",
  yellow_04 = "#fff4cf",
  brown_01 = "#523719",
  brown_02 = "#b68d5d",
  brown_03 = "#e8d0b5",
  brown_04 = "#ede3d7",

  earth_red = "#950906",
  ember_red = "#e1261c",
  coral_pink = "#fbb4b3",
  galah_pink = "#fdd9d9",
  deep_orange = "#882600",
  orange_ochre = "#ee6314",
  clay_orange = "#f4aa7d",
  sunset_orange = "#f9d4be",
  riverbed_brown = "#552105",
  firewood_brown = "#9e5332",
  claystone_brown = "#d39165",
  macadamia_brown = "#e9c8b2",
  bush_honey_yellow = "#895e00",
  sandstone_yellow = "#fea927",
  golden_wattle_yellow = "#FEE48C",
  sunbeam_yellow = "#FFF1C5",
  bushland_green = "#215834",
  marshland_lime = "#78a146",
  gumleaf_green = "#b5cda4",
  saltbush_green = "#dae6d1",
  billabong_blue = "#00405e",
  saltwater_blue = "#0d6791",
  light_water_blue = "#84c5d1",
  coastal_blue = "#c1e2e8",
  bush_plum = "#472642",
  spirit_lilac = "#9a5e93",
  lilli_pilli_purple = "#c99ac2",
  dusk_purple = "#e4cce0",
  charcoal_grey = "#272727",
  emu_grey = "#555555",
  ash_grey = "#ccc6c2",
  smoke_grey = "#e5e3e0"
)

# defines the offsets and dimensions of each colour grid,
# used to index into the above vector
nsw_colour_grids <- list(
  base = list(
    offset = 3L,
    hues = c(
      "greys",
      "greens",
      "teals",
      "blues",
      "purples",
      "fucshias",
      "reds",
      "oranges",
      "yellows",
      "browns"
    ),
    shades = c("dark", "normal", "light", "lighter")
  ),
  aboriginal = list(
    offset = 43L,
    hues = c(
      "reds",
      "oranges",
      "browns",
      "yellows",
      "greens",
      "blues",
      "purples",
      "greys"
    ),
    shades = c("dark", "normal", "light", "lighter")
  )
)

calc_pal_shade <- function(config, hue) {
  n_hues <- length(config$hues)
  stopifnot(length(hue) == 1L, hue > 0L, hue <= n_hues)
  n_shades <- length(config$shades)
  start <- 1L + config$offset + (n_shades * (hue - 1L))
  end <- start + n_shades - 1L
  unlist(nsw_colours[seq(start, end, by = 1L)])
}

calc_pal_hue <- function(config, shade) {
  n_shades <- length(config$shades)
  stopifnot(all(shade > 0L), all(shade <= n_shades))
  n_colours <- length(config$hues) * n_shades
  start <- 1L + config$offset
  end <- start + n_colours - 1L
  unlist(nsw_colours[seq(start, end, by = n_shades) + shade - 1L])
}
