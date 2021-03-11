create_rf_wfl <- function(rec) {
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
        add_recipe(rec)
}
