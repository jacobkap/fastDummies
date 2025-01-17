#' Fast creation of dummy variables
#'
#' Quickly create dummy (binary) columns from character and
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
#' @param remove_selected_columns
#' If TRUE (not default), removes the columns used to generate the dummy columns.
#' @param omit_colname_prefix
#' If TRUE (not default) and `length(select_columns) == 1`, omit pre-pending the
#' name of `select_columns` to the names of the newly generated dummy columns
#'
#' @param return_generated_variables
#' If TRUE (not default), returns a vector of the names of the variables that
#' would be generated. Does not modify the inputted data.
#'
#' @return
#' A data.frame (or tibble or data.table, depending on input data type) with
#' same number of rows as inputted data and original columns plus the newly
#' created dummy columns.
#' @export
#' @examples
#' crime <- data.frame(
#'   city = c("SF", "SF", "NYC"),
#'   year = c(1990, 2000, 1990),
#'   crime = 1:3
#' )
#' dummy_cols(crime)
#' # Include year column
#' dummy_cols(crime, select_columns = c("city", "year"))
#' # Remove first dummy for each pair of dummy columns made
#' dummy_cols(crime,
#'   select_columns = c("city", "year"),
#'   remove_first_dummy = TRUE
#' )
dummy_cols <- function(.data,
                       select_columns = NULL,
                       remove_first_dummy = FALSE,
                       remove_most_frequent_dummy = FALSE,
                       ignore_na = FALSE,
                       split = NULL,
                       remove_selected_columns = FALSE,
                       omit_colname_prefix = FALSE,
                       return_generated_variables = FALSE) {
  old_columns <- names(.data)

  stopifnot(
    is.null(select_columns) || is.character(select_columns),
    select_columns != "",
    is.logical(remove_first_dummy), length(remove_first_dummy) == 1,
    is.logical(remove_selected_columns)
  )

  if (remove_first_dummy == TRUE & remove_most_frequent_dummy == TRUE) {
    stop("Select either 'remove_first_dummy' or 'remove_most_frequent_dummy'
         to proceed.")
  }

  if (is.vector(.data)) {
    .data <- data.frame(.data = .data, stringsAsFactors = FALSE)
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
    char_cols_class <- sapply(.data, class)
    char_cols <- c()
    for (i in 1:length(char_cols_class)) {
      char_col_i <- char_cols_class[[i]]

      if (any(char_col_i %in% c("character", "factor", "ordered"))) {
        char_cols <- c(char_cols, names(.data)[i])
      }
    }
    #  char_cols <- char_cols[char_cols %in% c("factor", "character")]
    #  char_cols <- names(char_cols)
  }

  if (length(char_cols) == 0 && is.null(select_columns)) {
    stop(paste0(
      "No character or factor columns found. ",
      "Please use select_columns to choose columns."
    ))
  }

  if (!is.null(select_columns) && length(cols_not_in_data) > 0) {
    warning(
      paste0(
        "NOTE: The following select_columns input(s) ",
        "is not a column in data.\n"
      ),
      paste0(names(cols_not_in_data), "\t")
    )
  }

  for (col_name in char_cols) {
    # If factor type, order by assigned levels
    if (is.factor(.data[[col_name]]) | is.ordered(.data[[col_name]])) {
      unique_vals <- levels(.data[[col_name]])
      if (any(is.na(.data[[col_name]]))) {
        unique_vals <- c(unique_vals, NA)
      }
      # Else by alphabetical order.
    } else {
      unique_vals <- unique(.data[[col_name]])
      unique_vals <- stringr::str_sort(unique_vals,
        na_last = TRUE,
        locale = "en_US",
        numeric = TRUE
      )
    }
    unique_vals <- as.character(unique_vals)

    # If there is a split value, splits up the unique_vals by that value
    # and keeps only the unique ones.
    if (!is.null(split)) {
      unique_vals <- unique(trimws(unlist(strsplit(unique_vals, split = split))))
    }

    if (ignore_na) {
      unique_vals <- unique_vals[!is.na(unique_vals)]
    }

    if (remove_most_frequent_dummy) {
      vals <- as.character(.data[[col_name]])
      vals <- data.frame(sort(table(vals), decreasing = TRUE),
        stringsAsFactors = FALSE
      )
      # If there is a actual most frequent value, drop that value. Else,
      # if there is a tie, drop the one that's first alphabetically.
      top_vals <- vals[vals$Freq %in% max(vals$Freq), ]
      other_vals <- vals$vals[!vals$Freq %in% max(vals$Freq)]
      other_vals <- as.character(other_vals)
      top_vals <- top_vals[stringr::str_order(top_vals$vals,
        na_last = TRUE,
        locale = "en_US",
        numeric = TRUE
      ), ]
      if (nrow(top_vals) == 1) {
        top_vals <- NULL
      } else {
        top_vals <- as.character(top_vals$vals[2:nrow(top_vals)])
      }

      unique_vals <- c(top_vals, other_vals)
      unique_vals <- stringr::str_sort(unique_vals,
        na_last = TRUE,
        locale = "en_US",
        numeric = TRUE
      )
    }

    if (remove_first_dummy) {
      unique_vals <- unique_vals[-1]
    }




    data.table::alloc.col(.data, ncol(.data) + length(unique_vals))

    .data[, paste0(col_name, "_", unique_vals)] <- 0L
    for (unique_value in unique_vals) {
      data.table::set(.data,
        i =
          which(data.table::chmatch(
            as.character(.data[[col_name]]),
            unique_value,
            nomatch = 0
          ) == 1L),
        j = paste0(col_name, "_", unique_value), value = 1L
      )


      # Sets NA values to NA, only for columns that are not the NA columns
      if (!is.na(unique_value)) {
        data.table::set(.data,
          i =
            which(is.na(.data[[col_name]])),
          j = paste0(col_name, "_", unique_value), value = NA
        )
      }

      if (!is.null(split)) {
        max_split_length <- max(sapply(strsplit(as.character(.data[[col_name]]),
          split = split
        ), length))
        for (split_length in 1:max_split_length) {
          data.table::set(.data,
            i =
              which(data.table::chmatch(
                as.character(trimws(sapply(
                  strsplit(as.character(.data[[col_name]]),
                    split = split
                  ),
                  `[`, split_length
                ))),
                unique_value,
                nomatch = 0
              ) == 1L),
            j = paste0(col_name, "_", unique_value), value = 1L
          )
        }
        if (is.na(unique_value)) {
          .data[[paste0(col_name, "_", unique_value)]][which(!is.na(.data[[col_name]]))] <- 0
        }
      }
    }
  }

  if (remove_selected_columns) {
    .data <- .data[-which(names(.data) %in% char_cols)]
  }

  .data <- fix_data_type(.data, data_type)
  if (omit_colname_prefix) {
    if (length(select_columns) == 1) {
      new_col_index <-
        as.logical(rowSums(sapply(unique_vals, function(x) {
          grepl(paste0(select_columns, "_", x), names(.data))
        })))
      names(.data)[new_col_index] <-
        gsub(paste0(select_columns, "_"), "", names(.data)[new_col_index])
    } else {
      message("Can't omit the colname prefix when recoding more than one column.")
      message("Returning prefixed dummy columns.")
    }
  }

  if (return_generated_variables) {
    new_columns <- names(.data)
    new_columns <- new_columns[!new_columns %in% old_columns]
    return(new_columns)
  }

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
#' crime <- data.frame(
#'   city = c("SF", "SF", "NYC"),
#'   year = c(1990, 2000, 1990),
#'   crime = 1:3
#' )
#' dummy_cols(crime)
#' # Include year column
#' dummy_cols(crime, select_columns = c("city", "year"))
#' # Remove first dummy for each pair of dummy columns made
#' dummy_cols(crime,
#'   select_columns = c("city", "year"),
#'   remove_first_dummy = TRUE
#' )
dummy_columns <- dummy_cols
