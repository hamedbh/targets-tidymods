## Load your packages, e.g. library(targets).
source("./packages.R")

## Load your R files
purrr::walk(list.files("./R", full.names = TRUE), source)

## tar_plan supports drake-style targets and also tar_target()
tar_plan()
