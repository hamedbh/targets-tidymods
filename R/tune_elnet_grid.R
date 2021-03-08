tune_elnet_grid <- function(wfl, folds, levels = 16L) {
    grid <- wfl %>% 
        parameters() %>% 
        grid_regular(levels = levels)
    
    tune_grid(
        wfl,
        resamples = folds,
        grid = grid,
        metrics = metric_set(roc_auc),
        control = control_grid(verbose = TRUE, save_pred = TRUE)
    )
}