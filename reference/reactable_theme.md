# reactable_theme()

reactable_theme()

## Usage

``` r
reactable_theme(
  colour = "blue_01",
  title_font = "Public Sans",
  base_font = "Public Sans",
  base_text_size = 10,
  textColor = NULL,
  .colours = nsw_colours,
  backgroundColor = TRUE,
  borderColor = TRUE,
  stripedColor = NULL,
  ...
)
```

## Arguments

- colour:

  The starting colour for the table. It can be any of the
  ophelia_colours (e.g. "blue_01", "green_01", "purple_02").

- title_font:

  The default title is "Public Sans". To change to a different font
  (e.g. to match up with an external publication requirement), simply
  change as desired (e.g. "Times New Roman"). Make sure you've installed
  the fonts you want to use on your device first!

- base_font:

  The default font is also "Public Sans". If you want to use a different
  font (e.g. to match up with an external publication requirement),
  simply change as desired (e.g. "Arial"). Make sure you've installed
  the fonts you want to use on your device first!

- base_text_size:

  Base text size. The header size is relative to the base text size.

- textColor:

  You can specify a text colour if you would like it different to the
  borderColor and stripedColor.

- .colours:

  Used to read in nsw_colours. Please leave as is!

- backgroundColor:

  Logical. Can be specified as TRUE/FALSE. The colour is off_white
  \#F2F2F2

- borderColor:

  The colour for the horizontal lines between rows.

- stripedColor:

  The fill colour for alternate rows.

- ...:

  Other parameters to pass to reactable::reactableTheme(). See
  ?reactable::reactableTheme for documentation. For examples of what can
  be done with reactable, see
  https://glin.github.io/reactable/articles/cookbook/cookbook.html.

## Value

A theme to apply to a reactable object

## Examples

