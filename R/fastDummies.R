#' Fast creation of dummy variables
#'
#' @param dataset
#' data.table or data.frame
#'
#' @param select_columns
#' Vector of column names that you want to create dummy variables from.
#' Default uses all character or factor columns.
#' @param ignore_columns
#' Vector of column names to ignore. Default already ignores numeric columns.
#' @param remove_original
#' Removes the columns used to make dummy variables.
#' Columns that are not used to make dummy variables are not affected.
#' @param dummy_columns_only
#' Removes all columns not to create dummy columns (i.e. numeric columns).
#' @param return_type
#' Type of data you want back. Default is data.table (better for use
#' with large data). Other options are data.frame or matrix.
#'
#' @return
#' data.table, data.frame, or matrix depending on input for return_type.
#' data.table is default.
#' @export
#'
#' @examples
#' data(dummies.example)
#' fastDummy(dummies.example)
#'
#' # Return data.frame
#' fastDummy(dummies.example, return_type = "data.frame")
#'
#' # Only keep created dummy columns
#' fastDummy(dummies.example, dummy_columns_only = TRUE)
#'
#' # Only keep SEX and RACE columns
#' fastDummy(dummies.example, select_columns = c("Sex", "RACE"))
#'
#' # Keep all except SEX column
#' fastDummy(dummies.example, ignore_columns = "SEX")
fastDummy <- function(dataset,
                    select_columns = NULL,
                    ignore_columns = NULL,
                    remove_original = TRUE,
                    dummy_columns_only = FALSE,
                    return_type = "data.table") {

  if (!return_type %in% c("data.table", "data.frame", "matrix")) {
    stop("Return type must be 'data.table', 'data.frame', or 'matrix'")
  }

  if (!data.table::is.data.table(dataset)) {
    dataset <- data.table::as.data.table(dataset)
  }

  if (!is.null(select_columns) && !is.character(select_columns)) {
    stop("select_columns input must be characters")
  }

  if (!is.null(ignore_columns) && !is.character(ignore_columns)) {
    stop("ignore_columns input must be characters")
  }


  char_cols <- names(dataset)[sapply(dataset, class) %in%
                                c("character", "factor")]

  if (!is.null(select_columns)) {
    char_cols <- select_columns
    char_cols <- char_cols[char_cols %in% names(dataset)]
    if (length(char_cols) == 0) {
      stop("No remaining columns. Please use correct column names.")
    }
  }

  if (!is.null(ignore_columns)) {
    char_cols <- char_cols[!char_cols %in% ignore_columns]
    if (length(char_cols) == 0) {
      stop("No remaining columns. Please use correct column names.")
    }
  }

  if (dummy_columns_only) {
    to_remove <- names(dataset)[!names(dataset) %in% char_cols]
    dataset[, (to_remove) := NULL]
  }

  for (col_name in char_cols) {
    unique_vals <- unique(dataset[, get(col_name)])
    dataset[, (paste0(col_name, "_", unique_vals)) := 0]
    for (unique_values in unique_vals) {
      dataset[get(col_name) == unique_values,
              (paste0(col_name, "_", unique_values)) := 1]
    }
  }

  if (remove_original) {
    dataset[, (char_cols) := NULL]
  }

  if (return_type == "data.table") {
    return(dataset)
  } else if (return_type == "data.frame") {
    return(as.data.frame(dataset))
  } else if (return_type == "matrix") {
    return(as.matrix(dataset))
  }
}

#' United States Census data for 2015
#'
#' A dataset containing Census results from the American Community Survey 2015
#'
#' @format A data frame with 100000 rows and 17 variables:
#' \describe{
#'   \item{YEAR}{Year of surey}
#'   \item{STATEFIP}{FIP ID for the state}
#'   \item{COUNTYFIPS}{FIP ID for the county}
#'   \item{OWNERSHP}{If the respondent owns their home}
#'   \item{PERWT}{Survey weight for the respondent}
#'   \item{NCHILD}{Number of children in the home}
#'   \item{SEX}{Sex of the respondent}
#'   \item{AGE}{Age of the respondent}
#'   \item{MARST}{Marital status of the respondent}
#'   \item{RACE}{Race of the respondent}
#'   \item{HISPAN}{If the respondent is hispanic}
#'   \item{BPL}{Birthplace of the respondent}
#'   \item{EDUC}{Education of the respondent}
#'   \item{EMPSTAT}{Employment status of the respondent}
#'   \item{FTOTINC}{Family yearly income}
#'   \item{POVERTY}{If they are below the poverty line}
#'   \item{MOVEDIN}{When the respondent moved into their home}
#' }
#' @source \url{https://usa.ipums.org/usa/index.shtml/}
"dummies.example"
