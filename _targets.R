library(targets)
library(tarchetypes)

purrr::walk(list.files("./R", full.names = TRUE), source)

tar_option_set(
    packages = c(
        c("conflicted",
          "dotenv",
          "dplyr",
          "forcats",
          "readr",
          "tidymodels")
    )
)

tar_plan(
    tar_target(source_data, get_german_data("data"), format = "file"), 
    tar_target(clean_data, get_clean_data(source_data))
)
