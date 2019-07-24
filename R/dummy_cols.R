#' Fast creation of dummy variables
#'
#' dummy_cols() quickly creates dummy (binary) columns from character and
#' factor type columns in the inputted data (and numeric columns if specified.)
#' This function is useful for statistical analysis when you want binary
#' columns rather than character columns.
#'
#' @family dummy functions
#' @seealso \code{\link{dummy_rows}} For creating dummy rows
#'
#' @param .data
#' An object with the data set you want to make dummy columns from.
#' @param select_columns
#' Vector of column names that you want to create dummy variables from.
#' If NULL (default), uses all character and factor columns.
#' @param remove_first_dummy
#' Removes the first dummy of every variable such that only n-1 dummies remain.
#' This avoids multicollinearity issues in models.
#' @param remove_most_frequent_dummy
#' Removes the most frequently observed category such that only n-1 dummies
#' remain. If there is a tie for most frequent, will remove the first
#' (by alphabetical order) category that is tied for most frequent.
#' @param sort_columns
#' Sorts columns following factor order.
#' @param ignore_na
#' If TRUE, ignores any NA values in the column. If FALSE (default), then it
#' will make a dummy column for value_NA and give a 1 in any row which has a
#' NA value.
#' @param split
#' A string to split a column when multiple categories are in the cell. For
#' example, if a variable is Pets and the rows are "cat", "dog", and "turtle",
#' each of these pets would become its own dummy column. If one row is "cat, dog",
#' then a split value of "," this row would have a value of 1 for both the cat
#' and dog dummy columns.
#'
#' @return
#' A data.frame (or tibble or data.table, depending on input data type) with
#' same number of rows as inputted data and original columns plus the newly
#' created dummy columns.
#' @export
#' @examples
#' crime <- data.frame(city = c("SF", "SF", "NYC"),
#'     year = c(1990, 2000, 1990),
#'     crime = 1:3)
#' dummy_cols(crime)
#' # Include year column
#' dummy_cols(crime, select_columns = c("city", "year"))
#' # Remove first dummy for each pair of dummy columns made
#' dummy_cols(crime, select_columns = c("city", "year"),
#'     remove_first_dummy = TRUE)
dummy_cols <- function(.data,
                       select_columns = NULL,
                       remove_first_dummy = FALSE,
                       remove_most_frequent_dummy = FALSE,
                       sort_columns = FALSE,
                       ignore_na = FALSE,
                       split = NULL) {

  stopifnot(is.null(select_columns) || is.character(select_columns),
            select_columns != "",
            is.logical(remove_first_dummy), length(remove_first_dummy) == 1)

  if (remove_first_dummy == TRUE & remove_most_frequent_dummy == TRUE) {
    stop("Select either 'remove_first_dummy' or 'remove_most_frequent_dummy'
         to proceed.")
  }

  data_type <- check_type(.data)

  if (!data.table::is.data.table(.data)) {
    .data <- data.table::as.data.table(.data)
  }

  # Grabs column names that are character or factor class -------------------
  if (!is.null(select_columns)) {
    char_cols <- select_columns
    cols_not_in_data <- char_cols[!char_cols %in% names(.data)]
    char_cols <- char_cols[!char_cols %in% cols_not_in_data]
    if (length(char_cols) == 0) {
      stop("select_columns is/are not in data. Please check data and spelling.")
    }
  } else if (ncol(.data) == 1) {
    char_cols <- names(.data)
  } else {
    char_cols <- sapply(.data, class)
    char_cols <- char_cols[char_cols %in% c("factor", "character")]
    char_cols <- names(char_cols)
  }

  if (length(char_cols) == 0 && is.null(select_columns)) {
    stop(paste0("No character or factor columns found. ",
                "Please use select_columns to choose columns."))
  }

  if (!is.null(select_columns) && length(cols_not_in_data) > 0) {
    warning(paste0("NOTE: The following select_columns input(s) ",
                   "is not a column in data.\n"),
            paste0(names(cols_not_in_data), "\t"))
  }


  for (col_name in char_cols) {
    unique_vals <- as.character(unique(.data[[col_name]]))
    if (ignore_na) {
      unique_vals <- unique_vals[!is.na(unique_vals)]
    }

    if (remove_most_frequent_dummy) {
      vals <- as.character(.data[[col_name]])
      vals <- data.frame(sort(table(vals), decreasing = TRUE),
                         stringsAsFactors = FALSE)
      if (vals$Freq[1] > vals$Freq[2]) {
        vals <- as.character(vals$vals[2:nrow(vals)])
        unique_vals <- unique_vals[which(unique_vals %in% vals)]
        unique_vals <- vals[order(match(vals, unique_vals))]
      } else {
        remove_first_dummy <- TRUE
      }
    }

    if (remove_first_dummy) {
      unique_vals <- unique_vals[-1]
    }

    if (sort_columns) {
      idx <- stats::na.exclude(match(levels(.data[[col_name]]), unique_vals))
      unique_vals <- unique_vals[idx]
    }

    data.table::alloc.col(.data, ncol(.data) + length(unique_vals))
    data.table::set(.data, j = paste0(col_name, "_", unique_vals), value = 0L)
    for (unique_value in unique_vals) {
      data.table::set(.data, i =
                        which(data.table::chmatch(
                          as.character(.data[[col_name]]),
                          unique_value, nomatch = 0) == 1L),
                      j = paste0(col_name, "_", unique_value), value = 1L)

      if (!is.null(split)) {
        max_split_length <- max(sapply(strsplit(as.character(.data[[col_name]]),
                                                split = split), length))
        for (split_length in 1:max_split_length) {
          data.table::set(.data, i =
                            which(data.table::chmatch(
                              as.character(trimws(sapply(strsplit(as.character(.data[[col_name]]),
                                                                  split = split),
                                                         `[`, split_length))),
                              unique_value, nomatch = 0) == 1L),
                          j = paste0(col_name, "_", unique_value), value = 1L)

        }
        if (is.na(unique_value)) {
          .data[[paste0(col_name, "_", unique_value)]][which(!is.na(.data[[col_name]]))] <- 0
        }
      }
    }
  }

  .data <- fix_data_type(.data, data_type)
  return(.data)

}


#' Fast creation of dummy variables
#'
#' dummy_columns() quickly creates dummy (binary) columns from character and
#' factor type columns in the inputted data. This function is useful for
#' statistical analysis when you want binary columns rather than
#' character columns.
#'
#' @family dummy functions
#' @seealso \code{\link{dummy_rows}} For creating dummy rows
#'
#'
#' @inheritParams dummy_cols
#' @export
#' @examples
#' crime <- data.frame(city = c("SF", "SF", "NYC"),
#'     year = c(1990, 2000, 1990),
#'     crime = 1:3)
#' dummy_cols(crime)
#' # Include year column
#' dummy_cols(crime, select_columns = c("city", "year"))
#' # Remove first dummy for each pair of dummy columns made
#' dummy_cols(crime, select_columns = c("city", "year"),
#'     remove_first_dummy = TRUE)
dummy_columns <- dummy_cols
