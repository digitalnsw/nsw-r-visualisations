test_that("col_contrasting chooses suitable colours", {
  colours <- c("navy", "white", "black", "yellow")
  expect_equal(col_contrasting(colours), c("white", "black", "white", "black"))
})
