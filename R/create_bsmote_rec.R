create_bsmote_rec <- function(base_rec) {
    base_rec %>% 
        step_normalize(all_numeric(), -all_outcomes()) %>% 
        step_novel(all_nominal(), -all_outcomes()) %>% 
        step_dummy(all_nominal(), -all_outcomes(), one_hot = TRUE) %>% 
        step_zv(all_predictors(), skip = TRUE) %>% 
        step_bsmote(outcome, all_neighbors = FALSE)
}
