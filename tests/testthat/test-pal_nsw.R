test_that("warns when params are ignored", {
  expect_no_warning(pal_nsw())
  expect_no_warning(pal_nsw(hue = "reds", variant = "aboriginal"))
  expect_warning(pal_nsw(variant = "aboriginal"))
  expect_warning(pal_nsw(palette = "default", variant = "aboriginal"))
  expect_warning(pal_nsw(palette = "default", hue = "reds"))
})

test_that("errors when setting both tone and hue", {
  expect_no_error(pal_nsw(hue = "reds"))
  expect_no_error(pal_nsw(tone = "normal"))
  expect_error(pal_nsw(hue = "reds", tone = "normal"))
})
