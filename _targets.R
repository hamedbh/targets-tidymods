## Load your packages, e.g. library(targets).
source("./packages.R")

## Load your R files
purrr::walk(list.files("./R", full.names = TRUE), source)

## tar_plan supports drake-style targets and also tar_target()
tar_plan(
    tar_target(
        source_url, 
        "https://archive.ics.uci.edu/ml/machine-learning-databases/statlog/german/german.data"
    ), 
    tar_target(
        source_data, 
        get_german_data(source_url, "data"), 
        format = "file"
    )
)
