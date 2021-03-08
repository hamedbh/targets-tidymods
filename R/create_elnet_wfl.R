create_elnet_wfl <- function(base_rec) {
    workflow() %>% 
        add_model(
            logistic_reg(penalty = tune(), mixture = tune()) %>% 
                set_engine("glmnet")
        ) %>% 
        add_recipe(
            base_rec %>% 
                step_normalize(all_numeric(), -all_outcomes()) %>% 
                step_novel(all_nominal(), -all_outcomes()) %>% 
                step_dummy(all_nominal(), -all_outcomes(), one_hot = TRUE) %>% 
                step_zv(all_predictors(), skip = TRUE)
        )
}