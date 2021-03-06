#' Read the raw German Credit data
#' 
#' Wrapper around [readr::read_delim()] with column names and types preset. 
#'
#' @param path The path to the file
#'
#' @return
#' @export
#'
#' @examples
read_raw_data <- function(data_path) {
    # column names taken from the data dictionary, slightly changed to keep
    # lengths reasonable
    column_names <- c(
        "acct_status",
        "duration",
        "credit_history",
        "purpose",
        "amount",
        "savings_acct",
        "present_emp_since",
        "pct_of_income",
        "sex_status",
        "other_debtor_guarantor",
        "resident_since",
        "property",
        "age",
        "other_debts",
        "housing",
        "num_existing_credits",
        "job",
        "num_dependents",
        "telephone",
        "foreign_worker",
        "outcome"
    )
    # set the column types manually to avoid any coercion errors
    column_types <- c("ciccicciccicicciciccc")
    
    readr::read_delim(
        data_path,
        delim = " ",
        col_names = column_names,
        col_types = column_types
    )
    
}
