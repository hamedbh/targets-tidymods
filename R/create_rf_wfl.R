create_rf_wfl <- function(base_rec) {
    workflow() %>% 
        add_model(
            rand_forest(
                mode = "classification", 
                mtry = tune(), 
                trees = 512L, 
                min_n = tune()
            ) %>% 
                set_engine("ranger")
        ) %>% 
        add_recipe(
            base_rec %>% 
                step_zv(all_predictors(), skip = TRUE)
        )
}
