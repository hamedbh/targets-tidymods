tune_rf_grid <- function(wfl, folds, levels = 5L) {
    
    grid <- grid_regular(
        list(
            mtry = mtry(range = c(1L, 5L)), 
            min_n = min_n()
        ), 
        levels = levels
    )
    
    tune_grid(
        wfl,
        resamples = folds,
        grid = grid,
        metrics = metric_set(roc_auc),
        control = control_grid(verbose = TRUE, save_pred = TRUE)
    )
}