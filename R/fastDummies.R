#' Fast creation of dummy variables
#'
#' @param dataset
#' data.table or data.frame
#'
#' @param select_columns
#' Vector of column names that you want to create dummy variables from.
#' Default uses all character or factor columns.
#' @param ignore_columns
#' Vector of column names to ignore_ Default ignores all numeric columns.
#' @param remove_original
#' Removes the columns used to make dummy variables.
#' Columns that are not used to make dummy variables are not affected.
#' @param dummy_columns_only
#' Removes all columns that didn't create dummy columns (i_e_ numeric columns).
#' @param remove_first_dummy
#' Removes the first dummy of every variable that only n-1 Dummies remain
#' @param return_type
#' Type of data you want back_ Default is data.table (better for use
#' with large data)_ Other options are data.frame or matrix.
#' @param conditional_columns
#' Select column(s) to multiple other dummy columns created by. Useful to get
#' subcategories of data. e.g. conditional column is gender and other columns
#' are crimes. This will create columns showing the number of each crime for
#' each gender.
#'
#' @return
#' data.table, data.frame, or matrix depending on input for return_type.
#' data.table is default.
#' @export
#'
#' @examples
#' data(dummies_example)
#' example <- fastDummy(dummies_example)
#'
#' # Return data.frame
#' example <- fastDummy(dummies_example, return_type = "data.frame")
#'
#' # Only keep created dummy columns
#' example <- fastDummy(dummies_example, dummy_columns_only = TRUE)
#'
#' # Only keep SEX and RACE columns
#' example <- fastDummy(dummies_example, select_columns = c("Sex", "RACE"))
#'
#' # Keep all except SEX column
#' example <- fastDummy(dummies_example, ignore_columns = "SEX")
#'
#' # Removes the first dummy from every category. Avoids perfect
#' # multicollinearity issues in models.
#' example <- fastDummy(dummies_example, remove_first_dummy = TRUE)
fastDummy <- function(dataset,
                    select_columns = NULL,
                    ignore_columns = NULL,
                    remove_original = TRUE,
                    dummy_columns_only = FALSE,
                    remove_first_dummy = FALSE,
                    conditional_columns = NULL,
                    return_type = "data.table") {

  if (!return_type %in% c("data.table", "data.frame", "matrix")) {
    stop("Return type must be 'data.table', 'data.frame', or 'matrix'")
  }

  if (!is.data.table(dataset)) {
    dataset <- as.data.table(dataset)
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
      stop("No remaining columns_ Please use correct column names_")
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

  conditional_names <- ''
  nonconditional_names <- ''
  for (col_name in char_cols) {
    unique_vals <- unique(dataset[, get(col_name)])

    if (remove_first_dummy) {
      unique_vals = unique_vals[-1]
    }

    if (col_name %in% conditional_columns) {
      conditional_names <- c(conditional_names,
                              paste0(col_name, "_", unique_vals))
    } else {
      nonconditional_names <- c(nonconditional_names,
                             paste0(col_name, "_", unique_vals))
    }
    dataset[, (paste0(col_name, "_", unique_vals)) := 0]
    for (unique_values in unique_vals) {
      dataset[get(col_name) == unique_values,
              (paste0(col_name, "_", unique_values)) := 1]
    }
  }
  nonconditional_names <- nonconditional_names[-1]
  conditional_names <- conditional_names[-1]

  if (remove_original) {
    dataset[, (char_cols) := NULL]
  }

  if (!is.null(conditional_columns) {
    for (conditional_cols in conditional_names) {
      for (nonconditional_columns in nonconditional_names) {
        dataset[, paste0(conditional_cols, "X", nonconditional_columns) :=
                  (get(conditional_cols) * get(nonconditional_columns))]
      }
    }
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
#' @format A data frame with 100,000 rows and 17 variables:
#' \describe{
#'   \item{YEAR}{Year of the survey}
#'   \item{STATEFIP}{FIPS ID for the state}
#'   \item{COUNTYFIPS}{FIPS ID for the county}
#'   \item{OWNERSHP}{Respondent's ownership status for their home}
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
#' @source \url{https://usa.ipums.org/usa-action/variables/group}
"dummies_example"
