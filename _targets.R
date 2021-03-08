options(clustermq.scheduler = "multicore")

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

model_values <- tibble::tibble(
    model_type = c("tree", "elnet", "svm", "rf"), 
    wfl_fn = rlang::syms(paste0("create_", model_type, "_wfl")), 
    tune_fn = rlang::syms(paste0("tune_", model_type, "_grid"))
)

shared_targets <- tar_plan(
    tar_target(source_data, get_german_data("data"), format = "file"), 
    tar_target(clean_data, get_clean_data(source_data)), 
    tar_target(splits, initial_split(clean_data, prop = 0.8, strata = outcome)), 
    tar_target(folds, vfold_cv(training(splits), v = 10, strata = outcome)), 
    tar_target(base_rec, recipe(outcome ~ ., data = training(splits)))
)

model_targets <- tar_map(
    values = model_values, 
    names = "model_type", 
    tar_target(wfl, wfl_fn(base_rec)), 
    tar_target(res, tune_fn(wfl, folds))
)

list(shared_targets, model_targets)
