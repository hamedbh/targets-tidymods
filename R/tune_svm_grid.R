tune_svm_grid <- function(wfl, folds, size = 16L) {
    grid <- wfl %>% 
        parameters() %>% 
        grid_max_entropy(size = size)
    
    tune_grid(
        wfl,
        resamples = folds,
        grid = grid,
        metrics = metric_set(roc_auc),
        control = control_grid(verbose = TRUE, save_pred = TRUE)
    )
}