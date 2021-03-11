create_svm_rec <- function(base_rec) {
    base_rec %>%
        step_novel(all_nominal(),-all_outcomes()) %>%
        step_dummy(all_nominal(),-all_outcomes(), one_hot = TRUE) %>%
        step_normalize(all_numeric(),-all_outcomes()) %>%
        step_zv(all_predictors(), skip = TRUE)
}
