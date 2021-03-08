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

tar_plan(
    tar_target(source_data, get_german_data("data"), format = "file"), 
    tar_target(clean_data, get_clean_data(source_data)), 
    tar_target(splits, initial_split(clean_data, prop = 0.8, strata = outcome)), 
    tar_target(folds, vfold_cv(training(splits), v = 10, strata = outcome)), 
    tar_target(base_rec, recipe(outcome ~ ., data = training(splits))), 
    # Decision tree
    tar_target(tree_wfl, create_tree_wfl(base_rec)), 
    tar_target(tree_tune, tune_tree_grid(tree_wfl, folds)), 
    # Elastic net
    tar_target(elnet_wfl, create_elnet_wfl(base_rec)), 
    tar_target(elnet_tune, tune_elnet_grid(elnet_wfl, folds)), 
    # SVM
    tar_target(svm_wfl, create_svm_wfl(base_rec)), 
    tar_target(svm_tune, tune_svm_grid(svm_wfl, folds))
    
)
