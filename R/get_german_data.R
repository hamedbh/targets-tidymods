##' Download the German Credit dataset
##'
##' Creates the directory given as `dir` to contain the German Credit data,
##' downloaded from the UCI Machine Learning Library. 
#'
#' @param dir Directory in which to save the data. 
#' @param url The URL for the data. 
#'
#' @return The path to which the file was saved. 

get_german_data <- function(
    dir, 
    url = "https://archive.ics.uci.edu/ml/machine-learning-databases/statlog/german/german.data"
) {
    fs::dir_create(dir)
    full_path <- paste0(dir, "/", basename(url))
    download.file(url, full_path)
    full_path
}
