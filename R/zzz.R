.onLoad <- function(libname, pkgname) {
  has_public_sans <- "Public Sans" %in% systemfonts::system_fonts()$family

  if (!has_public_sans) {
    plain <- system.file(
      "fonts/Public_Sans/static/PublicSans-Regular.ttf",
      package = pkgname
    )
    bold <- system.file(
      "fonts/Public_Sans/static/PublicSans-Bold.ttf",
      package = pkgname
    )
    italic <- system.file(
      "fonts/Public_Sans/static/PublicSans-Italic.ttf",
      package = pkgname
    )
    bolditalic <- system.file(
      "fonts/Public_Sans/static/PublicSans-BoldItalic.ttf",
      package = pkgname
    )

    systemfonts::register_font(
      "Public Sans",
      plain = plain,
      bold = bold,
      italic = italic,
      bolditalic = bolditalic
    )
  }

  # {systemfonts} doesn't handle the pdf() device, so use {extrafont} to
  # convert the font format and register.
  if (!"Public Sans" %in% extrafont::fonts()) {
    cli::cli_inform("Installing Public Sans in {.pkg extrafont} database")
    extrafont::ttf_import(
      paths = system.file("fonts/Public_Sans/static", package = "waratah"),
      recursive = FALSE
    )
  }
  extrafont::loadfonts(device = "all", quiet = TRUE)
}
