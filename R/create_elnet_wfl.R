create_elnet_wfl <- function(rec) {
    workflow() %>% 
        add_model(
            logistic_reg(penalty = tune(), mixture = tune()) %>% 
                set_engine("glmnet")
        ) %>% 
        add_recipe(rec)
}