#' Fast creation of dummy rows
#'
#' dummy_rows() quickly creates dummy rows to fill in missing rows
#' based on all combinations of available character, factor, and
#' date columns (if not otherwise specified). This is useful for
#' creating balanced panel data. Columns that are not character,
#' factor, or dates are filled in with NA (or whatever value you
#' specify).
#'
#' @family dummy functions
#' @seealso \code{\link{dummy_cols}} For creating dummy columns
#'
#' @param .data
#' An object with the data set you want to make dummy columns from.
#' @param select_columns
#' If NULL (default), uses all character, factor, and Date columns to produce categories
#' to make the dummy rows by. If not NULL, you manually enter a string or vector of strings of columns name(s).
#' @param dummy_value
#' Value of the row for columns that are not selected.
#' Default is a value of NA.
#' @param dummy_indicator
#' Adds binary column to say if row is dummy or not (i.e. included in
#' original data or not)
#'
#' @return
#' A data.frame (or tibble or data.table, depending on input data type) with
#' same number of columns as inputted data and original rows plus the newly
#' created dummy rows
#' @export
#' @examples
#' crime <- data.frame(city = c("SF", "SF", "NYC"),
#'     year = c(1990, 2000, 1990),
#'     crime = 1:3)
#'
#' dummy_rows(crime)
#' # Include year column
#' dummy_rows(crime, select_columns = c("city", "year"))
#' # m=Make dummy value 0
#' dummy_rows(crime, select_columns = c("city", "year"),
#'     dummy_value = 0)
#' # Add a dummy indicator
#' dummy_rows(crime, select_columns = c("city", "year"),
#'     dummy_indicator = TRUE)
dummy_rows <- function(.data,
                       select_columns = NULL,
                       dummy_value = NA,
                       dummy_indicator = FALSE) {
  stopifnot(is.null(select_columns) || is.character(select_columns),
            select_columns != "",
            is.logical(dummy_indicator), length(dummy_indicator) == 1,
            length(dummy_value) == 1)

  if (is.atomic(.data) || ncol(.data) == 1) {
    stop("Cannot make dummy rows of a vector of one column data.frame/table.")
  }

  data_type <- check_type(.data)

  if (!data.table::is.data.table(.data)) {
    .data <- data.table::as.data.table(.data)
  }



  # Finds class of every column and keeps character, factor, and Date --------
  if (is.null(select_columns)) {
    char_cols_class <- sapply(.data, class)
    char_cols <- c()
    for (i in 1:length(char_cols_class)) {
      char_col_i <- char_cols_class[[i]]

      if (any(char_col_i %in% c("character", "factor", "Date", "ordered"))) {
        char_cols <- c(char_cols, names(.data)[i])
      }
    }
    # char_cols <- names(.data)[char_cols %in%
    #                            c("character", "factor", "Date", "ordered")]
    if (length(char_cols) == 0) {
      stop("No character, factor, or Date columns found. Please use select_columns")
    }

  } else {
    char_cols <- select_columns
  }

  other_cols <- names(.data)[!names(.data) %in% char_cols]


  # Finds how many possible combinations of the variables there are.
  # This will be the number of rows in the new data
  total_length <- prod(sapply(.data[, char_cols, with = FALSE, drop = FALSE],
                              data.table::uniqueN))
  # Makes an empty data.table with right # of rows and columns. -------------
  temp_table <- data.table::data.table(matrix(nrow = total_length,
                                              ncol = ncol(.data)))
  names(temp_table) <- names(.data)

  # Fills in all possible combination rows ----------------------------------
  for (i in char_cols) {
    data.table::set(temp_table, j = i,
                    value = rep(unique(.data[[i]]), times =
                                  total_length /
                                  data.table::uniqueN(.data[[i]])))
    temp_table <- data.table::setorderv(temp_table, i)
  }

  # Adds the dummy variable columns (and indicator) -------------------------
  for (i in other_cols) {
    data.table::set(temp_table, j = other_cols,
                    value = rep(dummy_value, nrow(temp_table)))
  }

  if (dummy_indicator) {
    # Adding extra column
    data.table::alloc.col(temp_table, ncol(temp_table) + 1)
    data.table::alloc.col(.data, ncol(.data) + 1)

    data.table::set(.data, j = "dummy_indicator", value = 0L)
    data.table::set(temp_table, j = "dummy_indicator",
                    value = rep(1L, nrow(temp_table)))
  }

  # Removes rows that were in original data. --------------------------------
  data_temp_pasting <- do.call(paste0, .data[, char_cols, with = FALSE,
                                             drop = FALSE])
  temp_temp_pasting <- do.call(paste0, temp_table[, char_cols, with = FALSE,
                                                  drop = FALSE])
  temp_table <- subset(temp_table, !temp_temp_pasting %in% data_temp_pasting)

  # Stacks new data on old data
  if (nrow(temp_table) > 0) {
    .data <- data.table::rbindlist(list(.data, temp_table), use.names = TRUE,
                                   fill = TRUE)
  }

  .data <- fix_data_type(.data, data_type)
  return(.data)

}
