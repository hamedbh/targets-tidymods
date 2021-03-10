tune_rf_grid <- function(wfl, folds, levels = 5L) {
    grid <- wfl %>% 
        parameters() %>% 
        finalize(x = wfl %>% 
                     pluck(
                         "pre", "actions", "recipe", "recipe", "template"
                     ) %>% 
                     select(-outcome)
        ) %>% 
        grid_regular(levels = 5L)
    
    tune_grid(
        wfl,
        resamples = folds,
        grid = grid,
        metrics = metric_set(roc_auc),
        control = control_grid(verbose = TRUE, save_pred = TRUE)
    )
}
