#' Fast creation of dummy rows
#'
#' @param data
#' An object with the data set you want to make dummy columns from.
#' @param select_columns
#' If NULL (default), uses all character, factor, and Date columns to produce categories
#' to make the dummy rows by. If not NULL, you manually enter a string or vector of strings of columns name(s).
#' @param dummy_value
#' Value of the row for columns that are not selected.
#' Default is a value of 0.
#' @param dummy_indicator
#' Adds binary column to say if row is dummy or not (i.e. included in
#' original data or not)
#'
#' @return
#' A data.frame with same number of columns as inputted data and original
#' rows plus the newly created dummy rows
#' @export
#'
dummy_rows <- function(data,
                       select_columns = NULL,
                       dummy_value = NA,
                       dummy_indicator = FALSE) {

  if (!data.table::is.data.table(data)) {
    data <- data.table::as.data.table(data)
  }

  # Finds class of every column and keeps character, factor, and Date --------
  if (is.null(select_columns)) {
    char_cols <- sapply(data, class)
    char_cols <- names(data)[char_cols %in%
                               c("character", "factor", "Date")]
    if (length(char_cols) == 0) {
      stop("No character, factor, or Date columns found.")
    }

  } else {
    char_cols <- select_columns
  }


  other_cols <- names(data)[!names(data) %in% char_cols]

  # Finds how many possible combinations of the variables there are.
  # This will be the number of rows in the new data
  total_length <- prod(sapply(data[, char_cols, with = FALSE],
                              data.table::uniqueN))


  # Makes an empty data.table with right # of rows and columns. -------------

  temp_table <- data.table::data.table(matrix(nrow = total_length,
                                              ncol = length(data)))
  names(temp_table) <- names(data)


  # Fills in all possible combination rows ----------------------------------
    for (i in char_cols) {
      data.table::set(temp_table, j = i,
                      value = rep(sort(unique(data[[i]])),
                                  total_length /
                                    data.table::uniqueN(data[[i]])))
      temp_table <- data.table::setorderv(temp_table, i)
    }

  # Adds the dummy variable columns (and indicator) -------------------------

  for (i in other_cols) {
    data.table::set(temp_table, j = i, value = rep(dummy_value, nrow(temp_table)))
  }

  if (dummy_indicator) {
    data.table::alloc.col(temp_table, ncol(temp_table) + 1) # Adding extra column
    data.table::set(data, j = "dummy_indicator", value = 0)
    data.table::set(temp_table, j = "dummy_indicator", value = rep(1, nrow(temp_table)))
  }


  # Stacks new data on old data
  data <- data.table::rbindlist(list(data, temp_table), use.names = TRUE)

  # Removes rows that were in original data. --------------------------------
  data.table::set(data, j = "temporary_pasting",
                  value = do.call(paste0, data[, char_cols, with = FALSE]))
  data <- data[!duplicated(data, by = "temporary_pasting"),]
  data.table::set(data, j = "temporary_pasting", value = NULL)


  data <- as.data.frame(data)
  return(data)

}