``` r
library(reactable)
head(palmerpenguins::penguins, 10) |>
  reactable(theme = reactableTheme())

{"x":{"tag":{"name":"Reactable","attribs":{"data":{"species":["Adelie","Adelie","Adelie","Adelie","Adelie","Adelie","Adelie","Adelie","Adelie","Adelie"],"island":["Torgersen","Torgersen","Torgersen","Torgersen","Torgersen","Torgersen","Torgersen","Torgersen","Torgersen","Torgersen"],"bill_length_mm":[39.1,39.5,40.3,"NA",36.7,39.3,38.9,39.2,34.1,42],"bill_depth_mm":[18.7,17.4,18,"NA",19.3,20.6,17.8,19.6,18.1,20.2],"flipper_length_mm":[181,186,195,"NA",193,190,181,195,193,190],"body_mass_g":[3750,3800,3250,"NA",3450,3650,3625,4675,3475,4250],"sex":["male","female","female",null,"female","male","female","male",null,null],"year":[2007,2007,2007,2007,2007,2007,2007,2007,2007,2007]},"columns":[{"id":"species","name":"species","type":"factor"},{"id":"island","name":"island","type":"factor"},{"id":"bill_length_mm","name":"bill_length_mm","type":"numeric"},{"id":"bill_depth_mm","name":"bill_depth_mm","type":"numeric"},{"id":"flipper_length_mm","name":"flipper_length_mm","type":"numeric"},{"id":"body_mass_g","name":"body_mass_g","type":"numeric"},{"id":"sex","name":"sex","type":"factor"},{"id":"year","name":"year","type":"numeric"}],"dataKey":"d09fc92c32ed54493f36a19991012b2e"},"children":[]},"class":"reactR_markup"},"evals":[],"jsHooks":[]}
# Adding NSW style:
head(palmerpenguins::penguins, 10) |>
  reactable(theme = reactable_theme())

{"x":{"tag":{"name":"Reactable","attribs":{"data":{"species":["Adelie","Adelie","Adelie","Adelie","Adelie","Adelie","Adelie","Adelie","Adelie","Adelie"],"island":["Torgersen","Torgersen","Torgersen","Torgersen","Torgersen","Torgersen","Torgersen","Torgersen","Torgersen","Torgersen"],"bill_length_mm":[39.1,39.5,40.3,"NA",36.7,39.3,38.9,39.2,34.1,42],"bill_depth_mm":[18.7,17.4,18,"NA",19.3,20.6,17.8,19.6,18.1,20.2],"flipper_length_mm":[181,186,195,"NA",193,190,181,195,193,190],"body_mass_g":[3750,3800,3250,"NA",3450,3650,3625,4675,3475,4250],"sex":["male","female","female",null,"female","male","female","male",null,null],"year":[2007,2007,2007,2007,2007,2007,2007,2007,2007,2007]},"columns":[{"id":"species","name":"species","type":"factor"},{"id":"island","name":"island","type":"factor"},{"id":"bill_length_mm","name":"bill_length_mm","type":"numeric"},{"id":"bill_depth_mm","name":"bill_depth_mm","type":"numeric"},{"id":"flipper_length_mm","name":"flipper_length_mm","type":"numeric"},{"id":"body_mass_g","name":"body_mass_g","type":"numeric"},{"id":"sex","name":"sex","type":"factor"},{"id":"year","name":"year","type":"numeric"}],"theme":{"borderColor":"#002664","stripedColor":"#0026644C","style":{"color":"#002664","fontFamily":"Public Sans","fontSize":"10px"},"tableStyle":{"fontFamily":"Public Sans","fontSize":"10px"},"headerStyle":{"fontFamily":"Public Sans","fontSize":"12px"},"cellStyle":{"fontFamily":"Public Sans","fontSize":"10px"}},"dataKey":"d09fc92c32ed54493f36a19991012b2e"},"children":[]},"class":"reactR_markup"},"evals":[],"jsHooks":[]}
# Further arguments for styling
head(palmerpenguins::penguins, 10) |>
  reactable(
    theme = reactable_theme(
      colour = "blue_01",
      base_font = "Arial",
      textColor = "black",
      backgroundColor = TRUE,
      borderColor = TRUE
    ),
    striped = TRUE
  )

{"x":{"tag":{"name":"Reactable","attribs":{"data":{"species":["Adelie","Adelie","Adelie","Adelie","Adelie","Adelie","Adelie","Adelie","Adelie","Adelie"],"island":["Torgersen","Torgersen","Torgersen","Torgersen","Torgersen","Torgersen","Torgersen","Torgersen","Torgersen","Torgersen"],"bill_length_mm":[39.1,39.5,40.3,"NA",36.7,39.3,38.9,39.2,34.1,42],"bill_depth_mm":[18.7,17.4,18,"NA",19.3,20.6,17.8,19.6,18.1,20.2],"flipper_length_mm":[181,186,195,"NA",193,190,181,195,193,190],"body_mass_g":[3750,3800,3250,"NA",3450,3650,3625,4675,3475,4250],"sex":["male","female","female",null,"female","male","female","male",null,null],"year":[2007,2007,2007,2007,2007,2007,2007,2007,2007,2007]},"columns":[{"id":"species","name":"species","type":"factor"},{"id":"island","name":"island","type":"factor"},{"id":"bill_length_mm","name":"bill_length_mm","type":"numeric"},{"id":"bill_depth_mm","name":"bill_depth_mm","type":"numeric"},{"id":"flipper_length_mm","name":"flipper_length_mm","type":"numeric"},{"id":"body_mass_g","name":"body_mass_g","type":"numeric"},{"id":"sex","name":"sex","type":"factor"},{"id":"year","name":"year","type":"numeric"}],"striped":true,"theme":{"borderColor":"#002664","stripedColor":"#0026644C","style":{"color":"black","fontFamily":"Arial","fontSize":"10px"},"tableStyle":{"fontFamily":"Arial","fontSize":"10px"},"headerStyle":{"fontFamily":"Public Sans","fontSize":"12px"},"cellStyle":{"fontFamily":"Arial","fontSize":"10px"}},"dataKey":"d09fc92c32ed54493f36a19991012b2e"},"children":[]},"class":"reactR_markup"},"evals":[],"jsHooks":[]}
```
