#' Check colours are perceptually distinct
#'
#' Some palettes can include colours that are visually similar, especially to
#' people with colour vision disorders. This utility removes overly similar
#' colours in a set. This is done by clustering using the specified `method`
#' and `threshold`. It can be useful to set `plot = TRUE` to decide on a
#' suitable value of `threshold`.
#'
#' @param colours a colour vector.
#' @param threshold cutoff for clustering colours; meaning depends on `method`.
#' @param method distance method: see [`farver::compare_colour()`].
#' @param cvd if `TRUE` simular colour vision disorders.
#'   Requires `colorBlindness` to be installed.
#' @param plot if `TRUE` plot a dendrogram of the colour clusters.
#'   Names from `colours` are used to label the horixontal axis.
#'   Boxes are drawn around each cluster and coloured by the representative.
#' @param lightness,... other params passed to [`farver::compare_colour()`].
#'
#' @return vector of distinct colours from `colours`
#' @keywords internal
#' @noRd
#' @examples
#'
#' col_nsw(1:10, v = "b") |> col_distinct(plot = TRUE)
#' col_nsw(1:10, v = "b") |> col_distinct(plot = TRUE, cvd = TRUE)
col_distinct <- function(
  colours,
  threshold = 20,
  method = "cmc",
  lightness = 1,
  cvd = FALSE,
  plot = FALSE,
  ...
) {
  colours_orig <- colours
  if (cvd) {
    rlang::check_installed("colorBlindness")
    colours <- colorBlindness::cvdSimulator(colours)
  }

  tree <-
    colours |>
    farver::decode_colour(to = "lab") |>
    farver::compare_colour(from_space = "lab", ...) |>
    t() |>
    stats::as.dist() |>
    stats::hclust(method = "single")
  tree$labels <- names(colours_orig)

  clusts <- stats::cutree(tree, h = threshold)
  reduced_colours <- colours_orig[tree$order[!duplicated(clusts)]]

  if (plot) {
    plot_cols <- colours[tree$order]
    plot(stats::as.dendrogram(tree))
    for (n in seq_along(tree$order)) {
      graphics::rect(
        xleft = n - 0.33,
        ybottom = 0,
        xright = n + 0.33,
        ytop = graphics::par("usr")[3L],
        col = plot_cols[[n]],
        border = NA
      )
    }
    cnd <- rlang::catch_cnd(
      # fails when all colours are in distinct or a single group
      stats::rect.hclust(tree, h = threshold, border = reduced_colours)
    )
    if (!is.null(cnd)) {
      graphics::lines(
        x = c(0, length(tree$order) + 1),
        y = rep(threshold, 2L),
        lty = 2
      )
    }
  }

  reduced_colours
}

# finds a permutation that sorts the colours so that they start with the
# most perceptually distinct ones
col_anticluster <- function(colours, initial = NA, cvd = FALSE) {
  colours_orig <- colours
  if (cvd) {
    rlang::check_installed("colorBlindness")
    colours <- colorBlindness::cvdSimulator(colours)
  }

  lab <- farver::decode_colour(colours, to = "lab")
  D <- as.matrix(farver::compare_colour(
    lab,
    lab,
    from_space = "lab",
    method = "cie2000"
  ))
  if (is.na(initial)) {
    initial <- which.max(rowSums(D))
  }

  n <- nrow(D)
  selected <- integer(n)
  remaining <- seq_len(n)
  selected[1] <- initial
  remaining <- remaining[-selected[1]]

  for (i in 2:n) {
    min_dists <- apply(D[remaining, selected[1:(i - 1)], drop = FALSE], 1, min)
    best <- remaining[which.max(min_dists)]
    selected[i] <- best
    remaining <- remaining[remaining != best]
  }

  colours_orig[selected]
}
