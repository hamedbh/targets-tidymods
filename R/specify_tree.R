#' Specify a decision tree model spec
#'
#' This is a wrapper around [parsnip::decision_tree()] to create a model
#' specification. This way the code is kept out of the `_targets.R` file. 
#'
#' @return A parsnip model spec object. 

specify_tree <- function() {
    decision_tree(
        mode = "classification", 
        tree_depth = tune(), 
        min_n = tune(), 
        cost_complexity = tune()
    )
}