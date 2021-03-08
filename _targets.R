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
    tar_target(tree_spec, specify_tree()), 
    tar_target(tree_rec, create_tree_rec(base_rec)), 
    tar_target(tree_wfl, 
               workflow() %>% 
                   add_model(tree_spec) %>% 
                   add_recipe(tree_rec)
    ), 
    tar_target(tree_grid, create_tree_grid(tree_wfl)), 
    tar_target(tree_tune, tune_tree_grid(tree_wfl, folds, tree_grid))
    # Elastic net
    # SVM
)
