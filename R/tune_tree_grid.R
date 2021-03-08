tune_tree_grid <- function(wfl, folds, grid) {
    tune_grid(
        wfl,
        resamples = folds,
        grid = grid,
        metrics = metric_set(roc_auc),
        control = control_grid(verbose = TRUE, save_pred = TRUE)
    )
}