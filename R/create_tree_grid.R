create_tree_grid <- function(wfl, size = 16L) {
    wfl %>% 
        parameters() %>% 
        grid_max_entropy(size = size)
}
