test_that("grid offsets are correct", {
  # designed to catch offset issues if the colour vector order is changes without
  # also updating the grid-based accessors

  expect_equal(
    unname(calc_pal_shade(nsw_colour_grids$base, 1L)),
    c("#22272b", "#495054", "#cdd3d6", "#ebebeb")
  )
  expect_equal(
    unname(calc_pal_hue(nsw_colour_grids$base, 3L)),
    c(
      "#cdd3d6",
      "#a8edb3",
      "#8cdbe5",
      "#8ce0ff",
      "#cebfff",
      "#f4b5e6",
      "#ffb8c1",
      "#FFCE99",
      "#fde79a",
      "#e8d0b5"
    )
  )

  expect_equal(
    unname(calc_pal_shade(nsw_colour_grids$aboriginal, 1L)),
    c("#950906", "#e1261c", "#fbb4b3", "#fdd9d9")
  )
  expect_equal(
    unname(calc_pal_hue(nsw_colour_grids$aboriginal, 4L)),
    c(
      "#fdd9d9",
      "#f9d4be",
      "#e9c8b2",
      "#FFF1C5",
      "#dae6d1",
      "#c1e2e8",
      "#e4cce0",
      "#e5e3e0"
    )
  )
})
