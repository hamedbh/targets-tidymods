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
          "themis", 
          "tidymodels")
    )
)

tar_plan(
    # Get the data and clean it
    tar_target(source_data, get_german_data("data"), format = "file"), 
    tar_target(raw_data, read_raw_data(source_data)), 
    tar_target(clean_data, get_clean_data(raw_data)), 
    # Partition the data and create the cross-validation folds
    tar_target(splits, initial_split(clean_data, prop = 0.8, strata = outcome)), 
    tar_target(folds, vfold_cv(training(splits), v = 10, strata = outcome)), 
    # Create a minimal pre-processing recipe
    tar_target(base_rec, recipe(outcome ~ ., data = training(splits))), 
    # Recipe, workflow, and grid tuning for the four model types
    tar_map(
        values = tibble::tibble(
            model_type = c("tree", "elnet", "svm", "rf"), 
            rec_fn = rlang::syms(paste0("create_", model_type, "_rec")), 
            wfl_fn = rlang::syms(paste0("create_", model_type, "_wfl")), 
            tune_fn = rlang::syms(paste0("tune_", model_type, "_grid"))
        ), 
        names = "model_type", 
        tar_target(rec, rec_fn(base_rec)), 
        tar_target(wfl, wfl_fn(rec)), 
        tar_target(res, tune_fn(wfl, folds))
    ), 
    # Try rebalancing methods
    tar_map(
        values = tibble::tibble(
            upsample_type = c("bsmote", "nearmiss"), 
            rec_fn = rlang::syms(paste0("create_", upsample_type, "_rec"))
        ), 
        names = "upsample_type", 
        tar_target(rec, rec_fn(base_rec)), 
        tar_target(wfl, create_rf_wfl(rec)), 
        tar_target(res, tune_rf_grid(wfl, folds))
    )
)
