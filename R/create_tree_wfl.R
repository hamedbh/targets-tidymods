create_tree_wfl <- function(base_rec) {
    workflow() %>% 
        add_model(
            decision_tree(
                mode = "classification", 
                min_n = tune(), 
                cost_complexity = tune()
            ) %>% 
                set_engine("rpart")
        ) %>% 
        add_recipe(
            base_rec %>% 
                step_zv(all_predictors(), skip = TRUE)
        )
}