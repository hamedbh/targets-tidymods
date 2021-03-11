create_tree_wfl <- function(rec) {
    workflow() %>% 
        add_model(
            decision_tree(
                mode = "classification", 
                min_n = tune(), 
                cost_complexity = tune()
            ) %>% 
                set_engine("rpart")
        ) %>% 
        add_recipe(rec)
}