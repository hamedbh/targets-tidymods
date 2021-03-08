create_svm_wfl <- function(base_rec) {
    workflow() %>%
        add_model(
            svm_rbf(
                cost = tune(),
                rbf_sigma = tune(),
                mode = "classification"
            ) %>%
                set_engine("kernlab")
        ) %>%
        add_recipe(
            base_rec %>%
                step_novel(all_nominal(),-all_outcomes()) %>%
                step_dummy(all_nominal(),-all_outcomes(), one_hot = TRUE) %>%
                step_normalize(all_numeric(),-all_outcomes()) %>%
                step_zv(all_predictors(), skip = TRUE)
        )
}