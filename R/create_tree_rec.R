create_tree_rec <- function(base_rec) {
    base_rec %>% 
        step_zv(all_predictors(), skip = TRUE)
}
