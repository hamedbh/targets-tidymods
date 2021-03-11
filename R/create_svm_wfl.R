create_svm_wfl <- function(rec) {
    workflow() %>%
        add_model(
            svm_rbf(
                cost = tune(),
                rbf_sigma = tune(),
                mode = "classification"
            ) %>%
                set_engine("kernlab")
        ) %>%
        add_recipe(rec)
}