##' Download the German Credit dataset
##'
##' Creates the directory given as `dir` to contain the German Credit data,
##' downloaded from the UCI Machine Learning Library. 
##'
##' @title
##' @param dir
##' @param filename
##' @return
##' @author hamedbh
##' @export
get_german_data <- function(url, dir) {
    fs::dir_create(dir)
    full_path <- paste0(dir, "/", basename(url))
    download.file(
        url, 
        full_path
    )
    full_path
}
