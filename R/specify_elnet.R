specify_elnet <- function() {
    logistic_reg(penalty = tune(), mixture = tune()) %>% 
        set_engine("glmnet")
}