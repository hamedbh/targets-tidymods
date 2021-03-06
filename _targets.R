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
    tar_target(clean_data, get_clean_data(source_data)), 
    tar_target(splits, initial_split(clean_data, prop = 0.8, strata = outcome)), 
    tar_target(folds, vfold_cv(training(splits), v = 10, strata = outcome)), 
    tar_target(base_rec, recipe(outcome ~ ., data = training(splits))), 
    # Decision tree
    tar_target(tree_spec, specify_tree())
    # Elastic net
    # SVM
)
